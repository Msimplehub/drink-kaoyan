package com.meta.framework.tenant;

import com.meta.framework.aop.define.MethodLogLevel;
import com.meta.framework.aop.define.anno.MethodLog;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * TenantAlarmJob
 *
 * @author lidongzhang
 */
@Service
@Slf4j
public class TenantAlarmJob {
    @Resource
    private TenantAlarmService tenantAlarmService;

    @MethodLog(methodLogLevel = MethodLogLevel.INFO)
    public void execute(String dingTalkUrl) {
        tenantAlarmService.alarm(dingTalkUrl);
    }
}
