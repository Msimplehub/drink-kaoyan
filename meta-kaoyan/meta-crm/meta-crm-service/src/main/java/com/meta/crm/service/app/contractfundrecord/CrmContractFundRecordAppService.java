package com.meta.crm.service.app.contractfundrecord;

import com.meta.crm.intf.cmd.contractfundrecord.CrmAddContractFundRecordCmd;

public interface CrmContractFundRecordAppService {

    void createFundRecord(CrmAddContractFundRecordCmd crmAddContractFundRecordCmd);
}
