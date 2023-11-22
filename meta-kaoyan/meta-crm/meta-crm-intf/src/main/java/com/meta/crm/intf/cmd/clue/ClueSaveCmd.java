package com.meta.crm.intf.cmd.clue;

import com.meta.framework.common.utils.StringUtils;
import com.meta.crm.intf.entity.CrmClue;
import com.meta.crm.intf.req.ro.CrmClueRo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class ClueSaveCmd extends CrmClue {
    /**
     * 责任人
     */
    @NotNull(message = "线索责任人不能为空")
    @ApiModelProperty(value = "线索责任人")
    private Long assignUserId;

    public CrmClueRo createCheckPhoneRo() {
        if (StringUtils.isEmpty(getInformantMobile())) {
            return null;
        }
        CrmClueRo crmClueRo = new CrmClueRo();
        crmClueRo.setInformantMobile(getInformantMobile());
        crmClueRo.setCompanyName(getCompanyName());
        return crmClueRo;
    }
}
