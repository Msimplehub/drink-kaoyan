/**
 * @title LogToPscAop.java
 * @package com.valueplus.invent.system.common.aop
 * @describe TODO
 * @author M.simple
 * @datetime 2017年7月12日 下午1:40:36
 * @version v1.0
 */
package com.meta.framework.aop;

import com.alibaba.fastjson.JSON;
import com.meta.framework.aop.define.MethodLogLevel;
import com.meta.framework.aop.define.anno.MethodLog;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;

/**
 * 平台日志切面
 * @className MethodLogAop
 * @author M.simple
 * @datetime 2019年4月26日 下午1:40:36
 */
@Aspect
@Component
public class MethodLogAop {

	private final static Logger LOGGER = LoggerFactory.getLogger("MethodLogAop");

	@Pointcut("@annotation(com.meta.framework.aop.define.anno.MethodLog)")
	public void logPointCut() {

	}

	/**
	 * 操作日志记录
	 * @method
	 * @param       joinPoint:
	 * @return
	 * @author M.simple
	 * @date 2019年4月26日
	 * @version v2.0
	 */
	@Around("logPointCut()")
	public Object doAround(ProceedingJoinPoint joinPoint) throws Throwable {

		Object result = null;

		try {
			MethodLogLevel methodLogLevel = MethodLogLevel.DEBUG;
			long beginTime = System.currentTimeMillis();
			//执行时长(毫秒)
			MethodSignature signature = (MethodSignature) joinPoint.getSignature();
			Method method = signature.getMethod();
			Class<?> declaringClass = method.getDeclaringClass();
			MethodLog sysLogAnnotation = method.getAnnotation(MethodLog.class);
			String methodName = signature.getName();
			try {

				Object[] args = joinPoint.getArgs();
				methodLogLevel = sysLogAnnotation.methodLogLevel();
				if (MethodLogLevel.DEBUG.getLevelName().equals(methodLogLevel.getLevelName())) {
					LOGGER.debug("---------START {}.{},req:{}", declaringClass.getName(), methodName, JSON.toJSONString(args));
				} else if (MethodLogLevel.INFO.getLevelName().equals(methodLogLevel.getLevelName())) {
					LOGGER.info("---------START {}.{},req:{}", declaringClass.getName(), methodName, JSON.toJSONString(args));
				}
			} catch (Exception e) {
				LOGGER.error("************excute before catch Exception, e", e);
			}
			//执行方法
			result = joinPoint.proceed();

			try {
				long time = System.currentTimeMillis() - beginTime;
				if (MethodLogLevel.DEBUG.getLevelName().equals(methodLogLevel.getLevelName())) {
					LOGGER.debug("---------END {}.{},res:{},cos time:{}", declaringClass.getName(), methodName, JSON.toJSONString(result), time);
				} else if (MethodLogLevel.INFO.getLevelName().equals(sysLogAnnotation.methodLogLevel().getLevelName())) {
					LOGGER.info("---------END {}.{},res:{}, cos time:{}", declaringClass.getName(), methodName, JSON.toJSONString(result), time);
				}
			} catch (Exception e) {
				LOGGER.error("************excute doAround after catch Exception, e", e);
			}
		} catch (Exception e) {
			LOGGER.error("************切面日志 catch Exception, e", e);
			throw e;
		}

		return result;
	}
}
