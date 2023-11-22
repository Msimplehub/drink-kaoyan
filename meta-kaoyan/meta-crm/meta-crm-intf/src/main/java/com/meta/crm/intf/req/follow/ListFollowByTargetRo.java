package com.meta.crm.intf.req.follow;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class ListFollowByTargetRo{

    @ApiModelProperty("跟进对象ID")
    private Long targetId;

    @ApiModelProperty("跟进对象类型")
    @NotNull(message = "跟进对象不能为空")
    private String targetType;
}
