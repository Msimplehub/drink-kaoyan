package com.meta.crm.intf.res.vo.contractplanfund;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class CheckPlanAmountVo {

    @ApiModelProperty("是否超出合同金额")
    private boolean isFull;

    public static CheckPlanAmountVo create(boolean isFull) {

        CheckPlanAmountVo vo = new CheckPlanAmountVo();
        vo.setFull(isFull);
        return vo;
    }
}
