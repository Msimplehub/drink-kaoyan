package com.meta.crm.intf.req.contract;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel("根据客户id 商机id查询入参")
public class CrmContractListByCustomerBusinessQry {
    @ApiModelProperty("客户id")
    private Long customerId;

    @ApiModelProperty("商机id")
    private Long businessId;

    @ApiModelProperty("租户id")
    private Long tenantId;
}
