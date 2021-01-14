package com.meta.framework.aspectj.task;

import com.meta.framework.act.entity.SysOperLog;
import com.meta.framework.common.utils.ip.AddressUtils;
import com.meta.framework.common.utils.spring.SpringUtils;
import com.meta.framework.service.ISysOperLogService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.TimerTask;

/**
 * 异步工厂（产生任务用）
 * 
 * @author ruoyi
 */
public class OpLogAsyncFactory
{
    private static final Logger sys_user_logger = LoggerFactory.getLogger("sys-user");

    /**
     * 操作日志记录
     * 
     * @param operLog 操作日志信息
     * @return 任务task
     */
    public static TimerTask recordOper(final SysOperLog operLog)
    {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return new TimerTask()
        {
            @Override
            public void run()
            {
                SecurityContextHolder.getContext().setAuthentication(authentication);
                // 远程查询操作地点
                operLog.setOperLocation(AddressUtils.getRealAddressByIP(operLog.getOperIp()));
                SpringUtils.getBean(ISysOperLogService.class).insertOperlog(operLog);
            }
        };
    }
}
