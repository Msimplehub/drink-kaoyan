package com.meta.crm.intf.cmd.business;

import com.meta.crm.intf.entity.CrmBusiness;
import com.meta.crm.intf.req.ro.CrmBusinessContactRelateRo;
import com.meta.crm.intf.req.ro.CrmBusinessRo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class BusinessUpdateCmd extends CrmBusiness {

    @ApiModelProperty(value = "C联系人")
    private Long confirmContactUserId;

    @ApiModelProperty(value = "1W联系人")
    private Long winContactUserId;

    public CrmBusinessRo createBusinessRo() {
        CrmBusinessRo ro = new CrmBusinessRo();
        ro.setId(getId());
        return ro;
    }

    public CrmBusinessContactRelateRo createBusinessContactRelateRo() {
        CrmBusinessContactRelateRo ro = new CrmBusinessContactRelateRo();
        ro.setBusinessId(getId());
        ro.setDelFlag(0);
        return ro;
    }
}
