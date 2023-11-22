package com.meta.crm.intf.res.vo.invoice;

import com.meta.platform.contract.intf.entity.ContractInvoiceReceiver;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class ContractInvoiceReceiverVo extends ContractInvoiceReceiver {
    /**
     * 收票人省份
     */
    @ApiModelProperty("收票人省份名称")
    private String receiverProvinceName;

    /**
     * 收票人市区
     */
    @ApiModelProperty("收票人市区名称")
    private String receiverCityName;

    /**
     * 收票人区
     */
    @ApiModelProperty("收票人区名称")
    private String receiverDistrictName;
}
