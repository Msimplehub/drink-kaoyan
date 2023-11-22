package com.meta.crm.intf.cmd.clue;

import com.meta.framework.common.utils.StringUtils;
import com.meta.crm.intf.entity.CrmClue;
import com.meta.crm.intf.req.ro.CrmClueRo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class ClueUpdateCmd extends CrmClue {

    @NotNull(message = "线索id为空")
    @ApiModelProperty(value = "线索id")
    private Long id;

    public CrmClueRo createQueryClueRo() {
        CrmClueRo crmClueRo = new CrmClueRo();
        crmClueRo.setId(getId());
        return crmClueRo;
    }

    public CrmClueRo createCheckPhoneRo() {
        if (StringUtils.isEmpty(getInformantMobile())) {
            return null;
        }
        CrmClueRo crmClueRo = new CrmClueRo();
        crmClueRo.setId(getId());
        crmClueRo.setInformantMobile(getInformantMobile());
        crmClueRo.setCompanyName(getCompanyName());
        return crmClueRo;
    }
}
