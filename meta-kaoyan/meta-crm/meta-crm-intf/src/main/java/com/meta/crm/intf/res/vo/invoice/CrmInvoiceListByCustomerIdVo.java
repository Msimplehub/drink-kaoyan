package com.meta.crm.intf.res.vo.invoice;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
@ApiModel("开票列表出参")
public class CrmInvoiceListByCustomerIdVo {
    @ApiModelProperty("发票id")
    private Long id;

    @ApiModelProperty("合同id")
    private Long contractId;

    @ApiModelProperty("合同名称")
    private String contractName;

    @ApiModelProperty("开票抬头")
    private String invoiceTitle;

    @ApiModelProperty("发票类型")
    private String invoiceType;

    @ApiModelProperty("发票类型描述")
    private String invoiceTypeDesc;

    @ApiModelProperty("开票金额")
    private BigDecimal invoiceAmount;

    @ApiModelProperty("开票时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date invoiceDate;
}
