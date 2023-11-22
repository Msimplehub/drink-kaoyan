package com.meta.crm.intf.cmd.business;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.meta.framework.common.utils.SecurityUtils;
import com.meta.framework.common.utils.StringUtils;
import com.meta.crm.intf.entity.CrmBusiness;
import com.meta.crm.intf.entity.CrmBusinessProcess;
import com.meta.crm.intf.req.ro.CrmBusinessRo;
import com.meta.crm.intf.req.ro.CrmTemplateStageRo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.HashSet;

@Data
public class BusinessChangeStageCmd {
    @ApiModelProperty(value = "商机id")
    @NotNull(message = "商机id为空")
    private Long id;

    @ApiModelProperty(value = "当前阶段")
    @NotNull(message = "当前阶段为空")
    private String currentStageCode;

    @ApiModelProperty(value = "下一阶段")
    @NotNull(message = "下一阶段为空")
    private String nextStageCode;

    @ApiModelProperty(value = "成交时间-赢单时传入")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date dealDate;

    @ApiModelProperty(value = "输单理由")
    private String loseReason;

    @ApiModelProperty(value = "输单描述")
    private String loseDesc;

    public CrmBusinessRo createBusinessRo() {
        CrmBusinessRo ro = new CrmBusinessRo();
        ro.setId(getId());
        return ro;
    }

    public CrmBusinessProcess createBusinessProcess(CrmBusiness crmBusiness) {
        CrmBusinessProcess process = new CrmBusinessProcess();
        process.setBusinessId(id);
        // TODO set code
        process.setTemplateCode("");
        process.setTemplateId(crmBusiness.getTemplateId());
        process.setBeforeStageCode(currentStageCode);
        process.setAfterStageCode(nextStageCode);
        process.setCreateBy(SecurityUtils.getUserId());
        return process;
    }

    public CrmTemplateStageRo createQueryStageRo() {
        CrmTemplateStageRo ro = new CrmTemplateStageRo();
        ro.setStageCodes(new HashSet<>());
        if (!StringUtils.isEmpty(getCurrentStageCode())) {
            ro.getStageCodes().add(getCurrentStageCode());
        }
        if (!StringUtils.isEmpty(getNextStageCode())) {
            ro.getStageCodes().add(getNextStageCode());
        }
        return ro;
    }
}
