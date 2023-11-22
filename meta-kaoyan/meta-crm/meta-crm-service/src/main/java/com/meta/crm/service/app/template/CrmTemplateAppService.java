package com.meta.crm.service.app.template;

import com.meta.crm.intf.entity.CrmTemplate;

/**
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:25
 */
public interface CrmTemplateAppService {

    /**
     * insert crmTemplate info
     *
     * @param crmTemplate:
     * @return void
     * @method insertCrmTemplate
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    void insertCrmTemplate(CrmTemplate crmTemplate);

    /**
     * 初始化数据
     *
     * @param tenantId
     */
    void initTemplateAndStage(Long tenantId);
}
