package com.meta.crm.intf.log;

import com.alibaba.fastjson.JSON;
import lombok.Data;

@Data
public class ClueConvertLog {
    // 原始内容,带占位符
    private String log;

    // 超链接目标类型
    private String targetType;

    // 目标名
    private String targetName;

    // 超链接目标id
    private String targetId;

    public String generateLog() {
        return JSON.toJSONString(this);
    }
}
