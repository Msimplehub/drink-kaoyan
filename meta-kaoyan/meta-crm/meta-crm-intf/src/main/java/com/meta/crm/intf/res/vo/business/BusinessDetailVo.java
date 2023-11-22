package com.meta.crm.intf.res.vo.business;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Data
public class BusinessDetailVo {
    @ApiModelProperty(value = "商机id")
    private Long id;

    @ApiModelProperty(value = "商机名")
    private String businessName;

    @ApiModelProperty(value = "客户id")
    private Long customerId;

    @ApiModelProperty(value = "客户名称")
    private String customerName;

    @ApiModelProperty(value = "模板id")
    private Long templateId;

    @ApiModelProperty(value = "商机阶段code")
    private String currentStageCode;

    @ApiModelProperty(value = "当前商机排序")
    private Integer currentStageSort;

    @ApiModelProperty(value = "商机阶段描述")
    private String currentStageDesc;

    @ApiModelProperty(value = "预估成交金额")
    private BigDecimal estimateDealAmount;

    @ApiModelProperty(value = "预估成交时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date estimateDealDate;

    @JsonFormat(pattern = "yyyy-MM-dd")
    @ApiModelProperty("实际成交时间")
    private Date realDealDate;

    @ApiModelProperty(value = "最新跟进时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date followUpDate;

    @ApiModelProperty(value = "商机阶段列表")
    private List<BusinessStageDetailListVo> businessStageDetailListVos;

    @ApiModelProperty(value = "创建人id")
    private Long createBy;

    @ApiModelProperty(value = "创建人姓名")
    private String createByName;

    @ApiModelProperty(value = "责任人id")
    private Long managerId;

    @ApiModelProperty(value = "责任人姓名")
    private String managerName;

    @ApiModelProperty(value = "责任人头像")
    private String managerAvatar;

    @ApiModelProperty(value = "最新跟进时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    @ApiModelProperty(value = "备注")
    private String remark;

    @ApiModelProperty(value = "联系人数量")
    private Integer contactCount;

    @ApiModelProperty(value = "合同数量")
    private Integer contractCount;
}
