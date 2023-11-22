package com.meta.crm.service.app.contractplanfund;

import com.meta.crm.intf.cmd.contractplanfund.CrmAddContractPlanFundCmd;
import com.meta.crm.intf.cmd.contractplanfund.CrmUpdateContractPlanFundCmd;
import com.meta.platform.contract.intf.cmd.contractplanfund.AddContractPlanFundCmd;
import com.meta.platform.contract.intf.cmd.contractplanfund.CheckAmountCmd;
import com.meta.platform.contract.intf.cmd.contractplanfund.UpdateContractPlanFundCmd;

public interface CrmContractPlanFundAppService {

    void createPlanFund(CrmAddContractPlanFundCmd addContractPlanFundCmd);

    void updatePlanFund(CrmUpdateContractPlanFundCmd updateContractPlanFundCmd);

    boolean checkAmount(CheckAmountCmd checkAmountCmd);
}
