package com.meta.crm.core.repository.impl;

import com.meta.crm.core.mapper.CrmContractFundRecordMapper;
import com.meta.crm.core.mapper.CrmContractPlanFundMapper;
import com.meta.crm.core.repository.impl.base.TargetRepositoryImpl;
import com.meta.crm.domain.aggr.CrmContractFundRecordDo;
import com.meta.crm.domain.aggr.CrmContractPlanFundDo;
import com.meta.crm.domain.tunnel.db.CrmContractFundRecordRepository;
import com.meta.crm.domain.tunnel.db.CrmContractPlanFundRepository;
import com.meta.crm.intf.domain.TargetDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.ro.CrmContractFundRecordRo;
import com.meta.crm.intf.req.ro.CrmContractPlanFundRo;
import com.meta.platform.contract.domain.tunnel.db.ContractFundRecordRepository;
import com.meta.platform.contract.domain.tunnel.db.ContractPlanFundRepository;
import com.meta.platform.contract.intf.entity.ContractFundRecord;
import com.meta.platform.contract.intf.entity.ContractPlanFund;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CrmContractFundRecordRepositoryImpl extends TargetRepositoryImpl implements CrmContractFundRecordRepository {

    @Resource
    private ContractFundRecordRepository baseRecordRepository;

    @Resource
    private CrmContractFundRecordMapper recordMapper;

    @Resource
    private ContractPlanFundRepository contractPlanFundRepository;

    @Override
    public List<CrmContractFundRecordDo> listTable(CrmContractFundRecordRo recordRo) {
        List<ContractFundRecord> res = recordMapper.listTable(recordRo);
        if (CollectionUtils.isEmpty(res)){
            return new ArrayList<>();
        }
        return res.stream().map(CrmContractFundRecordDo::of).collect(Collectors.toList());
    }

    @Override
    public CrmContractFundRecordDo getById(Long id) {
        return CrmContractFundRecordDo.of(baseRecordRepository.getById(id));
    }

    @Override
    public CrmContractFundRecordDo getByIdWithName(Long id) {
        if (id == null) {
            return null;
        }
        CrmContractFundRecordRo recordRo = new CrmContractFundRecordRo();
        recordRo.setId(id);
        List<ContractFundRecord> res = recordMapper.listTable(recordRo);
        if (CollectionUtils.isEmpty(res)){
            return null;
        }
        return CrmContractFundRecordDo.of(res.get(0));
    }

    @Override
    public TargetDo queryTargetByTargets(Long targetId) {
        CrmContractFundRecordDo targetDo = this.getByIdWithName(targetId);
        if (targetDo == null){
            return null;
        }
        targetDo.setContractPlanFund(contractPlanFundRepository.getById(targetDo.getContractPlanFundId()));
        return targetDo;
    }

    @Override
    public TargetType getTargetType() {
        return TargetType.CONTRACT_FUND_RECORD;
    }
}
