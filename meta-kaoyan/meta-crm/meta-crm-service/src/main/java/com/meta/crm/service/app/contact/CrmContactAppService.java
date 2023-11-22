package com.meta.crm.service.app.contact;

import com.meta.crm.intf.cmd.contact.AddContactCmd;
import com.meta.crm.intf.cmd.contact.UpdateContactCmd;

public interface CrmContactAppService {

    void insertContact(AddContactCmd addContactCmd);

    void updateContact(UpdateContactCmd updateContactCmd);

}
