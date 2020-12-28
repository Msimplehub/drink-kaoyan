package com.meta.framework.tenant;

import lombok.Data;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;

/**
 * TenantAlarmDto
 *
 * @author lidongzhang
 */
@Data
@Accessors(chain = true)
public class TenantAlarmDto implements Serializable {
    private static final long serialVersionUID = 1L;
    /**
     * mybatis mapper id
     */
    private String id;

    /**
     * mybatis sql（参数未填充）
     */
    private String sql;

    private String traceId;

    private Date addTime;
}
