package com.meta.crm.service.app.invoice;

import com.meta.crm.intf.cmd.invoice.CrmContractInvoiceCreateCmd;
import com.meta.crm.intf.cmd.invoice.CrmContractInvoiceUpdateCmd;

public interface CrmContractInvoiceAppService {
    void create(CrmContractInvoiceCreateCmd addContractInvoiceCmd);

    void update(CrmContractInvoiceUpdateCmd crmContractInvoiceUpdateCmd);
}
