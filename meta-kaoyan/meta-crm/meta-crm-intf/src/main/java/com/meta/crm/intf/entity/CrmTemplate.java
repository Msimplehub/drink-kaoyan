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
public class CrmTemplate extends BaseEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	
	    /**
	 *
	 */
    private Long id;
	
		/**
	 *模板编码
	 */
    private String code;
	
		/**
	 *模板名称
	 */
    private String name;
	
		/**
	 *生效状态 0否 1生效
	 */
    private Integer status;

}
