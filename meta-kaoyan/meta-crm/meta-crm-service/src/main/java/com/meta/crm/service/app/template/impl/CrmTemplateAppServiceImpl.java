package com.meta.crm.service.app.template.impl;

import com.meta.crm.core.mapper.CrmTemplateMapper;
import com.meta.crm.core.mapper.CrmTemplateStageMapper;
import com.meta.crm.domain.aggr.CrmTemplateDo;
import com.meta.crm.intf.entity.CrmTemplate;
import com.meta.crm.intf.entity.CrmTemplateStage;
import com.meta.crm.service.app.template.CrmTemplateAppService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Title: CrmTemplateAppServiceImpl
 * @Author: M.simple
 * @Remark: The modified content
 * @CreateDate: 2020-11-12 17:43:25
 * @Version: v2.0
 */
@Service
public class CrmTemplateAppServiceImpl implements CrmTemplateAppService {

    @Resource
    private CrmTemplateMapper crmTemplateMapper;

    @Resource
    private CrmTemplateStageMapper crmTemplateStageMapper;

    @Override
    public void insertCrmTemplate(CrmTemplate crmTemplate) {

    }

    @Override
    public void initTemplateAndStage(Long tenantId) {
        CrmTemplate template = CrmTemplateDo.initTemplate(tenantId);
        crmTemplateMapper.insertCrmTemplate(template);

        List<CrmTemplateStage> templateStageList = CrmTemplateDo.initTemplateStageList(template.getId(), tenantId);
        for (CrmTemplateStage crmTemplateStage : templateStageList) {
            crmTemplateStageMapper.insertCrmTemplateStage(crmTemplateStage);
        }
    }
}
