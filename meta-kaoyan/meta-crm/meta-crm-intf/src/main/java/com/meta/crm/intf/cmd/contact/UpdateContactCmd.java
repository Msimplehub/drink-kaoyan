package com.meta.crm.intf.cmd.contact;

import com.meta.crm.intf.entity.CrmContact;
import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class UpdateContactCmd extends CrmContact {

    @NotNull(message = "id不能为空")
    private Long id;
}
