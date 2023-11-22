package com.meta.crm.intf.req.business;

import com.meta.crm.intf.req.ro.CrmBusinessContactRelateRo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class BusinessContactQry {
    @ApiModelProperty(value = "商机id")
    private Long id;

    public CrmBusinessContactRelateRo createCrmBusinessContactRelateRo() {
        CrmBusinessContactRelateRo ro = new CrmBusinessContactRelateRo();
        ro.setBusinessId(id);
        return ro;
    }
}
