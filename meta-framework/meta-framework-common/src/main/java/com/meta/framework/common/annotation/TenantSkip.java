package com.meta.framework.common.annotation;

import com.meta.framework.common.enums.TenantSkipE;

import java.lang.annotation.*;

/**
 *  租户逻辑过滤注解
 * @Title:      TenantSkip
 * @Package:    com.meta.framework.common.annotation.TenantSkip
 * @Author:     M.simple
 * @Remark:     The modified content
 * @CreateDate: 2020/11/14 3:27 下午
 * @Version:    v2.0
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface TenantSkip
{
    public TenantSkipE isSkip() default TenantSkipE.DEFAULT;

}
