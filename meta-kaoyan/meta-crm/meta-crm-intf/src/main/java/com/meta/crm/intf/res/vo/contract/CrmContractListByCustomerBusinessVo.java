package com.meta.crm.intf.res.vo.contract;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
@ApiModel("根据客户id 商机id查询出参")
public class CrmContractListByCustomerBusinessVo {
    @ApiModelProperty("合同id")
    private Long contractId;

    @ApiModelProperty("合同名称")
    private String contractName;

    @ApiModelProperty("签约日期")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date contractSignDate;

    @ApiModelProperty("合同状态")
    private String contractStatus;

    @ApiModelProperty("合同状态描述")
    private String contractStatusDesc;

    @ApiModelProperty("合同总金额")
    private BigDecimal contractAmount;

    @ApiModelProperty("合同已回款金额")
    private BigDecimal contractFundedAmount;
}
