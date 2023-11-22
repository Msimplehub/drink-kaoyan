package com.meta.crm.intf.res.vo.clue;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

@Data
public class ClueFollowUpVo {
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value = "跟进时间")
    private Date followUpDate;

    // 跟进人id
    @ApiModelProperty(value = "跟进人id")
    private Long followUpUserId;

    // 跟进人姓名
    @ApiModelProperty(value = "跟进人姓名")
    private String followUpUserName;

    // 跟进描述
    @ApiModelProperty(value = "跟进描述")
    private String followUpDesc;

    // 文件
    @ApiModelProperty(value = "文件")
    private String files;
}
