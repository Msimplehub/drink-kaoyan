package com.meta.crm.domain.aggr;

import com.google.common.collect.Lists;
import com.meta.crm.intf.entity.CrmTemplate;
import com.meta.crm.intf.entity.CrmTemplateStage;
import com.meta.crm.intf.enums.DefaultTemplateStageEnum;
import lombok.Data;

import java.util.List;

@Data
public class CrmTemplateDo {
    public static CrmTemplate initTemplate(Long tenantId) {
        CrmTemplate result = new CrmTemplate();
        result.setCode("template_v1");
        result.setName("初始化商机模板");
        result.setStatus(1);
        result.setTenantId(tenantId);
        return result;
    }

    public static List<CrmTemplateStage> initTemplateStageList(Long templateId, Long tenantId) {
        List<CrmTemplateStage> result = Lists.newArrayList();
        for (DefaultTemplateStageEnum value : DefaultTemplateStageEnum.values()) {
            CrmTemplateStage stage = new CrmTemplateStage();
            stage.setCode(value.getCode());
            stage.setTemplateCode("template_v1");
            stage.setTemplateId(templateId);
            stage.setName(value.getName());
            stage.setSort(value.getSort());
            stage.setTenantId(tenantId);
            result.add(stage);
        }
        return result;
    }
}
