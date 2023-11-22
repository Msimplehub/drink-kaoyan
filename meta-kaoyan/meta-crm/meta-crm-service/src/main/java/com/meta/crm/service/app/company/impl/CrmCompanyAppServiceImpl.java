package com.meta.crm.service.app.company.impl;

import com.meta.crm.domain.tunnel.db.CrmCompanyInfoRepository;
import com.meta.crm.intf.entity.CrmCompanyInfo;
import com.meta.crm.service.app.company.CrmCompanyAppService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class CrmCompanyAppServiceImpl implements CrmCompanyAppService {

    @Resource
    private CrmCompanyInfoRepository crmCompanyInfoRepository;

    @Override
    public void insertCrmCompanyInfo(CrmCompanyInfo crmCompanyInfo) {
        crmCompanyInfoRepository.insertCrmCompanyInfo(crmCompanyInfo);
    }
//
//    @Override
//    @Transactional(rollbackFor = Exception.class)
//    public void addClue(ClueSaveCmd req) {
//        CrmClue crmClue = CrmClueDo.createCrmClue(req);
//        crmClueRepository.insertCrmClue(crmClue);
//
//        CrmAssignUserDo crmAssignUserDo = CrmAssignUserDo.createAssignUser(req.getAssignUserId(), AssignFollowerType.PERSON,
//                crmClue.getId(), AssignRole.MAIN, BusinessType.CLUE);
//        crmAssignUserRepository.saveCrmAssignUser(crmAssignUserDo);
//
//        //TODO 操作日志
//    }
//
//    @Override
//    @Transactional(rollbackFor = Exception.class)
//    public void reAssignClue(ClueReAssignCmd req) {
//        List<CrmAssignUserDo> crmAssignUserDos = crmAssignUserRepository.listByTargetIds(req.getReAssignClueIds(), BusinessType.CLUE);
//        CrmAssignUserDo.batchUpdateManager(crmAssignUserDos, req.getReAssignUserId(), AssignFollowerType.PERSON);
//        crmAssignUserRepository.batchSaveAssignUser(crmAssignUserDos);
//
//        // TODO 操作日志
//    }
//
//    @Override
//    @Transactional(rollbackFor = Exception.class)
//    public void updateClueStatus(ClueStatusUpdateCmd req) {
//        CrmClueRo clueRo = req.createClueRo();
//        List<CrmClue> crmClues = crmClueRepository.listCrmClue(clueRo);
//        if (!CollectionUtils.isEmpty(crmClues) && crmClues.get(0) != null) {
//            CrmClue crmClue = crmClues.get(0);
//            crmClue.updateClueStatus(req.getClueStatus());
//            crmClueRepository.updateCrmClue(crmClue);
//        }
//    }
//
//    @Override
//    @Transactional(rollbackFor = Exception.class)
//    public void addFollowUp(ClueFollowUpAddCmd req) {
//        CrmFollow follow = req.createFollow();
//        crmFollowRepository.insertCrmFollow(follow);
//    }
//
//    @Override
//    public List<ClueListVo> queryList(ClueListQry req) {
//        CrmClueRo ro = req.createRo();
//        List<CrmClue> crmClues = crmClueRepository.queryList(ro);
//        List<ClueListVo> result = new ArrayList<>();
//        return result;
//    }
}
