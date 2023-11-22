package com.meta.crm.web.rest;

import com.meta.crm.service.app.template.CrmTemplateAppService;
import com.meta.framework.core.CommonRes;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("crmTemplate")
public class CrmTemplateController {
    @Resource
    private CrmTemplateAppService crmTemplateAppService;

    @PostMapping("/initTenantStage")
    public void initTenantStage(@Validated @RequestBody Long tenantId) {
        crmTemplateAppService.initTemplateAndStage(tenantId);
    }
}
