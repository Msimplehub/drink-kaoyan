package com.meta.crm.domain.aggr;

import com.meta.crm.intf.domain.TargetDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.platform.contract.domain.aggr.ContractPlanFundDo;
import com.meta.platform.contract.intf.entity.ContractPlanFund;
import lombok.Data;
import org.springframework.beans.BeanUtils;


@Data
public class CrmContractPlanFundDo extends ContractPlanFundDo implements TargetDo {

    public static CrmContractPlanFundDo of(ContractPlanFund crmContractPlanFund){
        if (crmContractPlanFund == null){
            return null;
        }
        CrmContractPlanFundDo customerDo = new CrmContractPlanFundDo();
        BeanUtils.copyProperties(crmContractPlanFund, customerDo);

        return customerDo;
    }

    @Override
    public Long getTargetId() {
        return getId();
    }

    @Override
    public TargetType getTargetType() {
        return TargetType.CONTRACT_PLAN_FUND;
    }

    @Override
    public String getTableShowName() {
        return this.getContractName() + "-" + this.getPlanFundBatch();
    }
}
