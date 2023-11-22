package com.meta.crm.intf.req.invoice;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel("根据客户id查询开票列表入参")
public class CrmInvoiceListByCustomerIdQry {
    @ApiModelProperty("客户id")
    private Long customerId;

    @ApiModelProperty("合同id")
    private Long contractId;

    @ApiModelProperty("租户id")
    private Long tenantId;
}
