package com.meta.crm.intf.res.vo.contractplanfund;

import com.meta.crm.intf.res.vo.assign.CrmAssignUserVo;
import com.meta.platform.contract.intf.entity.ContractPlanFund;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.beans.BeanUtils;

import java.math.BigDecimal;

@Data
public class CrmContractPlanFundVo extends ContractPlanFund {

    @ApiModelProperty("创建人名称")
    private String createUserName;

    @ApiModelProperty("回款状态描述")
    private String planFundStatusDesc;

    @ApiModelProperty("合同总额")
    private BigDecimal contractTotalAmount;

    @ApiModelProperty("责任人")
    private CrmAssignUserVo manager;

    public static CrmContractPlanFundVo of(ContractPlanFund planFund) {

        if (planFund == null) {
            return null;
        }
        CrmContractPlanFundVo vo = new CrmContractPlanFundVo();
        BeanUtils.copyProperties(planFund, vo);

        return vo;
    }
}
