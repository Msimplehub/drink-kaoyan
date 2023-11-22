package com.meta.crm.intf.entity;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.meta.framework.core.BaseEntity;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;


/**
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:26
 */
@Data
public class CrmContact extends BaseEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 主键
	 */
	private Long id;

	/**
	 * 联系人姓名
	 */
	@ApiModelProperty(value = "联系人姓名")
	private String name;

	/**
	 * 所属客户
	 */
	@ApiModelProperty(value = "所在客户ID")
	private Long customerId;

	/**
	 * 所属客户名称
	 */
	@ApiModelProperty(value = "所在客户名称")
	private String customerName;

	/**
	 * 部门
	 */
	@ApiModelProperty(value = "部门")
	private String apartment;

	/**
	 * 职务
	 */
	@ApiModelProperty(value = "职务")
	private String position;

	/**
	 * 手机号
	 */
	@ApiModelProperty(value = "手机号")
	private String mobile;

	/**
	 * 微信号
	 */
	@ApiModelProperty(value = "微信号")
	private String wechat;

	/**
	 * 性别
	 */
	@ApiModelProperty(value = "性别")
	private String sex;

	/**
	 * 生日
	 */
	@ApiModelProperty(value = "生日")
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date birthday;

	/**
	 * email
	 */
	@ApiModelProperty(value = "邮箱")
	private String email;

	/**
	 * 立场分
	 */
	@ApiModelProperty(value = "立场分")
	private Integer standScore;

	/**
	 * 扩展信息
	 */
	private String extInfo;


}
