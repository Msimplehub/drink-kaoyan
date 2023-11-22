package com.meta.crm.intf.res.vo.business;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class BusinessContactDetailListVo {

    @ApiModelProperty(value = "表id,单独更新时入参")
    private Long id;

    @ApiModelProperty(value = "类型")
    private String type;

    @ApiModelProperty(value = "联系人id")
    private Long contactId;

    @ApiModelProperty(value = "联系人姓名")
    private String contactName;

    @ApiModelProperty(value = "部门")
    private String apartment;

    @ApiModelProperty(value = "职位")
    private String position;

    @ApiModelProperty(value = "手机")
    private String mobile;

    @ApiModelProperty(value = "立场分")
    private Integer standScore;
}
