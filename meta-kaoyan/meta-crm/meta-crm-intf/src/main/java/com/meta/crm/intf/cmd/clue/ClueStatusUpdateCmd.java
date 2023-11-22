package com.meta.crm.intf.cmd.clue;

import com.meta.crm.intf.req.ro.CrmClueRo;
import com.meta.framework.util.BeanUtil;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class ClueStatusUpdateCmd {
    @NotNull(message = "线索id非空")
    @ApiModelProperty(value = "线索id")
    private Long id;

    private String clueStatus;

    public <T> T transform(Class<T> clazz) {
        return BeanUtil.copyProperties(clazz, this);
    }

    public CrmClueRo createClueRo() {
        CrmClueRo crmClueRo = new CrmClueRo();
        crmClueRo.setId(this.getId());
        return crmClueRo;
    }
}
