package com.meta.crm.intf.cmd.business;

import com.meta.crm.intf.entity.CrmBusinessContactRelate;
import com.meta.crm.intf.req.ro.CrmBusinessContactRelateRo;
import com.meta.crm.intf.req.ro.CrmContactRo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class BusinessChangeContactCmd {
    @ApiModelProperty(value = "商机id")
    @NotNull(message = "商机id为空")
    private Long businessId;

    @ApiModelProperty(value = "商机关联联系人表id")
    private Long id;

    @ApiModelProperty(value = "关联联系人类型")
    @NotNull(message = "关联联系人类型为空")
    private String type;

    @ApiModelProperty(value = "新联系人id")
    @NotNull(message = "新联系人id")
    private Long contactId;

    public CrmBusinessContactRelateRo createBusinessContactRo() {
        if (id == null) {
            return null;
        }
        CrmBusinessContactRelateRo ro = new CrmBusinessContactRelateRo();
        ro.setId(id);
        return ro;
    }

    public CrmBusinessContactRelate createBusinessContact() {
        CrmBusinessContactRelate result = new CrmBusinessContactRelate();
        result.setBusinessId(getBusinessId());
        result.setType(getType());
        result.setContactId(getContactId());
        return result;
    }

    public CrmContactRo getQueryChangeContactRo() {
        CrmContactRo ro = new CrmContactRo();
        ro.setId(getContactId());
        return ro;
    }
}
