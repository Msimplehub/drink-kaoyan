package com.meta.crm.service.app.contract;

import com.meta.crm.intf.cmd.contract.CrmContractSaveCmd;
import com.meta.crm.intf.cmd.contract.CrmContractUpdateCmd;

public interface CrmContractAppService {
    void create(CrmContractSaveCmd addContractCmd);

    void update(CrmContractUpdateCmd crmContractUpdateCmd);
}
