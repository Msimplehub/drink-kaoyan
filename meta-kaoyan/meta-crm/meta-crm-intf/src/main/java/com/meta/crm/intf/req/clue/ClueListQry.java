package com.meta.crm.intf.req.clue;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.meta.framework.core.BaseEntity;
import com.meta.framework.common.utils.DateUtils;
import com.meta.crm.intf.req.ro.CrmClueRo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.beans.BeanUtils;

import java.util.Date;

@Data
public class ClueListQry extends BaseEntity {
    /**
     * 线索人姓名
     */
    @ApiModelProperty(value = "线索人姓名")
    private String informantName;

    /**
     * 公司名
     */
    @ApiModelProperty(value = "公司名")
    private String companyName;

    /**
     * 手机
     */
    @ApiModelProperty(value = "手机")
    private String informantMobile;

    /**
     * FOLLOW_UP(1, "跟进中"),
     * CLOSED(0, "已关闭"),
     * CONVERTED(2, "已转换"),
     * -1 全部
     */
    @ApiModelProperty(value = "状态 follow_up跟进中 closed关闭 converted转换")
    private String clueStatus;

    /**
     * 创建开始时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @ApiModelProperty(value = "创建开始时间")
    private Date startDate;

    /**
     * 创建结束时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @ApiModelProperty(value = "创建结束时间")
    private Date endDate;

    /**
     * 负责人
     */
    @ApiModelProperty(value = "负责人")
    private Long userId;

    @ApiModelProperty(value = "姓名or公司名")
    private String mixedName;

    public CrmClueRo createRo() {
        CrmClueRo ro = new CrmClueRo();
        BeanUtils.copyProperties(this, ro);
        if (getEndDate() != null) {
            // 到次日凌晨
            ro.setEndDate(DateUtils.addSeconds(getEndDate(), 86399));
        }
        ro.setInformantNameRex(this.getInformantName());
        ro.setCompanyNameRex(this.getCompanyName());
        ro.setInformantMobileRex(this.getInformantMobile());
        ro.setManagerId(userId);
        return ro;
    }
}
