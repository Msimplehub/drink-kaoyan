package com.meta.crm.intf.res.vo.contractfundrecord;

import com.meta.platform.contract.intf.entity.ContractFundRecord;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.beans.BeanUtils;

import java.math.BigDecimal;

@Data
public class CrmContractFundRecordDetailVo extends ContractFundRecord {

    @ApiModelProperty("创建人名称")
    private String createUserName;

    @ApiModelProperty("支付方式描述")
    private String payTypeDesc;

    @ApiModelProperty("合同总额")
    private BigDecimal contractTotalAmount;

    @ApiModelProperty("银行字典值")
    private String bankDesc;

    @ApiModelProperty("计划期次")
    private String planFundBatch;

    public static CrmContractFundRecordDetailVo of(ContractFundRecord fundRecord) {

        if (fundRecord == null) {
            return null;
        }
        CrmContractFundRecordDetailVo vo = new CrmContractFundRecordDetailVo();
        BeanUtils.copyProperties(fundRecord, vo);

        return vo;
    }
}
