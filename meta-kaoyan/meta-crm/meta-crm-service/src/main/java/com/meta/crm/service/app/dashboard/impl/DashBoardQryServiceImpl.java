package com.meta.crm.service.app.dashboard.impl;

import com.meta.crm.domain.tunnel.db.CrmAssignUserRepository;
import com.meta.crm.domain.tunnel.db.CrmBusinessRepository;
import com.meta.crm.domain.tunnel.db.CrmTemplateStageRepository;
import com.meta.crm.intf.entity.CrmAssignUser;
import com.meta.crm.intf.entity.CrmBusiness;
import com.meta.crm.intf.entity.CrmTemplateStage;
import com.meta.crm.intf.req.dashboard.InitPageQry;
import com.meta.crm.intf.req.ro.CrmBusinessRo;
import com.meta.crm.intf.res.vo.dashboard.InitPageVo;
import com.meta.crm.service.app.dashboard.DashBoardQryService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class DashBoardQryServiceImpl implements DashBoardQryService {
    @Resource
    private CrmAssignUserRepository crmAssignUserRepository;

    @Resource
    private CrmTemplateStageRepository crmTemplateStageRepository;

    @Resource
    private CrmBusinessRepository crmBusinessRepository;

    @Override
    public InitPageVo initPage(InitPageQry initPageQry) {
        InitPageVo result = new InitPageVo();
        List<CrmAssignUser> crmAssignUsers = crmAssignUserRepository.list(initPageQry.createCrmAssignUserRo());
        result.initCount(crmAssignUsers);
        List<CrmTemplateStage> crmTemplateStages = crmTemplateStageRepository.queryDefaultStage(initPageQry.queryDefaultStageRo());

        List<CrmBusiness> crmBusinesses = new ArrayList<>();
        CrmBusinessRo crmBusinessRo = result.batchQueryBusinessRo();

        if (crmBusinessRo != null) {
            crmBusinesses = crmBusinessRepository.listCrmBusiness(crmBusinessRo);
        }
        result.initStageAmount(crmTemplateStages, crmBusinesses);
        return result;
    }
}
