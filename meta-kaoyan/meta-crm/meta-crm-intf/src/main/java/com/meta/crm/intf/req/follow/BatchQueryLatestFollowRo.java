package com.meta.crm.intf.req.follow;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class BatchQueryLatestFollowRo {

    @ApiModelProperty("跟进对象ID")
    private List<Long> targetIds;

    @ApiModelProperty("跟进对象类型")
    private String targetType;

    private Long tenantId;

    public BatchQueryLatestFollowRo(List<Long> targetIds, String targetType) {
        this.targetIds = targetIds;
        this.targetType = targetType;
    }
}
