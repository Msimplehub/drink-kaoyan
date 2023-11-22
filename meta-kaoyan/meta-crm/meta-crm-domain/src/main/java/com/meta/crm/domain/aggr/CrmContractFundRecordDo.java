package com.meta.crm.domain.aggr;

import com.meta.platform.contract.domain.aggr.ContractFundRecordDo;
import com.meta.platform.contract.intf.cmd.contractfundrecord.UpdateContractFundRecordCmd;
import com.meta.crm.intf.domain.TargetDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.platform.contract.intf.entity.ContractFundRecord;
import com.meta.platform.contract.intf.entity.ContractPlanFund;
import lombok.Data;
import org.springframework.beans.BeanUtils;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;


@Data
public class CrmContractFundRecordDo extends ContractFundRecordDo implements TargetDo {

    private ContractPlanFund contractPlanFund;

    public static CrmContractFundRecordDo of(ContractFundRecord record){
        if (record == null){
            return null;
        }
        CrmContractFundRecordDo recordDo = new CrmContractFundRecordDo();
        BeanUtils.copyProperties(record, recordDo);

        return recordDo;
    }

    @Override
    public Long getTargetId() {
        return getId();
    }

    @Override
    public TargetType getTargetType() {
        return TargetType.CONTRACT_FUND_RECORD;
    }

    @Override
    public String getTableShowName() {
        if (this.contractPlanFund != null){
            return this.getContractName() + "-" + this.contractPlanFund.getPlanFundBatch();
        }
        else {
            return this.getContractName();
        }
    }
}
