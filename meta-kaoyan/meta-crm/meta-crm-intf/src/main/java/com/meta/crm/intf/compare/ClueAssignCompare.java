package com.meta.crm.intf.compare;

import lombok.Data;

@Data
public class ClueAssignCompare {
    // 线索id
    private Long clueId;
    // 原来的责任人
    private Long fromUserId;

    private String fromUserName;
    // 新责任人
    private Long toUserId;

    private String toUserName;

    public String generateLogContent() {
        return "将销售线索责任人由 " + fromUserName + " 分配给 " + toUserName;
    }
}
