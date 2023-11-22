package com.meta.crm.core.repository.impl;

import com.meta.crm.core.mapper.CrmContractMapper;
import com.meta.crm.core.repository.impl.base.TargetRepositoryImpl;
import com.meta.crm.domain.tunnel.db.CrmContractRepository;
import com.meta.crm.intf.domain.TargetDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.contract.CrmContractListByCustomerBusinessQry;
import com.meta.crm.intf.req.contract.CrmContractListForFundPlanQry;
import com.meta.crm.intf.req.ro.CrmContractRo;
import com.meta.crm.intf.res.vo.contract.ContractBusinessName;
import com.meta.crm.intf.res.vo.contract.CrmContractListByCustomerBusinessVo;
import com.meta.crm.intf.res.vo.contract.CrmContractListForFundPlanVo;
import com.meta.crm.intf.res.vo.contract.CrmContractListVo;
import com.meta.platform.contract.core.mapper.ContractMapper;
import com.meta.platform.contract.intf.entity.Contract;
import com.meta.platform.contract.intf.ro.ContractRo;
import org.springframework.stereotype.Repository;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class CrmContractRepositoryImpl extends TargetRepositoryImpl implements CrmContractRepository {

    @Resource
    private ContractMapper contractMapper;

    @Resource
    private CrmContractMapper crmContractMapper;

    @Override
    public TargetDo queryTargetByTargets(Long targetId) {
        ContractRo ro = new ContractRo();
        ro.setId(targetId);
        List<Contract> contracts = contractMapper.listContract(ro);
        if (!CollectionUtils.isEmpty(contracts) && contracts.get(0) != null) {
            return new TargetDo() {
                @Override
                public Long getTargetId() {
                    return targetId;
                }

                @Override
                public TargetType getTargetType() {
                    return TargetType.CONTRACT;
                }

                @Override
                public String getTableShowName() {
                    return contracts.get(0).getContractName();
                }
            };
        }
        return null;
    }

    @Override
    public TargetType getTargetType() {
        return TargetType.CONTRACT;
    }

    @Override
    public List<CrmContractListVo> queryList(CrmContractRo crmContractRo) {
        return crmContractMapper.queryList(crmContractRo);
    }

    @Override
    public List<ContractBusinessName> queryContractRelateBusinessName(List<Long> contractIds) {
        return crmContractMapper.queryContractRelateBusinessName(contractIds);
    }

    @Override
    public List<CrmContractListForFundPlanVo> queryListForFundPlan(CrmContractListForFundPlanQry crmContractListQry) {
        return crmContractMapper.queryListForFundPlan(crmContractListQry);
    }

    @Override
    public List<CrmContractListByCustomerBusinessVo> queryListByCustomerOrBusinessId(CrmContractListByCustomerBusinessQry crmContractListQry) {
        return crmContractMapper.queryListByCustomerOrBusinessId(crmContractListQry);
    }
}
