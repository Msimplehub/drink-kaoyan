package com.meta.crm.intf.req.ro;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.meta.platform.contract.intf.entity.Contract;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

@Data
public class CrmContractRo extends Contract {
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
