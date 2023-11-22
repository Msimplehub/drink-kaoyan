package com.meta.crm.service.app.clue.impl;

import com.meta.act.app.service.ISysDictDataService;
import com.meta.act.app.service.ISysUserService;
import com.meta.crm.domain.aggr.CrmAssignUserDo;
import com.meta.crm.domain.aggr.CrmBusinessDo;
import com.meta.crm.domain.aggr.CrmBusinessProcessDo;
import com.meta.crm.domain.aggr.CrmClueDo;
import com.meta.crm.domain.aggr.CrmContactDo;
import com.meta.crm.domain.aggr.CrmCustomerDo;
import com.meta.crm.domain.tunnel.db.CrmAssignUserRepository;
import com.meta.crm.domain.tunnel.db.CrmBusinessProcessRepository;
import com.meta.crm.domain.tunnel.db.CrmBusinessRepository;
import com.meta.crm.domain.tunnel.db.CrmClueRepository;
import com.meta.crm.domain.tunnel.db.CrmContactRepository;
import com.meta.crm.domain.tunnel.db.CrmCustomerRepository;
import com.meta.crm.domain.tunnel.db.CrmFollowRepository;
import com.meta.crm.domain.tunnel.db.CrmTemplateRepository;
import com.meta.crm.intf.cmd.clue.ClueConvertBusinessCmd;
import com.meta.crm.intf.cmd.clue.ClueReAssignCmd;
import com.meta.crm.intf.cmd.clue.ClueSaveCmd;
import com.meta.crm.intf.cmd.clue.ClueStatusUpdateCmd;
import com.meta.crm.intf.cmd.clue.ClueUpdateCmd;
import com.meta.crm.intf.compare.ClueAssignCompare;
import com.meta.crm.intf.constants.ClueDicTypeConstants;
import com.meta.crm.intf.entity.CrmBusiness;
import com.meta.crm.intf.entity.CrmBusinessProcess;
import com.meta.crm.intf.entity.CrmClue;
import com.meta.crm.intf.entity.CrmTemplate;
import com.meta.crm.intf.enums.AssignFollowerType;
import com.meta.crm.intf.enums.AssignRole;
import com.meta.crm.intf.enums.ClueStatusEnum;
import com.meta.crm.intf.enums.OperateTypeEnum;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.exception.BusinessException;
import com.meta.crm.intf.log.ClueConvertLog;
import com.meta.crm.intf.log.ClueLogConstants;
import com.meta.crm.intf.req.ro.CrmClueRo;
import com.meta.crm.intf.req.ro.CrmTemplateRo;
import com.meta.crm.service.app.clue.CrmClueAppService;
import com.meta.crm.service.app.opLog.ContactOpLogContentBuilder;
import com.meta.crm.service.app.opLog.CustomerOpLogContentBuilder;
import com.meta.platform.oplog.common.OperateLogHandler;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class CrmClueAppServiceImpl implements CrmClueAppService {

    @Resource
    private CrmClueRepository crmClueRepository;

    @Resource
    private CrmAssignUserRepository crmAssignUserRepository;

    @Resource
    private CrmFollowRepository crmFollowRepository;

    @Resource
    private CrmCustomerRepository crmCustomerRepository;

    @Resource
    private CrmBusinessRepository crmBusinessRepository;

    @Resource
    private CrmTemplateRepository crmTemplateRepository;

    @Resource
    private CrmBusinessProcessRepository crmBusinessProcessRepository;

    @Resource
    private CrmContactRepository crmContactRepository;

    @Resource
    private OperateLogHandler operateLogHandler;

    @Resource
    private ISysUserService sysUserService;

    @Resource
    private ISysDictDataService sysDictDataService;

    @Resource
    private CustomerOpLogContentBuilder customerOpLogContentBuilder;

    @Resource
    private ContactOpLogContentBuilder contactOpLogContentBuilder;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addClue(ClueSaveCmd req) {
        CrmClueRo crmClueRo = req.createCheckPhoneRo();
        if (crmClueRo != null) {
            checkPhoneNum(crmClueRo);
        }
        CrmClue crmClue = CrmClueDo.createCrmClue(req);
        crmClueRepository.insertCrmClue(crmClue);

        CrmAssignUserDo crmAssignUserDo = CrmAssignUserDo.createAssignUser(req.getAssignUserId(), AssignFollowerType.PERSON,
                crmClue.getId(), AssignRole.MAIN, TargetType.CLUE);
        crmAssignUserRepository.saveCrmAssignUser(crmAssignUserDo);

        // 操作日志
        operateLogHandler.addLog(TargetType.CLUE.getCode(), crmClue.getId().toString(),
                OperateTypeEnum.ADD.getCode(), ClueLogConstants.ADD_CLUE);
    }

    /**
     * 校验手机号
     *
     * @param crmClueRo
     */
    private void checkPhoneNum(CrmClueRo crmClueRo) {
        List<CrmClue> crmClues = crmClueRepository.checkCluePhoneNum(crmClueRo);
        if (!CollectionUtils.isEmpty(crmClues)) {
            throw new BusinessException("公司下存在同手机号线索");
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void reAssignClue(ClueReAssignCmd req) {
        List<CrmAssignUserDo> existCrmAssignUserDos = crmAssignUserRepository.listByTargetIds(req.getReAssignClueIds(), TargetType.CLUE);
        List<CrmAssignUserDo> updateCrmAssignUserDos = CrmAssignUserDo.
                batchUpdateManagerWithCopy(existCrmAssignUserDos, req.getReAssignUserId(), AssignFollowerType.PERSON);
        crmAssignUserRepository.batchSaveAssignUser(updateCrmAssignUserDos);

        // 比较前后分配人差异
        CrmClueDo crmClueDo = new CrmClueDo();
        List<ClueAssignCompare> clueAssignCompares = crmClueDo.compareClueAssignChange(existCrmAssignUserDos, updateCrmAssignUserDos);

        // 查询人员姓名
        Set<Long> userIds = crmClueDo.getClueAssignCompareUserIds(clueAssignCompares);
        Map<Long, String> userNameMap = sysUserService.selectUserNameMapByIds(userIds);

        // 操作日志
        crmClueDo.fillClueAssignCompareUserName(userNameMap, clueAssignCompares);
        for (ClueAssignCompare clueAssignCompare : clueAssignCompares) {
            operateLogHandler.addLog(TargetType.CLUE.getCode(), clueAssignCompare.getClueId().toString(),
                    OperateTypeEnum.CLUE_REASSIGN.getCode(), clueAssignCompare.generateLogContent());
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateClueStatus(ClueStatusUpdateCmd req) {
        CrmClueRo clueRo = req.createClueRo();
        List<CrmClue> crmClues = crmClueRepository.listCrmClue(clueRo);
        if (!CollectionUtils.isEmpty(crmClues) && crmClues.get(0) != null) {
            CrmClue crmClue = crmClues.get(0);
            crmClue.updateClueStatus(req.getClueStatus());
            crmClueRepository.updateCrmClueByPk(crmClue);

            // 操作日志
            Integer opCode = req.getClueStatus().equalsIgnoreCase(ClueStatusEnum.CLOSED.status) ? OperateTypeEnum.CLUE_CLOSE.getCode() :
                    OperateTypeEnum.CLUE_OPEN.getCode();
            String content = req.getClueStatus().equalsIgnoreCase(ClueStatusEnum.CLOSED.status) ? ClueLogConstants.CLOSE_CLUE :
                    ClueLogConstants.OPEN_CLUE;
            operateLogHandler.addLog(TargetType.CLUE.getCode(), req.getId().toString(),
                    opCode, content);
        }
    }

//    @Override
//    @Transactional(rollbackFor = Exception.class)
//    public void addFollowUp(ClueFollowUpAddCmd req) {
//        CrmFollowDo followDo = CrmFollowDo.create(req);
//        crmFollowRepository.insertCrmFollow(followDo);
//        operateLogHandler.addLog(TargetType.CLUE.getCode(), req.getId().toString(),
//                OperateTypeEnum.CLUE_ADD_FOLLOW_UP.getCode(), ClueLogConstants.ADD_FOLLOW_UP);
//    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(ClueUpdateCmd req) {
        CrmClueRo checkPhoneRo = req.createCheckPhoneRo();
        if (checkPhoneRo != null) {
            checkPhoneNum(checkPhoneRo);
        }
        CrmClueRo crmClueRo = req.createQueryClueRo();
        List<CrmClue> crmClues = crmClueRepository.listCrmClue(crmClueRo);
        if (!CollectionUtils.isEmpty(crmClues) && crmClues.get(0) != null) {
            CrmClueDo crmClueDo = new CrmClueDo();
            CrmClue crmClue = crmClues.get(0);

            Map<String, String> sourceMap = sysDictDataService.
                    queryDicNamesWithType(Collections.singletonList(ClueDicTypeConstants.CLUE_SOURCE)).
                    getOrDefault(ClueDicTypeConstants.CLUE_SOURCE, new HashMap<>());

            // 变更日志
            String compareResult = crmClueDo.createClueUpdate(req, crmClue, sourceMap);

            // 更新线索
            if (!StringUtils.isEmpty(compareResult)) {
                crmClueRepository.updateCrmClueByPk(crmClue);
            }

            // 操作日志
            if (!StringUtils.isEmpty(compareResult)) {
                operateLogHandler.addLog(TargetType.CLUE.getCode(), req.getId().toString(),
                        OperateTypeEnum.CLUE_UPDATE.getCode(), compareResult);
            }
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void convertToBusiness(ClueConvertBusinessCmd req) {
        CrmBusinessDo crmBusinessDo = new CrmBusinessDo();
        CrmClueRo crmClueRo = req.createQueryClueRo();

        // 查询线索
        List<CrmClue> crmClues = crmClueRepository.listCrmClue(crmClueRo);

        // 查询模板
        CrmTemplateRo queryTemplateRo = req.createQueryTemplateRo();
        List<CrmTemplate> crmTemplates = crmTemplateRepository.listValidCrmTemplate(queryTemplateRo);

        if (!CollectionUtils.isEmpty(crmClues) && crmClues.get(0) != null
                && !CollectionUtils.isEmpty(crmTemplates) && crmTemplates.get(0) != null) {
            CrmClue crmClue = crmClues.get(0);
            CrmTemplate crmTemplate = crmTemplates.get(0);

            // 保存客户信息
            CrmCustomerDo crmCustomerDo = crmCustomerRepository.getById(req.getCustomerId());
            if (crmCustomerDo == null) {
                crmCustomerDo = crmBusinessDo.createCustomerDo(req, crmClue);
                crmCustomerRepository.saveCrmCustomer(crmCustomerDo);

                crmAssignUserRepository.saveCrmAssignUser(CrmAssignUserDo.createCustomerAssignUser(
                        req.getManagerId(), crmCustomerDo.getId()));

                // 客户操作日志
                operateLogHandler.addLog(TargetType.CUSTOMER.getCode(), crmCustomerDo.getId().toString(),
                        OperateTypeEnum.CLUE_ADD_CUSTOMER.getCode(),
                        customerOpLogContentBuilder.buildClueTransCustomerContent(crmCustomerDo, crmClue));
            }

            // 保存联系人信息
            CrmContactDo crmContact = CrmContactDo.createContactConvertBusiness(req, crmCustomerDo);
            if (crmContact != null) {
                CrmContactDo transform = crmContact.transform(CrmContactDo.class);
                crmContactRepository.saveCrmContact(transform);
                // 保存联系人负责人关系
                CrmAssignUserDo crmAssignUserDo = transform.createConvertBusinessContactAssign(req.getManagerId());
                crmAssignUserRepository.saveCrmAssignUser(crmAssignUserDo);

                //联系人操作日志
                operateLogHandler.addLog(TargetType.CONTACT.getCode(), transform.getId().toString(),
                        OperateTypeEnum.CLUE_ADD_CONTACT.getCode(),
                        contactOpLogContentBuilder.buildClueTransCustomerContent(transform, crmClue));
            }

            // 保存商机
            CrmBusiness crmBusiness = crmBusinessDo.createFromClue(req, crmTemplate, crmCustomerDo);
            crmBusinessRepository.insertCrmBusiness(crmBusiness);

            // 保存商机process实例
            CrmBusinessProcess crmBusinessProcess = CrmBusinessProcessDo.createFromClue(crmBusiness, crmTemplate);
            crmBusinessProcessRepository.insertCrmBusinessProcess(crmBusinessProcess);

            // 更新线索状态为已转换
            CrmClue clueUpdate = CrmClueDo.clueConvertBusinessUpdate(req, crmClue);
            crmClueRepository.updateCrmClueByPk(clueUpdate);

            crmAssignUserRepository.saveCrmAssignUser(CrmAssignUserDo.createCrmAssign(crmBusiness, req.getManagerId()));

            // 操作日志
            ClueConvertLog clueConvertLog = CrmClueDo.createConvertLog(crmBusiness);
            operateLogHandler.addLog(TargetType.CLUE.getCode(), req.getClueId().toString(),
                    OperateTypeEnum.CLUE_CONVERT.getCode(), clueConvertLog.generateLog());

            ClueConvertLog businessConvertLog = crmBusinessDo.createConvertLog(crmClue);
            operateLogHandler.addLog(TargetType.BUSINESS.getCode(), crmBusiness.getId().toString(),
                    OperateTypeEnum.BUSINESS_FROM_CONVERT.getCode(), businessConvertLog.generateLog());
        }
    }
}
