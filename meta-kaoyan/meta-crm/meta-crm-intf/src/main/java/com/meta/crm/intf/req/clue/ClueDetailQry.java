package com.meta.crm.intf.req.clue;

import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.ro.CrmClueRo;
import com.meta.crm.intf.req.ro.CrmFollowRo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class ClueDetailQry {
    @ApiModelProperty(value = "线索id")
    private Long id;

    public CrmClueRo createQueryClueRo() {
        CrmClueRo ro = new CrmClueRo();
        ro.setId(this.id);
        return ro;
    }

    public CrmFollowRo createQueryLatestFollowRo() {
        CrmFollowRo ro = new CrmFollowRo();
        ro.setTargetId(id);
        ro.setTargetType(TargetType.CLUE.getCode());
        return ro;
    }
}
