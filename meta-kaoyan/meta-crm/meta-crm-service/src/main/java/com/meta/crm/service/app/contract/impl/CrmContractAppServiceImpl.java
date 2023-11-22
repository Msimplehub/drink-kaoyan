package com.meta.crm.service.app.contract.impl;

import com.meta.act.app.service.ISysDictDataService;
import com.meta.act.app.service.ISysUserService;
import com.meta.crm.core.mapper.CrmFileRelateMapper;
import com.meta.crm.domain.aggr.CrmContactDo;
import com.meta.crm.domain.aggr.CrmContractDo;
import com.meta.crm.domain.tunnel.db.CrmAssignUserRepository;
import com.meta.crm.domain.tunnel.db.CrmBusinessRepository;
import com.meta.crm.domain.tunnel.db.CrmContactRepository;
import com.meta.crm.domain.tunnel.db.CrmContractRelateRepository;
import com.meta.crm.intf.cmd.contract.CrmContractSaveCmd;
import com.meta.crm.intf.cmd.contract.CrmContractUpdateCmd;
import com.meta.crm.intf.compare.CrmContractBusinessChange;
import com.meta.crm.intf.constants.ClueDicTypeConstants;
import com.meta.crm.intf.entity.CrmBusiness;
import com.meta.crm.intf.entity.CrmContractRelate;
import com.meta.crm.intf.entity.CrmFileRelate;
import com.meta.crm.intf.enums.OperateTypeEnum;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.ro.CrmBusinessRo;
import com.meta.crm.intf.req.ro.CrmContactRo;
import com.meta.crm.service.app.contract.CrmContractAppService;
import com.meta.platform.contract.domain.tunnel.db.ContractRepository;
import com.meta.platform.contract.intf.entity.Contract;
import com.meta.platform.contract.intf.ro.ContractRo;
import com.meta.platform.oplog.common.OperateLogHandler;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class CrmContractAppServiceImpl implements CrmContractAppService {
    @Resource
    private CrmAssignUserRepository crmAssignUserRepository;

    @Resource
    private ContractRepository contractRepository;

    @Resource
    private ISysDictDataService sysDictDataService;

    @Resource
    private ISysUserService sysUserService;

    @Resource
    private CrmContactRepository crmContactRepository;

    @Resource
    private OperateLogHandler operateLogHandler;

    @Resource
    private CrmContractRelateRepository crmContractRelateRepository;

    @Resource
    private CrmBusinessRepository crmBusinessRepository;

    @Resource
    private CrmFileRelateMapper crmFileRelateMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void create(CrmContractSaveCmd addContractCmd) {
        Contract contract = CrmContractDo.createContractFromSaveCmd(addContractCmd);
        contractRepository.insertContract(contract);

        if (addContractCmd.getBusinessId() != null) {
            // 保存和商机的关联关系
            crmContractRelateRepository.insertCrmContractRelate(CrmContractDo.
                    createContractRelate(contract.getId(), addContractCmd.getBusinessId()));
        }

        if (!CollectionUtils.isEmpty(addContractCmd.getFileObjs())) {
            CrmFileRelate crmFileRelate = CrmContractDo.createFileRelateFromSaveCmd(contract, addContractCmd);
            crmFileRelateMapper.addCrmFileRelate(crmFileRelate);
        }

        // 保存责任人
        crmAssignUserRepository.saveCrmAssignUser(CrmContractDo.createCrmAssignForSaveCmd(contract.getId(), addContractCmd.getAssignUserId()));

        operateLogHandler.addLog(TargetType.CONTRACT.getCode(), contract.getId().toString(),
                OperateTypeEnum.CONTRACT_ADD.getCode(), "新建了合同");
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(CrmContractUpdateCmd crmContractUpdateCmd) {
        ContractRo contractRo = CrmContractDo.createContractRoFromUpdateCmd(crmContractUpdateCmd);
        List<Contract> contracts = contractRepository.listContract(contractRo);
        if (!CollectionUtils.isEmpty(contracts) && contracts.get(0) != null) {
            // 初始化一些值
            crmContractUpdateCmd.initFieldDefaultValue();
            Contract contract = contracts.get(0);

            // 枚举值
            Map<String, Map<String, String>> enumMap = sysDictDataService.queryDicNamesWithType(Arrays.asList(ClueDicTypeConstants.CONTRACT_TYPE,
                    ClueDicTypeConstants.CONTRACT_STATUS, ClueDicTypeConstants.PAY_TYPE));

            // 修改对方签约人
            Set<Long> contactIds = CrmContractDo.getContactIdsForUpdate(contract, crmContractUpdateCmd);

            CrmContactRo crmContactRo = new CrmContactRo();
            crmContactRo.setContactIds(contactIds);
            List<CrmContactDo> crmContactDos = crmContactRepository.listCrmContact(crmContactRo);

            // 修改我方签约人
            Set<Long> userIds = CrmContractDo.getUserIdsForUpdate(contract, crmContractUpdateCmd);

            Map<Long, String> userNameMap = new HashMap<>();
            if (!CollectionUtils.isEmpty(userIds)) {
                userNameMap = sysUserService.selectUserNameMapByIds(userIds);
            }

            String compareResult = CrmContractDo.compareContractWithUpdateCmd(contract, crmContractUpdateCmd, enumMap, crmContactDos, userNameMap);

            contractRepository.updateContractByPk(contract);

            // 附件有变更,新增关联附件信息
            if (contract.getContractFileIds() != null) {
                CrmFileRelate crmFileRelate = CrmContractDo.createFileRelateFromUpdateCmd(crmContractUpdateCmd);
                crmFileRelateMapper.addCrmFileRelate(crmFileRelate);
            }

            // 查询&比较合同关联商机记录
            List<CrmContractRelate> crmContractRelates = crmContractRelateRepository.
                    listCrmContractRelate(CrmContractDo.createContractRelateRo(crmContractUpdateCmd.getId()));

            CrmContractBusinessChange crmContractBusinessChange = CrmContractDo.compareRelateBusiness(crmContractRelates, crmContractUpdateCmd);

            if (crmContractBusinessChange != null) {
                crmContractRelateRepository.insertOrUpdate(crmContractRelates);

                List<Long> businessIds = crmContractBusinessChange.getAllIds();
                if (!CollectionUtils.isEmpty(businessIds)) {
                    CrmBusinessRo crmBusinessRo = new CrmBusinessRo();
                    crmBusinessRo.setBusinessIds(businessIds);
                    List<CrmBusiness> crmBusinesses = crmBusinessRepository.listCrmBusiness(crmBusinessRo);
                    compareResult = compareResult.concat(CrmContractDo.createRelateBusinessChangeLog(crmContractBusinessChange, crmBusinesses));
                }
            }

            if (!StringUtils.isEmpty(compareResult)) {
                operateLogHandler.addLog(TargetType.CONTRACT.getCode(), contract.getId().toString(),
                        OperateTypeEnum.CONTRACT_UPDATE.getCode(), compareResult);
            }
        }
    }
}
