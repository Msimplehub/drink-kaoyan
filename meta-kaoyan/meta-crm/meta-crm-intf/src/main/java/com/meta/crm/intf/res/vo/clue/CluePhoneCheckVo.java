package com.meta.crm.intf.res.vo.clue;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class CluePhoneCheckVo {
    /**
     * 线索表id
     */
    @ApiModelProperty(value = "线索表id")
    private Long id;

    /**
     * 线索联系人姓名
     */
    @ApiModelProperty(value = "线索联系人姓名")
    private String informantName;
}
