package com.meta.crm.intf.req.business;

import com.meta.crm.intf.req.ro.CrmBusinessContactRelateRo;
import com.meta.crm.intf.req.ro.CrmBusinessRo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class BusinessDetailQry {
    @ApiModelProperty(value = "商机id")
    private Long id;

    public CrmBusinessRo createBusinessDetailRo() {
        CrmBusinessRo crmBusinessRo = new CrmBusinessRo();
        crmBusinessRo.setId(id);
        return crmBusinessRo;
    }

    public CrmBusinessContactRelateRo createBusinessContactRelateRo() {
        CrmBusinessContactRelateRo ro = new CrmBusinessContactRelateRo();
        ro.setBusinessId(getId());
        return ro;
    }
}
