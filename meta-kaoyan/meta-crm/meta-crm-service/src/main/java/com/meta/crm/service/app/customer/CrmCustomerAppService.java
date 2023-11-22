package com.meta.crm.service.app.customer;

import com.meta.crm.intf.cmd.customer.AddCustomerCmd;
import com.meta.crm.intf.cmd.customer.UpdateCustomerCmd;

public interface CrmCustomerAppService {

    void insertCrmCustomer(AddCustomerCmd customer);

    void updateCrmCustomer(UpdateCustomerCmd updateCustomerCmd);

}
