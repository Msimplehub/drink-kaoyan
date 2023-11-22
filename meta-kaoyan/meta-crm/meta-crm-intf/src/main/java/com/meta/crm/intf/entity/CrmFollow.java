package com.meta.crm.intf.entity;

import java.io.Serializable;

import com.meta.framework.core.BaseEntity;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;


/**
 *
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:26
 */
@Data
public class CrmFollow extends BaseEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 *主键
	 */
    private Long id;

	/**
	 *跟进目标类型（0，线索，1，客户，2联系人，3商机）
	 */
	@ApiModelProperty("跟进对象类型")
    private String targetType;

	/**
	 *跟进目标ID
	 */
	@ApiModelProperty("跟进对象ID")
    private Long targetId;

	/**
	 *记录类型（0，电话，1微信，2拜访）
	 */
	@ApiModelProperty("跟进记录类型")
    private String followType;

	/**
	 *记录子类型
	 */
	@ApiModelProperty("跟进记录子类型")
	private String followSubType;

	/**
	 *跟进内容
	 */
	@ApiModelProperty("跟进记录内容")
    private String content;

	/**
	 *文件列表
	 */
	@ApiModelProperty("文件列表JSON")
    private String files;

}
