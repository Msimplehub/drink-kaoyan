package com.meta.crm.intf.req.contractplanfund;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class PlanFundDetailQry {

    @ApiModelProperty("id")
    @NotNull(message = "id不能为空")
    private Long id;

}
