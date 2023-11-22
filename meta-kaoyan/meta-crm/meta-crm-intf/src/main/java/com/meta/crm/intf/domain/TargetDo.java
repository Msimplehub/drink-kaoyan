package com.meta.crm.intf.domain;

import com.meta.crm.intf.enums.TargetType;

/**
 * 业务对象基础do
 */
public interface TargetDo {

    Long getTargetId();

    TargetType getTargetType();

    default String getTargetName(){
        return null;
    };

    /**
     * 用于跟进记录列表展示和跳转的名称
     * @return
     */
    default String getTableShowName(){
        return getTargetName();
    };
}
