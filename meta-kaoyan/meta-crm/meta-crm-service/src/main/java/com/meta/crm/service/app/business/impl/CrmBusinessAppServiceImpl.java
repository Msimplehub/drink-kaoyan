package com.meta.crm.service.app.business.impl;

import com.meta.crm.domain.aggr.CrmAssignUserDo;
import com.meta.crm.domain.aggr.CrmBusinessContactRelateDo;
import com.meta.crm.domain.aggr.CrmBusinessDo;
import com.meta.crm.domain.aggr.CrmContactDo;
import com.meta.crm.domain.tunnel.db.CrmAssignUserRepository;
import com.meta.crm.domain.tunnel.db.CrmBusinessContactRelateRepository;
import com.meta.crm.domain.tunnel.db.CrmBusinessProcessRepository;
import com.meta.crm.domain.tunnel.db.CrmBusinessRepository;
import com.meta.crm.domain.tunnel.db.CrmContactRepository;
import com.meta.crm.domain.tunnel.db.CrmTemplateStageRepository;
import com.meta.crm.intf.cmd.business.BusinessChangeContactCmd;
import com.meta.crm.intf.cmd.business.BusinessChangeStageCmd;
import com.meta.crm.intf.cmd.business.BusinessSaveCmd;
import com.meta.crm.intf.cmd.business.BusinessUpdateCmd;
import com.meta.crm.intf.compare.CrmBusinessContactChange;
import com.meta.crm.intf.constants.ClueDicTypeConstants;
import com.meta.crm.intf.entity.CrmBusiness;
import com.meta.crm.intf.entity.CrmBusinessContactRelate;
import com.meta.crm.intf.entity.CrmBusinessProcess;
import com.meta.crm.intf.entity.CrmTemplateStage;
import com.meta.crm.intf.enums.OperateTypeEnum;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.exception.BusinessException;
import com.meta.crm.intf.log.BusinessLogConstants;
import com.meta.crm.intf.req.ro.CrmBusinessContactRelateRo;
import com.meta.crm.intf.req.ro.CrmBusinessRo;
import com.meta.crm.service.app.business.CrmBusinessAppService;
import com.meta.platform.oplog.common.OperateLogHandler;
import com.meta.act.app.service.ISysDictDataService;
import com.meta.act.app.service.ISysUserService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CrmBusinessAppServiceImpl implements CrmBusinessAppService {
    @Resource
    private CrmBusinessRepository crmBusinessRepository;

    @Resource
    private CrmAssignUserRepository crmAssignUserRepository;

    @Resource
    private CrmBusinessContactRelateRepository crmBusinessContactRelateRepository;

    @Resource
    private CrmBusinessProcessRepository crmBusinessProcessRepository;

    @Resource
    private OperateLogHandler operateLogHandler;

    @Resource
    private CrmTemplateStageRepository crmTemplateStageRepository;

    @Resource
    private ISysUserService sysUserService;

    @Resource
    private CrmContactRepository crmContactRepository;

    @Resource
    private ISysDictDataService sysDictDataService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void add(BusinessSaveCmd req) {
        CrmBusinessRo crmBusinessRo = req.createCheckBusinessNameRo();
        checkBusinessName(crmBusinessRo);

        CrmBusiness crmBusiness = req.createBusiness();
        // 保存商机
        crmBusinessRepository.insertCrmBusiness(crmBusiness);

        // 保存责任人
        CrmAssignUserDo businessResponsible = CrmAssignUserDo.createBusinessResponsible(crmBusiness, req.getAssignUserId());

        crmAssignUserRepository.saveCrmAssignUser(businessResponsible);

        List<CrmBusinessContactRelate> crmBusinessContactRelateList = req.createBusinessContactList(crmBusiness);

        // 保存关联联系人
        crmBusinessContactRelateRepository.batchInsertCrmBusinessContactRelate(crmBusinessContactRelateList);

        // 操作日志
        operateLogHandler.addLog(TargetType.BUSINESS.getCode(), crmBusiness.getId().toString(),
                OperateTypeEnum.ADD.getCode(), BusinessLogConstants.ADD_BUSINESS);
    }

    private void checkBusinessName(CrmBusinessRo crmBusinessRo) {
        List<CrmBusiness> crmBusinesses = crmBusinessRepository.businessNameCheck(crmBusinessRo);
        if (!CollectionUtils.isEmpty(crmBusinesses)) {
            throw new BusinessException("存在同名商机");
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(BusinessUpdateCmd req) {
        CrmBusinessRo crmBusinessRo = req.createBusinessRo();
        List<CrmBusiness> crmBusinesses = crmBusinessRepository.listCrmBusiness(crmBusinessRo);
        if (!CollectionUtils.isEmpty(crmBusinesses) && crmBusinesses.get(0) != null) {
            CrmBusiness crmBusiness = crmBusinesses.get(0);
            CrmBusinessDo crmBusinessDo = new CrmBusinessDo(crmBusiness);

            String businessDiff = CrmBusinessDo.updateBusinessBase(crmBusiness, req);
            if (!StringUtils.isEmpty(businessDiff)) {
                crmBusinessRepository.updateCrmBusinessByPk(crmBusiness);
            }

            // 操作日志
            operateLogHandler.addLog(TargetType.BUSINESS.getCode(), crmBusiness.getId().toString(),
                    OperateTypeEnum.BUSINESS_UPDATE.getCode(), businessDiff);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void changeStage(BusinessChangeStageCmd req) {
        CrmBusinessRo businessRo = req.createBusinessRo();
        List<CrmBusiness> crmBusinesses = crmBusinessRepository.listCrmBusiness(businessRo);
        if (!CollectionUtils.isEmpty(crmBusinesses) && crmBusinesses.get(0) != null) {

            CrmBusiness crmBusiness = crmBusinesses.get(0);

            // 新增前后关联关系
            CrmBusinessProcess crmBusinessProcess = req.createBusinessProcess(crmBusiness);
            crmBusinessProcessRepository.insertCrmBusinessProcess(crmBusinessProcess);

            List<CrmTemplateStage> crmTemplateStages = crmTemplateStageRepository.listCrmTemplateStage(req.createQueryStageRo());

            // 输单理由
            Map<String, String> loseReasonMap = sysDictDataService.
                    queryDicNamesWithType(Collections.singletonList(ClueDicTypeConstants.LOSE_REASON)).getOrDefault(ClueDicTypeConstants.LOSE_REASON, new HashMap<>());

            // 更新主体信息
            // 操作日志加入输单描述
            String changeContent = CrmBusinessDo.updateBusinessStage(crmBusiness, req, crmTemplateStages, loseReasonMap);
            if (!StringUtils.isEmpty(changeContent)) {
                crmBusinessRepository.updateCrmBusinessByPk(crmBusiness);
                // 操作日志
                operateLogHandler.addLog(TargetType.BUSINESS.getCode(), crmBusiness.getId().toString(),
                        OperateTypeEnum.BUSINESS_CHANGE_STAGE.getCode(), changeContent);
            }
        }
    }

    @Override
    public void changeContact(BusinessChangeContactCmd req) {
        CrmBusinessContactRelateRo contactRelateRo = req.createBusinessContactRo();
        CrmBusinessContactRelateDo crmBusinessContactRelateDo = new CrmBusinessContactRelateDo();
        // 新增
        if (contactRelateRo == null) {
            CrmBusinessContactChange crmBusinessContactChange = crmBusinessContactRelateDo.updateContactId(null, req);
            crmBusinessContactRelateRepository.insertCrmBusinessContactRelate(req.createBusinessContact());
            List<CrmContactDo> crmContactDos = crmContactRepository.listCrmContact(req.getQueryChangeContactRo());

            String changeLog = crmBusinessContactRelateDo.createChangeContactLog(crmBusinessContactChange, crmContactDos);

            // 操作日志
            operateLogHandler.addLog(TargetType.BUSINESS.getCode(), req.getBusinessId().toString(),
                    OperateTypeEnum.BUSINESS_CHANGE_CONTACT.getCode(), changeLog);
        } else {
            // 更新
            List<CrmBusinessContactRelate> crmBusinessContactRelateList = crmBusinessContactRelateRepository.
                    listCrmBusinessContactRelate(contactRelateRo);
            if (!CollectionUtils.isEmpty(crmBusinessContactRelateList) && crmBusinessContactRelateList.get(0) != null) {
                CrmBusinessContactRelate toUpdate = crmBusinessContactRelateList.get(0);

                CrmBusinessContactChange crmBusinessContactChange = crmBusinessContactRelateDo.updateContactId(toUpdate, req);
                if (crmBusinessContactChange != null) {
                    crmBusinessContactRelateRepository.updateCrmBusinessContactRelateByPk(toUpdate);
                    List<CrmContactDo> crmContactDos = crmContactRepository.listCrmContact(crmBusinessContactRelateDo.getQueryChangeContactRo(crmBusinessContactChange));

                    String changeLog = crmBusinessContactRelateDo.createChangeContactLog(crmBusinessContactChange, crmContactDos);

                    // 操作日志
                    operateLogHandler.addLog(TargetType.BUSINESS.getCode(), req.getBusinessId().toString(),
                            OperateTypeEnum.BUSINESS_CHANGE_CONTACT.getCode(), changeLog);
                }
            }
        }

    }
}
