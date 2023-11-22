package com.meta.crm.domain.aggr;

import com.meta.crm.intf.entity.CrmBusiness;
import com.meta.crm.intf.entity.CrmBusinessProcess;
import com.meta.crm.intf.entity.CrmTemplate;
import lombok.Data;

@Data
public class CrmBusinessProcessDo extends CrmBusinessProcess {

    public static CrmBusinessProcess createFromClue(CrmBusiness crmBusiness, CrmTemplate crmTemplate) {
        CrmBusinessProcess crmBusinessProcess = new CrmBusinessProcessDo();
        crmBusinessProcess.setBusinessId(crmBusiness.getId());
        crmBusinessProcess.setTemplateCode(crmTemplate.getCode());
        crmBusinessProcess.setTemplateId(crmTemplate.getId());
        crmBusinessProcess.setBeforeStageCode(null);
        crmBusinessProcess.setAfterStageCode(crmBusiness.getCurrentStageCode());
        return crmBusinessProcess;
    }
}
