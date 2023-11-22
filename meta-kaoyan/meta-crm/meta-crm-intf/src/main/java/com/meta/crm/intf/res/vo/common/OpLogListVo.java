package com.meta.crm.intf.res.vo.common;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class OpLogListVo {
    @ApiModelProperty("业务类型")
    private String businessType;

    @ApiModelProperty("业务主键")
    private String businessKey;

    @ApiModelProperty("操作类型")
    private Integer operateType;

    @ApiModelProperty("操作类型描述")
    private String operateTypeDesc;

    @ApiModelProperty("内容")
    private String content;

    @ApiModelProperty("创建人")
    private Long createUserId;

    @ApiModelProperty("创建人姓名")
    private String createUserName;

    @ApiModelProperty("操作时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

}
