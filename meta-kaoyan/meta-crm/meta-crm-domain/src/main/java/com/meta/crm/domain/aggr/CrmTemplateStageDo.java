package com.meta.crm.domain.aggr;

import com.meta.crm.intf.entity.CrmTemplateStage;
import com.meta.crm.intf.req.ro.CrmTemplateStageRo;
import lombok.Data;

@Data
public class CrmTemplateStageDo extends CrmTemplateStage {
    public static CrmTemplateStageRo queryDefaultStageRo() {
        CrmTemplateStageRo ro = new CrmTemplateStageRo();
        ro.setDelFlag(0);
        return ro;
    }
}
