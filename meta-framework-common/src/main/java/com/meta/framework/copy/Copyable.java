package com.meta.framework.copy;


import com.meta.framework.util.BeanUtil;

import java.io.Serializable;

/**
 * @description:
 * @auther: M.simple
 * @date: 2019/07/04 10:00
 */
public class Copyable implements Serializable {

    public <T> T transform(Class<T> clazz) {
        return BeanUtil.copyProperties(clazz, this);
    }

    public <T> T transform(T target) {
        BeanUtil.copyProperties(this, target);
        return target;
    }

}
