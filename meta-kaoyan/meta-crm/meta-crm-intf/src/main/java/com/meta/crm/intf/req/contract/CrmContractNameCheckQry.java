package com.meta.crm.intf.req.contract;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class CrmContractNameCheckQry {
    private Long contractId;

    @NotNull
    @ApiModelProperty("客户id")
    private Long customerId;

    @NotNull
    @ApiModelProperty("合同名")
    private String contractName;
}
