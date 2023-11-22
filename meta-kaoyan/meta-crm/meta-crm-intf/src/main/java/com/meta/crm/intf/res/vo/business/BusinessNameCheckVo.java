package com.meta.crm.intf.res.vo.business;

import com.meta.crm.intf.entity.CrmBusiness;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class BusinessNameCheckVo {
    @ApiModelProperty(value = "商机id")
    private Long id;

    @ApiModelProperty(value = "商机名")
    private String businessName;

    public BusinessNameCheckVo(CrmBusiness crmBusiness) {
        this.id = crmBusiness.getId();
        this.businessName = crmBusiness.getBusinessName();
    }
}
