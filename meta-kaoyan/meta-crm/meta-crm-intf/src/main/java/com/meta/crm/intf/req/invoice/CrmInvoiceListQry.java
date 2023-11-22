package com.meta.crm.intf.req.invoice;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.meta.framework.common.utils.DateUtils;
import com.meta.framework.core.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

@Data
@ApiModel("查询开票列表入参")
public class CrmInvoiceListQry extends BaseEntity {
    @ApiModelProperty("合同名")
    private String contractNameReg;

    @ApiModelProperty("客户名称")
    private String customerNameReg;

    @ApiModelProperty("创建开始时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createTimeStart;

    @ApiModelProperty("创建结束时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createTimeEnd;

    @ApiModelProperty("签约开始时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date invoiceDateStart;

    @ApiModelProperty("签约结束时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date invoiceDateEnd;

    @ApiModelProperty("客户id")
    private Long customerId;

    @ApiModelProperty("合同id")
    private Long contractId;

    public void initEndTime() {
        if (getCreateTimeEnd() != null) {
            // 到次日凌晨
            this.setCreateTimeEnd(DateUtils.addSeconds(getCreateTimeEnd(), 86399));
        }
        if (getInvoiceDateEnd() != null) {
            // 到次日凌晨
            this.setInvoiceDateEnd(DateUtils.addSeconds(getInvoiceDateEnd(), 86399));
        }
    }
}
