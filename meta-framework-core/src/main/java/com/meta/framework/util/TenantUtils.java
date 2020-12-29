package com.meta.framework.util;

import com.meta.framework.common.annotation.TenantSkip;
import com.meta.framework.common.utils.reflect.ReflectUtils;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.scripting.defaults.DefaultParameterHandler;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

/**
 * TenantUtils
 *
 * @author lidongzhang
 */
public class TenantUtils {
    /**
     * 是否配置跳过注解
     *
     * @param invocation:
     * @return Boolean
     * @method isTenantSkip
     * @author M.simple
     * @date 2020/11/14 3:47 下午
     * @version v2.0
     */
    public static boolean isTenantSkip(Invocation invocation) throws ClassNotFoundException, InvocationTargetException, IllegalAccessException {
        if (invocation.getTarget() instanceof DefaultParameterHandler) {
            DefaultParameterHandler statementHandler = (DefaultParameterHandler) invocation.getTarget();
            MappedStatement mappedStatement = ReflectUtils.getFieldValue(statementHandler, "mappedStatement");
            if (mappedStatement != null && isTenantSkipAnno(mappedStatement)) return true;
        } else if (invocation.getArgs()[0] instanceof MappedStatement){
            MappedStatement mappedStatement = (MappedStatement) invocation.getArgs()[0];
            if (isTenantSkipAnno(mappedStatement)) return true;
        }
        return false;
    }

    public static boolean isTenantSkipAnno(MappedStatement mappedStatement) throws ClassNotFoundException {
        Class<?> classType = Class.forName(mappedStatement.getId().substring(0, mappedStatement.getId().lastIndexOf(".")));
        String mName = mappedStatement.getId().substring(mappedStatement.getId().lastIndexOf(".") + 1, mappedStatement.getId().length());
        for (Method method : classType.getDeclaredMethods()) {
            if (method.isAnnotationPresent(TenantSkip.class) && mName.equals(method.getName())) {
                return true;
            }
        }
        return false;
    }
}
