package com.meta.crm.core.repository.impl;

import com.meta.crm.core.mapper.CrmContactMapper;
import com.meta.crm.core.mapper.CrmContractPlanFundMapper;
import com.meta.crm.core.repository.impl.base.TargetRepositoryImpl;
import com.meta.crm.domain.aggr.CrmContractPlanFundDo;
import com.meta.crm.domain.tunnel.db.CrmContractPlanFundRepository;
import com.meta.crm.intf.domain.TargetDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.ro.CrmContractPlanFundRo;
import com.meta.framework.common.utils.SecurityUtils;
import com.meta.platform.contract.domain.aggr.ContractPlanFundDo;
import com.meta.platform.contract.domain.tunnel.db.ContractPlanFundRepository;
import com.meta.platform.contract.intf.entity.ContractPlanFund;
import com.meta.platform.contract.intf.ro.ContractFundRecordRo;
import com.meta.platform.contract.intf.ro.ContractPlanFundRo;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CrmContractPlanFundRepositoryImpl extends TargetRepositoryImpl implements CrmContractPlanFundRepository {

    @Resource
    private ContractPlanFundRepository contractPlanFundRepository;

    @Resource
    private CrmContractPlanFundMapper planFundMapper;

    @Override
    public void insertContractPlanFund(CrmContractPlanFundDo planFundDo) {
        contractPlanFundRepository.insertContractPlanFund(planFundDo);
    }

    @Override
    public int updateCrmContractPlanFundByPk(CrmContractPlanFundDo planFundDo) {
        return contractPlanFundRepository.updateContractPlanFundByPk(planFundDo);
    }

    @Override
    public List<CrmContractPlanFundDo> list(CrmContractPlanFundRo fundRo) {
        List<ContractPlanFund> res = planFundMapper.listTable(fundRo);
        if (CollectionUtils.isEmpty(res)){
            return new ArrayList<>();
        }
        return res.stream().map(CrmContractPlanFundDo::of).collect(Collectors.toList());
    }

    @Override
    public List<CrmContractPlanFundDo> getByIdList(List<Long> ids) {
        ContractPlanFundRo ro = new ContractPlanFundRo();
        ro.setIdList(ids);
        List<ContractPlanFund> res = contractPlanFundRepository.listContractPlanFund(ro);
        if (CollectionUtils.isEmpty(res)){
            return new ArrayList<>();
        }
        return res.stream().map(CrmContractPlanFundDo::of).collect(Collectors.toList());
    }

    @Override
    public Integer queryBatchCountByContractId(Long contractId) {
        return planFundMapper.queryBatchCountByContractId(contractId);
    }

    @Override
    public CrmContractPlanFundDo getById(Long id) {
        return CrmContractPlanFundDo.of(contractPlanFundRepository.getById(id));
    }

    @Override
    public CrmContractPlanFundDo getByIdWithName(Long id) {
        if (id == null){
            return null;
        }
        CrmContractPlanFundRo fundRo = new CrmContractPlanFundRo();
        fundRo.setId(id);
        List<ContractPlanFund> res = planFundMapper.listTable(fundRo);
        if (CollectionUtils.isEmpty(res)){
            return null;
        }
        return CrmContractPlanFundDo.of(res.get(0));
    }

    @Override
    public TargetDo queryTargetByTargets(Long targetId) {
        CrmContractPlanFundDo targetDo = this.getByIdWithName(targetId);
        return targetDo;
    }

    @Override
    public TargetType getTargetType() {
        return TargetType.CONTRACT_PLAN_FUND;
    }
}
