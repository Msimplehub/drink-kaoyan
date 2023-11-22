package com.meta.crm.intf.cmd.follow;

import com.meta.crm.intf.entity.CrmFollow;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.beans.BeanUtils;

import javax.validation.constraints.NotNull;

@Data
public class ClueFollowUpAddCmd{
    @NotNull(message = "线索id非空")
    @ApiModelProperty(value = "线索id")
    private Long id;

    @NotNull(message = "记录类型")
    @ApiModelProperty(value = "记录类型")
    private Integer followType;

    /**
     * 跟进二级类型
     */
    @ApiModelProperty(value = "跟进二级类型")
    private Integer followSubType;

    /**
     * 记录内容
     */
    @ApiModelProperty(value = "记录内容")
    private String content;

    /**
     * 附件json
     */
    @ApiModelProperty(value = "附件json")
    private String files;

    public CrmFollow createFollow() {
        CrmFollow crmFollow = new CrmFollow();
        BeanUtils.copyProperties(this, crmFollow);
        return crmFollow;
    }
}
