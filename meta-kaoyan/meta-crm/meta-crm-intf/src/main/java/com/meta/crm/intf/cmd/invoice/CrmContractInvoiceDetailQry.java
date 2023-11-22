package com.meta.crm.intf.cmd.invoice;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
@ApiModel("查询合同发票详情入参")
public class CrmContractInvoiceDetailQry {
    @NotNull
    @ApiModelProperty("发票id")
    private Long id;
}
