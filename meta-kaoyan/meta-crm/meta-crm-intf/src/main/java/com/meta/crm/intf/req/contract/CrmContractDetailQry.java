package com.meta.crm.intf.req.contract;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
@ApiModel("查询合同详情入参")
public class CrmContractDetailQry {
    @NotNull
    @ApiModelProperty("合同id")
    private Long id;
}
