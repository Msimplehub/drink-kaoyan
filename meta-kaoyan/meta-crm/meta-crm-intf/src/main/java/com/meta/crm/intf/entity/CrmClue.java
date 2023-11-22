package com.meta.crm.intf.entity;

import com.meta.framework.core.BaseEntity;
import com.meta.crm.intf.res.vo.clue.CluePhoneCheckVo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Objects;


/**
 * 线索主表
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:26
 */
@Data
public class CrmClue extends BaseEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 自增主键
     */
    @ApiModelProperty(value = "线索id")
    private Long id;

    /**
     * 线索来源
     */
    @NotNull(message = "线索来源不能为空")
    @ApiModelProperty("线索来源")
    private String clueSource;

    /**
     * 线索状态 1跟进中 2 已转换 0已作废
     */
    @ApiModelProperty("线索状态 跟进中 follow_up 已转换 converted 已作废closed")
    private String clueStatus;

    /**
     * 线索人姓名
     */
    @NotEmpty(message = "线索人姓名不能为空")
    @ApiModelProperty("线索人姓名")
    private String informantName;

    /**
     * 线索人手机号
     */
    @ApiModelProperty("线索人手机号")
    private String informantMobile;

    /**
     * 线索人微信号
     */
    @ApiModelProperty("线索人微信号")
    private String informantWechat;

    /**
     * 缓存工商信息id
     */
    @ApiModelProperty("缓存工商信息id")
    private String companyId;

    /**
     * 公司名称
     */
    @NotEmpty(message = "公司名不能为空")
    @ApiModelProperty("公司名")
    private String companyName;

    public void updateClueStatus(String clueStatus) {
        this.setClueStatus(clueStatus);
    }

    public CluePhoneCheckVo createCheckPhoneVo() {
        CluePhoneCheckVo checkCluePhoneVo = new CluePhoneCheckVo();
        checkCluePhoneVo.setId(getId());
        checkCluePhoneVo.setInformantName(getInformantName());
        return checkCluePhoneVo;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof CrmClue)) return false;
        if (!super.equals(o)) return false;
        CrmClue crmClue = (CrmClue) o;
        return Objects.equals(getClueSource(), crmClue.getClueSource()) &&
                Objects.equals(getRemark(), crmClue.getRemark()) &&
                Objects.equals(getInformantName(), crmClue.getInformantName()) &&
                Objects.equals(getInformantMobile(), crmClue.getInformantMobile()) &&
                Objects.equals(getInformantWechat(), crmClue.getInformantWechat()) &&
                Objects.equals(getCompanyId(), crmClue.getCompanyId()) &&
                Objects.equals(getCompanyName(), crmClue.getCompanyName());
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), getClueSource(), getRemark(), getInformantName(), getInformantMobile(),
                getInformantWechat(), getCompanyId(), getCompanyName());
    }
}
