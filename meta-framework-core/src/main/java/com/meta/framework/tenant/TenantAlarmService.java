package com.meta.framework.tenant;

import com.alibaba.fastjson.JSON;
import com.dingtalk.api.DefaultDingTalkClient;
import com.dingtalk.api.DingTalkClient;
import com.dingtalk.api.request.OapiRobotSendRequest;
import com.dingtalk.api.response.OapiRobotSendResponse;
import com.taobao.api.ApiException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * TenantAlarmService
 *
 * @author lidongzhang
 */
@Service
@Slf4j
public class TenantAlarmService {
    private static final String NO_TENANT_ID_SQL_CACHE = "tenant:no_tenant_id_sql_cache";

    /**
     * key:mybatis mapper id
     * value: true：sql表示包含租户ID，false：sql缺少租户ID
     */
    private static final Map<String, Boolean> SQL_CACHE = new ConcurrentHashMap<>();

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    @Value("${spring.profiles.active}")
    private String profiles;

    public boolean hasTenantId(String id) {
        return SQL_CACHE.containsKey(id) && SQL_CACHE.get(id);
    }

    public void setStatus(String id) {
        // 如果拦截器执行完没有在缓存中查到id，说明sql中包含租户ID
        if (!SQL_CACHE.containsKey(id)) {
            SQL_CACHE.put(id, true);
        }
    }

    public void put(TenantAlarmDto tenantAlarmDto) {
        SQL_CACHE.put(tenantAlarmDto.getId(), false);
        redisTemplate.opsForHash().put(NO_TENANT_ID_SQL_CACHE, tenantAlarmDto.getId(), tenantAlarmDto);
    }

    public void alarm(String dingTalkUrl) {
        // 从redis查询
        List<Object> noTenantIdSqlList = redisTemplate.opsForHash().values(NO_TENANT_ID_SQL_CACHE);
        redisTemplate.delete(NO_TENANT_ID_SQL_CACHE);
        if (CollectionUtils.isNotEmpty(noTenantIdSqlList)) {
            OapiRobotSendRequest dingReq = buildRequest(noTenantIdSqlList);
            // 钉钉通知
            postDing(dingTalkUrl, dingReq);
        }
    }

    private OapiRobotSendRequest buildRequest(List<Object> noTenantIdSqlList) {
        OapiRobotSendRequest request = new OapiRobotSendRequest();
        request.setMsgtype("markdown");
        OapiRobotSendRequest.Markdown markdown = new OapiRobotSendRequest.Markdown();
        markdown.setTitle("租户ID缺失告警" + StringUtils.defaultString(profiles, ""));

        StringBuilder text = new StringBuilder();
        text.append("#### 租户ID缺失告警" + StringUtils.defaultString(profiles, "")+"\n");
        for (Object o : noTenantIdSqlList) {
            TenantAlarmDto alarmDto = (TenantAlarmDto) o;
            text.append("> ID：")
                    .append(((TenantAlarmDto) o).getTraceId())
                    .append(",")
                    .append(alarmDto.getId()).append("\n\n");
        }

        markdown.setText(text.toString());
        request.setMarkdown(markdown);

        return request;
    }

    private void postDing(String dingTalkUrl, OapiRobotSendRequest dingReq) {
        DingTalkClient client = new DefaultDingTalkClient(dingTalkUrl);
        OapiRobotSendResponse response = null;
        try {
            response = client.execute(dingReq);
        } catch (ApiException e) {
            log.error("[租户ID缺失告警]告警失败，{}", ExceptionUtils.getStackTrace(e));
        }
        log.info("[租户ID缺失告警]结果{}", JSON.toJSON(response));
    }
}
