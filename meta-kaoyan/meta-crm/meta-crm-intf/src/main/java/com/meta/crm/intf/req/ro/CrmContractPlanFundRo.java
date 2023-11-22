package com.meta.crm.intf.req.ro;

import com.meta.framework.common.utils.DateUtils;
import com.meta.platform.contract.intf.entity.ContractPlanFund;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;


/**
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:26
 */
@Data
public class CrmContractPlanFundRo extends ContractPlanFund {

    @ApiModelProperty("合同名称")
    private String contractName;

    @ApiModelProperty("责任人Id")
    private Long managerId;

    @ApiModelProperty("客户名称")
    private String customerName;

    @ApiModelProperty("创建时间-开始")
    private Date startDate;

    @ApiModelProperty("创建时间-结束")
    private Date endDate;

    public void dealTime(){
        if (getEndDate() != null) {
            // 到次日凌晨
            this.setEndDate(DateUtils.addSeconds(getEndDate(), 86399));
        }
    }
}
