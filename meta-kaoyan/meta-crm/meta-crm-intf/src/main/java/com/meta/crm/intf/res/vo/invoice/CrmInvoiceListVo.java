package com.meta.crm.intf.res.vo.invoice;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
@ApiModel("开票列表出参")
public class CrmInvoiceListVo {
    @ApiModelProperty("发票id")
    private Long id;

    @ApiModelProperty("发票编号")
    private String invoiceNum;

    @ApiModelProperty("合同id")
    private Long contractId;

    @ApiModelProperty("合同名称")
    private String contractName;

    @ApiModelProperty("客户id")
    private Long customerId;

    @ApiModelProperty("客户名称")
    private String customerName;

    @ApiModelProperty("开票抬头")
    private String invoiceTitle;

    @ApiModelProperty("抬头类型")
    private String titleType;

    @ApiModelProperty("抬头类型描述")
    private String titleTypeDesc;

    @ApiModelProperty("开票类型")
    private String invoiceCreateType;

    @ApiModelProperty("开票类型描述")
    private String invoiceCreateTypeDesc;

    @ApiModelProperty("发票类型")
    private String invoiceType;

    @ApiModelProperty("发票类型描述")
    private String invoiceTypeDesc;

    @ApiModelProperty("税号")
    private String companyTaxNum;

    @ApiModelProperty("开票金额")
    private BigDecimal invoiceAmount;

    @ApiModelProperty("开票时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date invoiceDate;

    @ApiModelProperty("创建人id")
    private Long createUserId;

    @ApiModelProperty("创建人名称")
    private String createUserName;

    @ApiModelProperty("创建结束时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
}
