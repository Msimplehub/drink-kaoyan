package com.meta.crm.intf.res.vo.business;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class BusinessStageDetailListVo {
    @ApiModelProperty(value = "阶段编码")
    private String stageCode;

    @ApiModelProperty(value = "阶段描述")
    private String stageDesc;

    @ApiModelProperty(value = "排序")
    private Integer sort;

    @ApiModelProperty(value = "是否当前")
    private Boolean isCurrent = false;
}
