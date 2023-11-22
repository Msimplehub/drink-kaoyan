package com.meta.crm.intf.req.business;

import com.meta.crm.intf.req.ro.CrmBusinessRo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class CustomerBusinessListQry {
    @ApiModelProperty("客户id")
    private Long customerId;

    @ApiModelProperty("联系人id")
    private Long contactId;

    public CrmBusinessRo createCustomerQryRo() {
        CrmBusinessRo ro = new CrmBusinessRo();
        ro.setCustomerId(customerId);
        return ro;
    }

    public CrmBusinessRo createContactQryRo() {
        CrmBusinessRo ro = new CrmBusinessRo();
        ro.setContactId(contactId);
        return ro;
    }
}
