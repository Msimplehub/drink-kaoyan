package com.meta.crm.intf.req.contract;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.meta.framework.core.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

@Data
@ApiModel("查询合同列表入参")
public class CrmContractListQry extends BaseEntity {
    @ApiModelProperty("合同名 or 客户名")
    private String mixedName;

    @ApiModelProperty("合同名")
    private String contractNameReg;

    @ApiModelProperty("客户名称")
    private String customerNameReg;

    @ApiModelProperty("合同状态")
    private String contractStatus;

    @ApiModelProperty("创建开始时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createTimeStart;

    @ApiModelProperty("创建结束时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createTimeEnd;

    @ApiModelProperty("负责人")
    private Long assignUserId;

    @ApiModelProperty("签约开始时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date signTimeStart;

    @ApiModelProperty("签约结束时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date signTimeEnd;

    @ApiModelProperty("客户id")
    private Long customerId;

    @ApiModelProperty("商机id")
    private Long businessId;
}
