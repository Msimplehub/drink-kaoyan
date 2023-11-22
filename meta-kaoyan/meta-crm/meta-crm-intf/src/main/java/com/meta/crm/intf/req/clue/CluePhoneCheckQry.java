package com.meta.crm.intf.req.clue;

import com.meta.framework.common.utils.StringUtils;
import com.meta.crm.intf.req.ro.CrmClueRo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotEmpty;

@Data
public class CluePhoneCheckQry {
    @ApiModelProperty(value = "线索人手机")
    @NotEmpty(message = "线索人手机不能为空")
    private String informantMobile;

    @ApiModelProperty(value = "公司名称")
    @NotEmpty(message = "公司名称")
    private String companyName;

    @ApiModelProperty(value = "当前线索id(需要排除掉)")
    private Long clueId;

    public CrmClueRo createCheckPhoneRo() {
        if (StringUtils.isEmpty(getInformantMobile())) {
            return null;
        }
        CrmClueRo crmClueRo = new CrmClueRo();
        crmClueRo.setId(clueId);
        crmClueRo.setInformantMobile(getInformantMobile());
        crmClueRo.setCompanyName(getCompanyName());
        return crmClueRo;
    }
}
