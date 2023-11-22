package com.meta.crm.intf.cmd.customer;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class CheckClueCanTransCmd {

    @ApiModelProperty("联系人手机号")
    @NotNull(message = "手机号不能为空")
    String mobile;

    @ApiModelProperty("客户姓名")
    @NotNull(message = "客户姓名不能为空")
    String customerName;

}
