package com.meta.crm.intf.req.business;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.meta.crm.intf.req.ro.CrmBusinessRo;
import com.meta.framework.common.utils.DateUtils;
import com.meta.framework.core.BaseEntity;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.beans.BeanUtils;

import java.util.Date;

@Data
public class BusinessListQry extends BaseEntity {

    @ApiModelProperty(value = "商机名 or 客户名")
    private String mixedName;

    // 商机名
    @ApiModelProperty(value = "商机名")
    private String businessNameRex;

    // 客户名
    @ApiModelProperty(value = "客户名")
    private String customerNameRex;

    // 当前阶段 全部传all
    @ApiModelProperty(value = "当前阶段")
    private String currentStage;

    // 创建开始时间
    @JsonFormat(pattern = "yyyy-MM-dd")
    @ApiModelProperty(value = "创建开始时间")
    private Date startDate;

    // 创建结束时间
    @JsonFormat(pattern = "yyyy-MM-dd")
    @ApiModelProperty(value = "创建结束时间")
    private Date endDate;

    // 负责人id
    @ApiModelProperty(value = "负责人id")
    private Long userId;

    public CrmBusinessRo createBusinessListRo() {
        CrmBusinessRo crmBusinessRo = new CrmBusinessRo();
        BeanUtils.copyProperties(this, crmBusinessRo);
        crmBusinessRo.setCurrentStageCode(getCurrentStage());
        if (getEndDate() != null) {
            // 到次日凌晨
            crmBusinessRo.setEndDate(DateUtils.addSeconds(getEndDate(), 86399));
        }
        return crmBusinessRo;
    }
}
