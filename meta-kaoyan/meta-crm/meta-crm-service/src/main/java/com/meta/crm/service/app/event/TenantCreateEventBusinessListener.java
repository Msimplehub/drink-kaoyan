package com.meta.crm.service.app.event;

import com.meta.act.app.event.TenantCreateEvent;
import com.meta.act.app.tenant.entity.TenantBase;
import com.meta.crm.service.app.template.CrmTemplateAppService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * java类简单作用描述
 *
 * @Title:
 * @Package: com.meta.act.app.event.
 * @Author: M.simple
 * @Remark: The modified content
 * @CreateDate: 2020/11/26 3:40 下午
 * @Version: v2.0
 */
@Slf4j
@Component
public class TenantCreateEventBusinessListener {

    @Resource
    private CrmTemplateAppService crmTemplateAppService;

    @EventListener
    public void handleEvent(ApplicationEvent event) {
        if (event instanceof TenantCreateEvent) {
            Object event_obj = ((TenantCreateEvent) event).getEvent_obj();
            Long tenantId = ((TenantBase) event_obj).getTenantId();
            crmTemplateAppService.initTemplateAndStage(tenantId);
            log.info("initTemplateAndStage of tenantId : {}", tenantId);
        }
    }
}
