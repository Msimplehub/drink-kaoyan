package com.meta.framework.util;

import lombok.extern.slf4j.Slf4j;

/**
 * @Description:
 * @Auther: M.simple
 * @Date: 2018/11/22 15:19
 * @author M.simple
 */
@Slf4j
public class BeanUtil {

    public static <T> T copyProperties(Class<T> clazz, Object source) throws RuntimeException {
        try {
            Object result = clazz.getDeclaredConstructor().newInstance();
            org.springframework.beans.BeanUtils.copyProperties(source, result);
            return (T) result;
        } catch (Exception e) {
            log.error("bean copy properties catch a exception, e:{}", e);
            throw new RuntimeException(e);
        }
    }


    public static <T> void copyProperties(Object source, T target) throws RuntimeException {
        try {
            org.springframework.beans.BeanUtils.copyProperties(source, target);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
