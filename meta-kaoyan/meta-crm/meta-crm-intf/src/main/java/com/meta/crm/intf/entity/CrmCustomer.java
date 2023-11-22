package com.meta.crm.intf.entity;

import com.meta.framework.core.BaseEntity;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;


/**
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:26
 */
@Data
public class CrmCustomer extends BaseEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    private Long id;

    /**
     * 客户名称
     */
    @ApiModelProperty(value = "客户名称")
    private String customerName;

    /**
     * 客户级别
     */
    @ApiModelProperty(value = "客户级别Code")
    private String customerLevel;

    /**
     * 客户来源
     */
    @ApiModelProperty(value = "客户来源Code")
    private String source;

    /**
     * 客户所在行业
     */
    @ApiModelProperty(value = "客户所在行业")
    private String profession;

    /**
	 *省code
	 */
    private Long provinceCode;

		/**
	 *cityCode
	 */
    private Long cityCode;

		/**
	 *区域code
	 */
    private Long regionCode;

    /**
     * 公司唯一标识
     */
    @ApiModelProperty(value = "公司唯一标识")
    private String companyId;

    /**
     * 公司地址
     */
    @ApiModelProperty(value = "公司地址")
    private String address;

    /**
     * 公司网址
     */
    @ApiModelProperty(value = "公司网址")
    private String url;

    /**
     * 公司人数
     */
    @ApiModelProperty(value = "公司人数")
    private Integer employeeNo;

    /**
     * 线索来源
     */
    @ApiModelProperty(value = "来源线索ID")
    private Long clueId;

    /**
     * 商机数量
     */
    @ApiModelProperty(value = "商机数量")
    private Integer businessCount;

    /**
     * 扩展信息
     */
    private String extInfo;

    /**
     * 备注
     */
    private String remark;

}
