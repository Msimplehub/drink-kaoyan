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
public class CrmTemplateStage extends BaseEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	
	    /**
	 *自增主键
	 */
    private Long id;
	
		/**
	 *子阶段编码
	 */
    private String code;
	
		/**
	 *父模板编码
	 */
    private String templateCode;
	
		/**
	 *父模板id
	 */
    private Long templateId;
	
		/**
	 *阶段名
	 */
    private String name;
	
		/**
	 *排序
	 */
    private Integer sort;
	
}
