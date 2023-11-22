package com.meta.crm.web.rest;

import com.meta.crm.intf.entity.CrmTemplateStage;
import com.meta.framework.common.annotation.Log;
import com.meta.framework.core.CommonRes;
import com.meta.framework.common.enums.BusinessType;
import com.meta.crm.domain.tunnel.db.CrmTemplateStageRepository;
import com.meta.crm.domain.aggr.CrmTemplateStageDo;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/crmTemplateStage")
public class CrmTemplateStageController {

    @Resource
    private CrmTemplateStageRepository crmTemplateStageRepository;

    @GetMapping("/queryDefaultStage")
    @Log(title = "查询默认商机阶段", businessType = BusinessType.QUERY)
    public List<CrmTemplateStage> queryDefaultStage() {
        return crmTemplateStageRepository.queryDefaultStage(CrmTemplateStageDo.queryDefaultStageRo());
    }
}
