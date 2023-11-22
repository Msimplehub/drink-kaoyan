package com.meta.crm.intf.req.dashboard;

import com.meta.framework.common.utils.SecurityUtils;
import com.meta.crm.intf.enums.AssignFollowerType;
import com.meta.crm.intf.req.ro.CrmAssignRo;
import com.meta.crm.intf.req.ro.CrmTemplateStageRo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class InitPageQry {
    @ApiModelProperty("查询类型 0个人 1全部")
    private Integer type;

    public CrmAssignRo createCrmAssignUserRo() {
        CrmAssignRo ro = new CrmAssignRo();
        if (type == 0) {
            ro.setManagerId(SecurityUtils.getUserId());
            ro.setManagerType(AssignFollowerType.PERSON.getCode());
        }
        return ro;
    }

    public CrmTemplateStageRo queryDefaultStageRo() {
        CrmTemplateStageRo ro = new CrmTemplateStageRo();
        ro.setDelFlag(0);
        return ro;
    }
}
