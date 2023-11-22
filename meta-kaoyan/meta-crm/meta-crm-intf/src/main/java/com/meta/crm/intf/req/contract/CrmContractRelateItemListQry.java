package com.meta.crm.intf.req.contract;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel("查询合同关联相关记录列表入参")
public class CrmContractRelateItemListQry {
    @ApiModelProperty("合同id")
    private Long contractId;
}
