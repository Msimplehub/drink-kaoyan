package com.meta.crm.intf.res.vo.clue;

import com.meta.crm.intf.entity.CrmClue;
import com.meta.crm.intf.res.vo.follow.CrmFollowVo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class ClueListVo extends CrmClue {

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

    @ApiModelProperty("最近更近信息")
    private CrmFollowVo lastFollowInfo;

    // 创建人姓名
    @ApiModelProperty(value = "创建人姓名")
    private String createByUserName;
}
