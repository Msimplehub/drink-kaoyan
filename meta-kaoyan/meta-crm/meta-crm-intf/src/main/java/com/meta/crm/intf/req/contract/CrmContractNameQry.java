package com.meta.crm.intf.req.contract;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
@ApiModel("检查合同名是否重复")
public class CrmContractNameQry {
    @NotNull
    @ApiModelProperty("合同名")
    private String contractName;

    @NotNull
    @ApiModelProperty("客户id")
    private Long customerId;
}
