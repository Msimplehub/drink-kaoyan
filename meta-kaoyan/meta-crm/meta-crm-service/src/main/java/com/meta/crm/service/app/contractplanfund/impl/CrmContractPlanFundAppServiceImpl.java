package com.meta.crm.service.app.contractplanfund.impl;

import com.meta.crm.domain.aggr.CrmAssignUserDo;
import com.meta.crm.domain.aggr.CrmContractPlanFundDo;
import com.meta.crm.domain.tunnel.db.CrmAssignUserRepository;
import com.meta.crm.domain.tunnel.db.CrmContractPlanFundRepository;
import com.meta.crm.intf.cmd.contractplanfund.CrmAddContractPlanFundCmd;
import com.meta.crm.intf.cmd.contractplanfund.CrmUpdateContractPlanFundCmd;
import com.meta.crm.intf.enums.OperateTypeEnum;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.ro.CrmContractPlanFundRo;
import com.meta.crm.service.app.contractplanfund.CrmContractPlanFundAppService;
import com.meta.crm.service.app.opLog.ContractPlanFundOpLogContentBuilder;
import com.meta.platform.contract.domain.aggr.ContractPlanFundDo;
import com.meta.platform.contract.intf.cmd.contractplanfund.AddContractPlanFundCmd;
import com.meta.platform.contract.intf.cmd.contractplanfund.CheckAmountCmd;
import com.meta.platform.contract.intf.cmd.contractplanfund.UpdateContractPlanFundCmd;
import com.meta.platform.contract.service.app.ContractPlanFundAppService;
import com.meta.platform.oplog.common.OperateLogHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class CrmContractPlanFundAppServiceImpl implements CrmContractPlanFundAppService {

    @Resource
    private CrmContractPlanFundRepository crmContractPlanFundRepository;

    @Resource
    private ContractPlanFundAppService contractPlanFundAppService;

    @Resource
    private CrmAssignUserRepository crmAssignUserRepository;

    @Resource
    private OperateLogHandler operateLogHandler;

    @Resource
    private ContractPlanFundOpLogContentBuilder planFundOpLogContentBuilder;

    @Override
    public void createPlanFund(CrmAddContractPlanFundCmd addContractPlanFundCmd) {

        // 创建基本信息
        CrmContractPlanFundDo planFundDo = CrmContractPlanFundDo.of(
                contractPlanFundAppService.createPlanFund(addContractPlanFundCmd));

        // 责任人
        CrmAssignUserDo crmAssignUserDo = CrmAssignUserDo.createAssignUser(
                addContractPlanFundCmd.getManagerId(),
                planFundDo.getTargetId(),
                planFundDo.getTargetType());
        crmAssignUserRepository.saveCrmAssignUser(crmAssignUserDo);

        //操作日志
        operateLogHandler.addLog(TargetType.CONTRACT_PLAN_FUND.getCode(), planFundDo.getId().toString(),
                OperateTypeEnum.PLAN_FUND_ADD.getCode(), planFundOpLogContentBuilder.buildCreateContent(planFundDo));
    }

    @Override
    public void updatePlanFund(CrmUpdateContractPlanFundCmd updateContractPlanFundCmd) {
        CrmContractPlanFundDo fundDo = crmContractPlanFundRepository.getById(updateContractPlanFundCmd.getId());

        if (fundDo == null){
            return;
        }

        CrmContractPlanFundDo oldCopy = new CrmContractPlanFundDo();
        BeanUtils.copyProperties(fundDo, oldCopy);

        fundDo.update(updateContractPlanFundCmd);
        crmContractPlanFundRepository.updateCrmContractPlanFundByPk(fundDo);

        // 操作日志
        operateLogHandler.addLog(TargetType.CONTRACT_PLAN_FUND.getCode(), fundDo.getId().toString(),
                OperateTypeEnum.PLAN_FUND_UPDATE.getCode(),
                planFundOpLogContentBuilder.buildUpdateContent(oldCopy, fundDo));
    }

    @Override
    public boolean checkAmount(CheckAmountCmd checkAmountCmd) {

        // 获取所有回款记录

        return true;
    }
}
