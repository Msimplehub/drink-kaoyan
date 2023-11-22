package com.meta.crm.intf.cmd.customer;

import com.meta.crm.intf.entity.CrmCustomer;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class AddCustomerCmd extends CrmCustomer {

    @NotNull(message = "负责人不能为空")
    Long managerId;
    Integer managerType = 0;

    /**
     * 客户名称
     */
    @ApiModelProperty(value = "客户名称")
    @NotNull(message = "客户名称不能为空")
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
     * 来源线索
     */
    @ApiModelProperty(value = "来源线索ID")
    private Long clueId;

    /**
     * 扩展信息
     */
    private String extInfo;

    /**
     * 备注
     */
    private String remark;

}
