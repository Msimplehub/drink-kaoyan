package com.drink.yan.intf.entity;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 * java类简单作用描述
 *
 * @Title:
 * @Package: com.drink.yan.intf.entity.
 * @Author: M.simple
 * @Remark: The modified content
 * @CreateDate: 2023/11/24 17:13
 * @Version: v2.0
 */
@Data
public class YanActivity {

    @ApiModelProperty(value = "活动编号")
    private Long activityId;

    @ApiModelProperty(value = "活动名称")
    private String activityName;

    @ApiModelProperty(value = "活动内容")
    private String activityContent;

    @ApiModelProperty(value = "起始时间")
    private Timestamp startTime;

    @ApiModelProperty(value = "结束时间")
    private Timestamp endTime;

    @ApiModelProperty(value = "活动地址")
    private String activityAdress;

    @ApiModelProperty(value = "状态")
    private String activityStatus;

    @ApiModelProperty(value = "人数限制")
    private Long userLimit;
    private Long tenantId;
    private String delFlag;
    private String createBy;
    private LocalDateTime createTime;
    private String updateBy;
    private LocalDateTime updateTime;
    private String remark;
}
