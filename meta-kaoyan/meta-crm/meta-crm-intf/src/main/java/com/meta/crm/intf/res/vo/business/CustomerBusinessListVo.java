package com.meta.crm.intf.res.vo.business;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
public class CustomerBusinessListVo {
    @ApiModelProperty(value = "商机id")
    private Long id;

    @ApiModelProperty(value = "商机名称")
    private String businessName;

    @ApiModelProperty(value = "商机阶段code")
    private String currentStageCode;

    @ApiModelProperty(value = "商机阶段描述")
    private String currentStageDesc;

    @ApiModelProperty(value = "预估成交金额")
    private BigDecimal estimateDealAmount;

    @ApiModelProperty(value = "预估成交时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date estimateDealDate;
}
