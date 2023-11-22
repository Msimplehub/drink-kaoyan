package com.meta.crm.service.app.contractplanfund;

import com.meta.crm.intf.req.contractplanfund.PlanFundDetailQry;
import com.meta.crm.intf.req.ro.CrmContractPlanFundRo;
import com.meta.crm.intf.res.vo.contractplanfund.CheckPlanAmountVo;
import com.meta.crm.intf.res.vo.contractplanfund.CrmContractPlanFundDetailVo;
import com.meta.crm.intf.res.vo.contractplanfund.CrmContractPlanFundVo;
import com.meta.platform.contract.intf.cmd.contractplanfund.CheckAmountCmd;

import java.util.List;

public interface CrmContractPlanFundQryService {

    List<CrmContractPlanFundVo> list(CrmContractPlanFundRo planFundRo);

    CrmContractPlanFundDetailVo detail(PlanFundDetailQry planFundRo);

    List<CrmContractPlanFundVo> listSimple(CrmContractPlanFundRo planFundRo);
}
