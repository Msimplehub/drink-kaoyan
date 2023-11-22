package com.meta.crm.service.app.contractfundrecord.impl;

import com.meta.crm.domain.aggr.CrmAssignUserDo;
import com.meta.crm.domain.aggr.CrmContractFundRecordDo;
import com.meta.crm.domain.tunnel.db.CrmAssignUserRepository;
import com.meta.crm.intf.cmd.contractfundrecord.CrmAddContractFundRecordCmd;
import com.meta.crm.intf.enums.OperateTypeEnum;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.service.app.contractfundrecord.CrmContractFundRecordAppService;
import com.meta.crm.service.app.opLog.ContractFundRecordOpLogContentBuilder;
import com.meta.platform.contract.service.app.ContractFundRecordAppService;
import com.meta.platform.oplog.common.OperateLogHandler;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class CrmContractFundRecordAppServiceImpl implements CrmContractFundRecordAppService {

    @Resource
    private ContractFundRecordAppService contractFundRecordAppService;

    @Resource
    private OperateLogHandler operateLogHandler;

    @Resource
    private ContractFundRecordOpLogContentBuilder opLogContentBuilder;

    @Override
    public void createFundRecord(CrmAddContractFundRecordCmd addContractFundRecordCmd) {

        // 基础信息
        CrmContractFundRecordDo recordDo = CrmContractFundRecordDo.of(
                        contractFundRecordAppService.insertContractFundRecord(addContractFundRecordCmd));

        //操作日志
        operateLogHandler.addLog(TargetType.CONTRACT_FUND_RECORD.getCode(), recordDo.getId().toString(),
                OperateTypeEnum.FUND_RECORD_ADD.getCode(), opLogContentBuilder.buildCreateContent(recordDo));

    }
}
