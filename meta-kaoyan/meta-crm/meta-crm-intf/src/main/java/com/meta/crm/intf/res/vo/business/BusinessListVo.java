package com.meta.crm.intf.res.vo.business;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.meta.framework.core.BaseEntity;
import com.meta.crm.intf.res.vo.follow.CrmFollowVo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
public class BusinessListVo extends BaseEntity {

    // 商机id
    @ApiModelProperty("商机id")
    private Long businessId;

    // 商机名
    @ApiModelProperty("商机名")
    private String businessName;

    // 客户id
    @ApiModelProperty("客户id")
    private String customerId;

    // 客户名
    @ApiModelProperty("客户名")
    private String customerName;

    // 当前阶段
    @ApiModelProperty("当前阶段")
    private String currentStageCode;

    // 当前阶段描述
    @ApiModelProperty("当前阶段描述")
    private String currentStageDesc;

    /**
     * 预估成交金额
     */
    @ApiModelProperty("预估成交金额")
    private BigDecimal estimateDealAmount;

    /**
     * 预估成交时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @ApiModelProperty("预估成交时间")
    private Date estimateDealDate;

    @JsonFormat(pattern = "yyyy-MM-dd")
    @ApiModelProperty("实际成交时间")
    private Date realDealDate;

    // 负责人id
    @ApiModelProperty("负责人id")
    private Long userId;

    // 负责人姓名
    @ApiModelProperty("负责人姓名")
    private String userName;

    @ApiModelProperty("最近更近信息")
    private CrmFollowVo lastFollowInfo;

    // 创建人姓名
    @ApiModelProperty("创建人姓名")
    private String createUserName;
}
