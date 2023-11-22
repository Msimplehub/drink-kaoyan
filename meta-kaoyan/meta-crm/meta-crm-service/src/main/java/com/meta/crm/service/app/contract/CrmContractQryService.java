package com.meta.crm.service.app.contract;

import com.meta.crm.intf.req.contract.CrmContractDetailQry;
import com.meta.crm.intf.req.contract.CrmContractListByCustomerBusinessQry;
import com.meta.crm.intf.req.contract.CrmContractListForFundPlanQry;
import com.meta.crm.intf.req.contract.CrmContractListQry;
import com.meta.crm.intf.req.contract.CrmContractNameCheckQry;
import com.meta.crm.intf.res.vo.contract.CrmContractDetailVo;
import com.meta.crm.intf.res.vo.contract.CrmContractListByCustomerBusinessVo;
import com.meta.crm.intf.res.vo.contract.CrmContractListForFundPlanVo;
import com.meta.crm.intf.res.vo.contract.CrmContractListVo;
import com.meta.platform.contract.intf.entity.Contract;

import java.util.List;

public interface CrmContractQryService {
    CrmContractDetailVo queryDetail(CrmContractDetailQry crmContractDetailQry);

    List<CrmContractListVo> queryList(CrmContractListQry crmContractListQry);

    Contract checkContractName(CrmContractNameCheckQry contractNameCheckQry);

    List<CrmContractListForFundPlanVo> queryListForFundPlan(CrmContractListForFundPlanQry crmContractListQry);

    List<CrmContractListByCustomerBusinessVo> queryListByCustomerOrBusinessId(CrmContractListByCustomerBusinessQry crmContractListQry);
}
