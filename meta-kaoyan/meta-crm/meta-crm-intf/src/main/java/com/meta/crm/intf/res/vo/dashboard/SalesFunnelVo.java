package com.meta.crm.intf.res.vo.dashboard;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class SalesFunnelVo {
    @ApiModelProperty(value = "销售阶段code")
    private String saleStageCode;

    @ApiModelProperty(value = "销售阶段描述")
    private String saleStageDesc;

    @ApiModelProperty(value = "排序")
    private Integer saleStageSort;

    @ApiModelProperty(value = "总金额")
    private BigDecimal totalAmount;
}
