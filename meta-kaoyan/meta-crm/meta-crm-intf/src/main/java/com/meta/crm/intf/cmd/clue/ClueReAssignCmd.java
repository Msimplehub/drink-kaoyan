package com.meta.crm.intf.cmd.clue;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

@Data
public class ClueReAssignCmd {
    @NotEmpty(message = "重新分配线索列表为空")
    @ApiModelProperty(value = "重新分配线索列表")
    private List<Long> reAssignClueIds;

    @NotNull(message = "重新分配人为空")
    @ApiModelProperty(value = "重新分配人")
    private Long reAssignUserId;
}
