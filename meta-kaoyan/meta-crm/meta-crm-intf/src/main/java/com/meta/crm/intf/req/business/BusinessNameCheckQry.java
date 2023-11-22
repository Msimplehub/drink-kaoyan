package com.meta.crm.intf.req.business;

import com.meta.crm.intf.req.ro.CrmBusinessRo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class BusinessNameCheckQry {
    @ApiModelProperty(value = "商机名")
    private String businessName;

    @ApiModelProperty(value = "客户名")
    private Long customerId;

    @ApiModelProperty(value = "当前商机id,更新商机时传入")
    private Long currentBusinessId;

    public CrmBusinessRo createCrmBusinessRo() {
        CrmBusinessRo ro = new CrmBusinessRo();
        ro.setId(this.currentBusinessId);
        ro.setCustomerId(this.getCustomerId());
        ro.setBusinessName(this.getBusinessName());
        return ro;
    }
}
