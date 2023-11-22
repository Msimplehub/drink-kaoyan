package com.meta.crm.intf.entity;

import java.io.Serializable;

import com.meta.framework.core.BaseEntity;
import lombok.Data;


/**
 * 
 * 
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:25
 */
@Data
public class CrmBusinessProcess extends BaseEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	
	    /**
	 *自增主键
	 */
    private Long id;
	
		/**
	 *商机id
	 */
    private Long businessId;
	
		/**
	 *阶段模板编号
	 */
    private String templateCode;
	
		/**
	 *阶段模板id
	 */
    private Long templateId;
	
		/**
	 *上一阶段
	 */
    private String beforeStageCode;
	
		/**
	 *下一阶段
	 */
    private String afterStageCode;
	
}
