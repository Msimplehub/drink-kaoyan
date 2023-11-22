package com.meta.crm.intf.res.vo.contract;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

@Data
@ApiModel("查询合同列表返回值")
public class CrmContractListForFundPlanVo {
    @ApiModelProperty("合同id")
    private Long id;

    @ApiModelProperty("合同名称")
    private String contractName;

    @ApiModelProperty("合同金额")
    private BigDecimal contractAmount;

    @ApiModelProperty("合同状态")
    private Integer fundPlanCount;
}
