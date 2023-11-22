package com.meta.crm.core.mapper;

import com.meta.crm.intf.req.contract.CrmContractListByCustomerBusinessQry;
import com.meta.crm.intf.req.contract.CrmContractListForFundPlanQry;
import com.meta.crm.intf.req.ro.CrmContractRo;
import com.meta.crm.intf.res.vo.contract.ContractBusinessName;
import com.meta.crm.intf.res.vo.contract.CrmContractListByCustomerBusinessVo;
import com.meta.crm.intf.res.vo.contract.CrmContractListForFundPlanVo;
import com.meta.crm.intf.res.vo.contract.CrmContractListVo;

import java.util.List;

public interface CrmContractMapper {
    List<CrmContractListVo> queryList(CrmContractRo crmContractRo);

    List<ContractBusinessName> queryContractRelateBusinessName(List<Long> contractIds);

    List<CrmContractListForFundPlanVo> queryListForFundPlan(CrmContractListForFundPlanQry crmContractListQry);

    List<CrmContractListByCustomerBusinessVo> queryListByCustomerOrBusinessId(CrmContractListByCustomerBusinessQry crmContractListQry);
}
