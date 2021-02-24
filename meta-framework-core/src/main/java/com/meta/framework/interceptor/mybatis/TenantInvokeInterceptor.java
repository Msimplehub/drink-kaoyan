package com.meta.framework.interceptor.mybatis;

import com.alibaba.fastjson.JSON;
import com.meta.framework.common.utils.SecurityUtils;
import com.meta.framework.common.utils.StringUtils;
import com.meta.framework.common.utils.bean.BeanUtils;
import com.meta.framework.util.TenantUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.binding.MapperMethod;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.session.RowBounds;
import org.springframework.util.ClassUtils;
import org.springframework.util.CollectionUtils;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

/**
 * mybatis 参数拦截器
 *
 * @Title: MybatisInputChangeInterceptor
 * @Package: com.meta.framework.act.framework.interceptor.mybatis.MybatisInputChangeInterceptor
 * @Author: M.simple
 * @Remark: The modified content
 * @CreateDate: 2020/11/14 1:59 下午
 * @Version: v2.0
 */
@Slf4j
@Intercepts({
		@Signature(type = ParameterHandler.class, method = "setParameters", args = PreparedStatement.class),
		@Signature(type = Executor.class, method = "update", args = {MappedStatement.class, Object.class}),
		@Signature(type = Executor.class, method = "createCacheKey", args = {MappedStatement.class, Object.class, RowBounds.class, BoundSql.class})
}
)
public class TenantInvokeInterceptor implements Interceptor {

	private static final String PARAM_KEY = "tenantId";

	@Override
	public Object intercept(Invocation invocation) throws Throwable {
		log.debug("---------进入拦截器");
		if (TenantUtils.isTenantSkip(invocation)) {
			return invocation.proceed();
		}

		// 拦截 Executor 的 update 方法 生成sql前将 tenantId 设置到实体中
		if (invocation.getTarget() instanceof Executor && invocation.getArgs().length == 2) {
			return invokeUpdate(invocation);
		}
		/** 拦截 Executor 的 createCacheKey 方法，
		 pageHelper插件会拦截 query 方法，
		 调用此方法，提前将参数设置到参数集合中
		 **/
		if (invocation.getTarget() instanceof Executor && invocation.getArgs().length == 4) {
			return invokeCacheKey(invocation);
		}
		//拦截 ParameterHandler 的 setParameters 方法 动态设置参数
		if (invocation.getTarget() instanceof ParameterHandler) {
			return invokeSetParameter(invocation);
		}
		return null;
	}

	private Object invokeCacheKey(Invocation invocation) throws Exception {
		Executor executor = (Executor) invocation.getTarget();
		MappedStatement ms = (MappedStatement) invocation.getArgs()[0];
		if (ms.getSqlCommandType() != SqlCommandType.SELECT) {
			return invocation.proceed();
		}

		Object parameterObject = invocation.getArgs()[1];
		RowBounds rowBounds = (RowBounds) invocation.getArgs()[2];
		BoundSql boundSql = (BoundSql) invocation.getArgs()[3];

		List<String> paramNames = new ArrayList<>();
		boolean hasKey = hasParamKey(paramNames, boundSql.getParameterMappings());

		if (!hasKey) {
			return invocation.proceed();
		}
		// 改写参数
		parameterObject = processSingle(parameterObject, paramNames);

		return executor.createCacheKey(ms, parameterObject, rowBounds, boundSql);
	}

	private Object invokeUpdate(Invocation invocation) throws Exception {
		Executor executor = (Executor) invocation.getTarget();
		// 获取第一个参数
		MappedStatement ms = (MappedStatement) invocation.getArgs()[0];
		// 非 insert 语句 不处理
		if (ms.getSqlCommandType() != SqlCommandType.INSERT) {
			return invocation.proceed();
		}
		// mybatis的参数对象
		Object paramObj = invocation.getArgs()[1];
		if (paramObj == null) {
			return invocation.proceed();
		}

		// 插入语句只传一个基本类型参数, 不做处理
		if (ClassUtils.isPrimitiveOrWrapper(paramObj.getClass())
				|| String.class.isAssignableFrom(paramObj.getClass())
				|| Number.class.isAssignableFrom(paramObj.getClass())) {
			return invocation.proceed();
		}

		processParam(paramObj);
		return executor.update(ms, paramObj);
	}


	private Object invokeSetParameter(Invocation invocation) throws Exception {

		ParameterHandler parameterHandler = (ParameterHandler) invocation.getTarget();
		PreparedStatement ps = (PreparedStatement) invocation.getArgs()[0];

		// 反射获取 BoundSql 对象，此对象包含生成的sql和sql的参数map映射
		Field boundSqlField = parameterHandler.getClass().getDeclaredField("boundSql");
		boundSqlField.setAccessible(true);
		BoundSql boundSql = (BoundSql) boundSqlField.get(parameterHandler);

		List<String> paramNames = new ArrayList<>();
		// 若参数映射没有包含的key直接返回
		boolean hasKey = hasParamKey(paramNames, boundSql.getParameterMappings());
		if (!hasKey) {
			return invocation.proceed();
		}

		// 反射获取 参数对像
		Field parameterField = parameterHandler.getClass().getDeclaredField("parameterObject");
		parameterField.setAccessible(true);
		Object parameterObject = parameterField.get(parameterHandler);

		// 改写参数
		parameterObject = processSingle(parameterObject, paramNames);

		// 改写的参数设置到原parameterHandler对象
		parameterField.set(parameterHandler, parameterObject);
		parameterHandler.setParameters(ps);
		return null;
	}

	// 判断已生成sql参数映射中是否包含tenantId
	private boolean hasParamKey(List<String> paramNames, List<ParameterMapping> parameterMappings) {
		boolean hasKey = false;
		for (ParameterMapping parameterMapping : parameterMappings) {
			if (StringUtils.equals(parameterMapping.getProperty(), PARAM_KEY)) {
				hasKey = true;
			} else {
				paramNames.add(parameterMapping.getProperty());
			}
		}
		return hasKey;
	}

	private Object processSingle(Object paramObj, List<String> paramNames) throws Exception {

		Map<String, Object> paramMap = new MapperMethod.ParamMap<>();
		if (paramObj == null) {
			paramMap.put(PARAM_KEY, getTenantId());
			paramObj = paramMap;
			// 单参数 将 参数转为 map
		} else if (ClassUtils.isPrimitiveOrWrapper(paramObj.getClass())
				|| String.class.isAssignableFrom(paramObj.getClass())
				|| Number.class.isAssignableFrom(paramObj.getClass())) {
			if (paramNames.size() == 1) {
				paramMap.put(paramNames.iterator().next(), paramObj);
				paramMap.put(PARAM_KEY, getTenantId());
				paramObj = paramMap;
			}
		} else {
			processParam(paramObj);
		}

		return paramObj;
	}

	private void processParam(Object parameterObject) throws IllegalAccessException, InvocationTargetException, InvocationTargetException {

		// 处理参数对象  如果是 map 且map的key 中没有 tenantId，添加到参数map中
		// 如果参数是bean，反射设置值
		if (parameterObject instanceof Map) {
			Map map = (Map) parameterObject;
			map.putIfAbsent(PARAM_KEY, getTenantId());
			relectCollectionAddTenantId(map);
		} else {
			reflectObjectAddTenantId(parameterObject);
		}
	}

	private void relectCollectionAddTenantId(Map map) {

		try{
			List<Object> list = (List<Object>) map.get("list");
			if(!CollectionUtils.isEmpty(list)){
				list.forEach(x -> {
					reflectObjectAddTenantId(x);
				});
			}else {
				map.putIfAbsent(PARAM_KEY, getTenantId());
			}
		}catch (Exception e){
		log.error("--------relectCollectionAddTenantId------catch error:{}", JSON.toJSONString(e));
		}
	}

	private Long getTenantId() {
		Long tenantId = null;
		try{
			tenantId = SecurityUtils.getLoginUser().getTenantId();
		}catch (Exception e){
			log.error("--------invoke tenant Id ------catch error:{}", JSON.toJSONString(e));
		}
		return tenantId;
	}

	private void reflectObjectAddTenantId(Object parameterObject) {

		try{
			PropertyDescriptor ps = BeanUtils.getPropertyDescriptor(parameterObject.getClass(), PARAM_KEY);
			if (ps != null && ps.getReadMethod() != null && ps.getWriteMethod() != null) {
				Object value = ps.getReadMethod().invoke(parameterObject);
				if (value == null) {
					ps.getWriteMethod().invoke(parameterObject, getTenantId());
				}
			}
		}catch (Exception e){
			log.error("--------reflectObjectAddTenantId------catch error:{}", JSON.toJSONString(e));
		}
	}

	@Override
	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}

	@Override
	public void setProperties(Properties properties) {

	}
}
