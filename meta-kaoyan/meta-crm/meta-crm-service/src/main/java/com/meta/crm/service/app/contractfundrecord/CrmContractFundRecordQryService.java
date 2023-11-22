package com.meta.crm.service.app.contractfundrecord;

import com.meta.crm.intf.req.contractfundrecord.FundRecordDetailQry;
import com.meta.crm.intf.req.ro.CrmContractFundRecordRo;
import com.meta.crm.intf.req.ro.CrmContractPlanFundRo;
import com.meta.crm.intf.res.vo.contractfundrecord.CrmContractFundRecordDetailVo;
import com.meta.crm.intf.res.vo.contractfundrecord.CrmContractFundRecordVo;
import com.meta.crm.intf.res.vo.contractplanfund.CheckPlanAmountVo;
import com.meta.crm.intf.res.vo.contractplanfund.CrmContractPlanFundVo;
import com.meta.platform.contract.intf.cmd.contractplanfund.CheckAmountCmd;

import java.util.List;

public interface CrmContractFundRecordQryService {

    List<CrmContractFundRecordVo> list(CrmContractFundRecordRo recordRo);

    List<CrmContractFundRecordVo> listSimple(CrmContractFundRecordRo recordRo);

    CrmContractFundRecordDetailVo detail(FundRecordDetailQry fundRecordDetailQry);
}
