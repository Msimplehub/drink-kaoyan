package com.meta.crm.intf.cmd.customer;

import com.meta.crm.intf.entity.CrmCustomer;
import lombok.Data;

@Data
public class UpdateCustomerCmd extends CrmCustomer {

    Long managerId;
    Integer managerType;

}
