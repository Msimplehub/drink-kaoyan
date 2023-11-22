package com.meta.crm.intf.res.vo.clue;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.meta.crm.intf.entity.CrmClue;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

@Data
public class ClueDetailVo extends CrmClue {
    // 来源描述
    @ApiModelProperty(value = "来源描述")
    private String clueSourceDesc;

    // 状态描述
    @ApiModelProperty(value = "状态描述")
    private String clueStatusDesc;

    // 负责人id
    @ApiModelProperty(value = "负责人id")
    private Long managerId;

    // 负责人姓名
    @ApiModelProperty(value = "负责人姓名")
    private String managerName;

    @ApiModelProperty(value = "负责人头像")
    private String managerAvatar;

    // 最新跟进时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value = "最新跟进时间")
    private Date followUpDate;

    // 创建人姓名
    @ApiModelProperty(value = "创建人姓名")
    private String createByUserName;
}
