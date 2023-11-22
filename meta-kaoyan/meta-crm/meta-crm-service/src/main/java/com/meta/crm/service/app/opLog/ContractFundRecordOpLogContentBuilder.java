package com.meta.crm.service.app.opLog;

import com.meta.crm.domain.aggr.CrmContractFundRecordDo;
import com.meta.platform.contract.domain.aggr.ContractPlanFundDo;
import org.springframework.stereotype.Component;

@Component
public class ContractFundRecordOpLogContentBuilder {

    public String buildCreateContent(CrmContractFundRecordDo newDo){

        return "添加了回款记录";
    }
}
