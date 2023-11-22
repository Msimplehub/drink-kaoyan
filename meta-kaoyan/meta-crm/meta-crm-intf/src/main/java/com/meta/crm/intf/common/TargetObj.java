package com.meta.crm.intf.common;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class TargetObj {
    private Long targetId;
    private String targetType;
}
