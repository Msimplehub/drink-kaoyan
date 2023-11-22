package com.meta.crm.intf.cmd.clue;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.meta.crm.intf.req.ro.CrmClueRo;
import com.meta.crm.intf.req.ro.CrmTemplateRo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;

@Data
public class ClueConvertBusinessCmd {
    // 线索id
    @ApiModelProperty(value = "线索id")
    private Long clueId;

    // 联系人姓名
    @NotNull(message = "联系人姓名为空")
    @ApiModelProperty(value = " 联系人姓名")
    private String name;

    // 联系人手机号
    @ApiModelProperty(value = "联系人手机号")
    private String mobile;

    // 联系人id(如果前端关联上已有联系人 传这个值)
    @ApiModelProperty(value = "联系人id(如果前端关联上已有联系人 传这个值)")
    private Long contactId;

    // 客户名称
    @NotNull(message = "客户名为空")
    @ApiModelProperty(value = "客户名")
    private String customerName;

    // 客户id(如果前端关联上已有客户 传这个值)
    @ApiModelProperty(value = "客户id(如果前端关联上已有客户 传这个值)")
    private Long customerId;

    @ApiModelProperty(value = "负责人id")
    private Long managerId;

    // 工商信息id
    @ApiModelProperty(value = "工商信息id")
    private String companyId;

    // 商机名
    @NotNull(message = "商机名为空")
    @ApiModelProperty(value = "商机名")
    private String businessName;

    // 商机阶段
    @NotNull(message = "商机阶段为空")
    @ApiModelProperty(value = "商机阶段")
    private String businessStage;

    // 预计成交金额
    @NotNull(message = "预计成交金额为空")
    @ApiModelProperty(value = "预计成交金额")
    private BigDecimal estimateDealAmount;

    // 预计成交金额
    @NotNull(message = "预计成交时间为空")
    @JsonFormat(pattern = "yyyy-MM-dd")
    @ApiModelProperty(value = "预计成交时间")
    private Date estimateDealDate;

    public CrmClueRo createQueryClueRo() {
        CrmClueRo crmClueRo = new CrmClueRo();
        crmClueRo.setId(getClueId());
        return crmClueRo;
    }

    public CrmTemplateRo createQueryTemplateRo() {
        CrmTemplateRo ro = new CrmTemplateRo();
//        ro.setTenantId(getTenantId());
        return ro;
    }

}
