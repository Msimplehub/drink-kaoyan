package com.meta.crm.intf.cmd.invoice;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.meta.crm.intf.cmd.follow.AddFollowCmd;
import com.meta.platform.contract.intf.entity.ContractInvoice;
import com.meta.platform.contract.intf.entity.ContractInvoiceReceiver;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Data
@ApiModel("创建开票信息入参")
public class CrmContractInvoiceCreateCmd extends ContractInvoice {
    @NotNull
    @ApiModelProperty("客户id")
    private Long customerId;

    @NotNull
    @ApiModelProperty("合同id")
    private Long contractId;

    @NotNull
    @ApiModelProperty("发票抬头")
    private String invoiceTitle;

    @NotNull
    @ApiModelProperty("抬头类型")
    private String titleType;

    @NotNull
    @ApiModelProperty("开票类型")
    private String invoiceCreateType;

    @NotNull
    @ApiModelProperty("发票类型")
    private String invoiceType;

    @NotNull
    @ApiModelProperty("开票金额")
    private BigDecimal invoiceAmount;

    @NotNull
    @ApiModelProperty("开票时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date invoiceDate;

    @ApiModelProperty("邮寄信息")
    private ContractInvoiceReceiver invoiceReceiver;

    @ApiModelProperty("附件列表")
    List<AddFollowCmd.FileObj> fileObjs;
}
