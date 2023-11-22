package com.meta.crm.intf.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;


/**
 * 合同关系表
 * 
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-12-09 10:49:27
 */
@Data
public class CrmContractRelate implements Serializable {
	private static final long serialVersionUID = 1L;
	
	    /**
	 *自增主键
	 */
    private Long id;
	
		/**
	 *合同id
	 */
    private Long contractId;
	
		/**
	 *关联类型
	 */
    private String targetType;
	
		/**
	 *关联id
	 */
    private Long targetId;
	
		/**
	 *租户ID
	 */
    private Long tenantId;
	
		/**
	 *删除标志（0代表存在 1代表删除）
	 */
    private Integer delFlag;
	
		/**
	 *创建者
	 */
    private Long createBy;
	
		/**
	 *创建时间
	 */
    private Date createTime;
	
		/**
	 *更新者
	 */
    private Long updateBy;
	
		/**
	 *更新时间
	 */
    private Date updateTime;
	
		/**
	 *备注
	 */
    private String remark;
	
}
