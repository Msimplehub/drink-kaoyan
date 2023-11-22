package com.meta.crm.intf.cmd.contact;

import com.meta.crm.intf.entity.CrmContact;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class AddContactCmd extends CrmContact {

    @NotNull(message = "负责人不能为空")
    Long managerId;
    Integer managerType=0;

    /**
     * 联系人姓名
     */
    @ApiModelProperty(value = "联系人姓名")
    @NotNull(message = "联系人姓名不能为空")
    private String name;

    /**
     * 所属客户
     */
    @ApiModelProperty(value = "所在客户ID")
    @NotNull(message = "所在客户不能为空")
    private Long customerId;

}
