package com.meta.crm.intf.entity;

import java.io.Serializable;

import com.meta.framework.core.BaseEntity;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;


/**
 *
 */
@Data
public class CrmAssignUser extends BaseEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	    /**
	 *主键
	 */
    private Long id;

	/**
	 *责任人id
	 */
	@ApiModelProperty(value = "负责人ID")
    private Long managerId;

	/**
	 * 责任人类型
	 */
	@ApiModelProperty(value = "负责人类型")
	private Integer managerType;

	/**
	 *目标ID
	 */
	@ApiModelProperty(value = "负责目标ID")
    private Long targetId;

	/**
	 *目标类型
	 */
	@ApiModelProperty(value = "负责目标类型")
	private String targetType;

	/**
	 *责任人角色
	 */
	@ApiModelProperty(value = "责任人角色")
    private Integer assignRole;

}
