package com.meta.crm.intf.cmd.assign;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Null;
import java.util.List;

@Data
public class BatchChangeManagerCmd {

    @ApiModelProperty("对象ID list")
    @NotNull(message = "对象ID不能为空")
    List<Long> targetIds;

    @ApiModelProperty("对象类型")
    @NotNull(message = "对象类型不能为空")
    String targetType;

    @ApiModelProperty("责任人ID")
    @NotNull(message = "负责人ID不能为空")
    Long managerId;

    @ApiModelProperty("责任人类型")
    Integer managerType = 0;
}
