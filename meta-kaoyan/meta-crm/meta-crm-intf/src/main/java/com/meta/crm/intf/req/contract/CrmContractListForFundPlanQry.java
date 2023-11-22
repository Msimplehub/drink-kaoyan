package com.meta.crm.intf.req.contract;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel("新建还款计划查询合同列表入参")
public class CrmContractListForFundPlanQry {
    @ApiModelProperty("客户id")
    private Long customerId;

    @ApiModelProperty("租户id")
    private Long tenantId;
}
