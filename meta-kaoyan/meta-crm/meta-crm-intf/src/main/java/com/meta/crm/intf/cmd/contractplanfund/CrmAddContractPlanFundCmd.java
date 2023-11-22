package com.meta.crm.intf.cmd.contractplanfund;

import com.meta.platform.contract.intf.cmd.contractplanfund.AddContractPlanFundCmd;
import com.meta.platform.contract.intf.entity.ContractPlanFund;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Data
public class CrmAddContractPlanFundCmd extends AddContractPlanFundCmd {

    @NotNull(message = "负责人不能为空")
    @ApiModelProperty(value = "负责人ID")
    private Long managerId;

    private Integer managerType = 0;

}
