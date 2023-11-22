package com.meta.crm.intf.entity;

import com.meta.framework.core.BaseEntity;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.Objects;


/**
 * 商机主表
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:25
 */
@Data
public class CrmBusiness extends BaseEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 自增主键
     */
    @ApiModelProperty(value = "商机主键")
    private Long id;

    /**
     * 商机名
     */
    @NotEmpty(message = "商机名为空")
    @ApiModelProperty(value = "商机名")
    private String businessName;

    /**
     * 线索id
     */
    @ApiModelProperty(value = "线索id")
    private Long clueId;

    /**
     * 客户id
     */
    @ApiModelProperty(value = "客户id")
    private Long customerId;

    /**
     * 阶段模板id
     */
    @ApiModelProperty(value = "阶段模板id")
    private Long templateId;

    /**
     * 当前商机阶段
     */
    @ApiModelProperty(value = "商机阶段")
    private String currentStageCode;

    /**
     * 预估成交金额
     */
    @NotNull(message = "预估成交金额为空")
    @ApiModelProperty(value = "预估成交金额")
    private BigDecimal estimateDealAmount;

    /**
     * 预估成交时间
     */
    @NotNull(message = "预估成交时间为空")
    @ApiModelProperty(value = "预估成交时间")
    private Date estimateDealDate;

    @ApiModelProperty(value = "成交时间")
    private Date realDealDate;

    @ApiModelProperty(value = "输单原因")
    private String loseReason;

    @ApiModelProperty(value = "输单描述")
    private String loseDesc;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof CrmBusiness)) return false;
        if (!super.equals(o)) return false;
        CrmBusiness that = (CrmBusiness) o;
        return Objects.equals(getBusinessName(), that.getBusinessName()) &&
                Objects.equals(getCurrentStageCode(), that.getCurrentStageCode()) &&
                Objects.equals(getEstimateDealAmount(), that.getEstimateDealAmount()) &&
                Objects.equals(getEstimateDealDate(), that.getEstimateDealDate()) &&
                Objects.equals(getRemark(), that.getRemark());
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), getBusinessName(), getCurrentStageCode(), getEstimateDealAmount(), getEstimateDealDate());
    }
}
