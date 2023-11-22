package com.meta.crm.intf.cmd.invoice;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.meta.crm.intf.cmd.follow.AddFollowCmd;
import com.meta.platform.contract.intf.entity.ContractInvoice;
import com.meta.platform.contract.intf.entity.ContractInvoiceReceiver;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.util.CollectionUtils;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Data
@ApiModel("开票信息更新入参")
public class CrmContractInvoiceUpdateCmd extends ContractInvoice {
    @NotNull
    @ApiModelProperty("发票id")
    private Long id;

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

    public void initFieldDefaultValue() {
        if (getCompanyTaxNum() == null) {
            this.setCompanyTaxNum("");
        }
        if (getInvoiceTaxRate() == null) {
            this.setInvoiceTaxRate("");
        }
        if (getInvoiceNum() == null) {
            this.setInvoiceNum("");
        }
        if (getRemark() == null) {
            this.setRemark("");
        }
        if (CollectionUtils.isEmpty(getFileObjs())) {
            this.setInvoiceFileIds("");
        }
        if (invoiceReceiver != null) {
            if (invoiceReceiver.getReceiverName() == null) {
                invoiceReceiver.setReceiverName("");
            }
            if (invoiceReceiver.getReceiverMobile() == null) {
                invoiceReceiver.setReceiverMobile("");
            }
            if (invoiceReceiver.getReceiverProvince() == null) {
                invoiceReceiver.setReceiverProvince(-1L);
            }
            if (invoiceReceiver.getReceiverCity() == null) {
                invoiceReceiver.setReceiverCity(-1L);
            }
            if (invoiceReceiver.getReceiverDistrict() == null) {
                invoiceReceiver.setReceiverDistrict(-1L);
            }
            if (invoiceReceiver.getReceiverDetailAddress() == null) {
                invoiceReceiver.setReceiverDetailAddress("");
            }
            if (invoiceReceiver.getReceiverPostCode() == null) {
                invoiceReceiver.setReceiverPostCode("");
            }
            if (invoiceReceiver.getReceiverEmail() == null) {
                invoiceReceiver.setReceiverEmail("");
            }
        }
    }
}
