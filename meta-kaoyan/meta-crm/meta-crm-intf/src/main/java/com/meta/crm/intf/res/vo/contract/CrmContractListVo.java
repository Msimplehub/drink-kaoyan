package com.meta.crm.intf.res.vo.contract;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.meta.crm.intf.res.vo.follow.CrmFollowVo;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
@ApiModel("查询合同列表返回值")
public class CrmContractListVo {
    @ApiModelProperty("合同id")
    private Long id;

    @ApiModelProperty("合同名称")
    private String contractName;

    @ApiModelProperty("客户id")
    private Long customerId;

    @ApiModelProperty("客户名称")
    private String customerName;

    @ApiModelProperty("商机id")
    private Long businessId;

    @ApiModelProperty("商机名称")
    private String businessName;

    @ApiModelProperty("合同类型")
    private String contractType;

    @ApiModelProperty("合同类型描述")
    private String contractTypeDesc;

    @ApiModelProperty("合同开始时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date contractStartDate;

    @ApiModelProperty("合同金额")
    private BigDecimal contractAmount;

    @ApiModelProperty("合同状态")
    private String contractStatus;

    @ApiModelProperty("合同状态描述")
    private String contractStatusDesc;

    @ApiModelProperty("合同签约时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date contractSignDate;

    @ApiModelProperty("合同编号")
    private String contractNum;

    @ApiModelProperty("合同负责人id")
    private Long assignUserId;

    @ApiModelProperty("合同负责人姓名")
    private String assignUserName;

    @ApiModelProperty("最近跟进信息")
    private CrmFollowVo lastFollowInfo;

    @ApiModelProperty("合同创建人id")
    private Long createUserId;

    @ApiModelProperty("合同创建人姓名")
    private String createUserName;

    @ApiModelProperty("合同创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    @ApiModelProperty("已回款金额")
    private BigDecimal fundedAmount;
}
