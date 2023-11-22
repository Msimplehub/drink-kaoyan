package com.meta.crm.domain.tunnel.db;

import com.meta.crm.intf.req.invoice.CrmInvoiceListByCustomerIdQry;
import com.meta.crm.intf.req.invoice.CrmInvoiceListQry;
import com.meta.crm.intf.res.vo.invoice.CrmInvoiceListByCustomerIdVo;
import com.meta.crm.intf.res.vo.invoice.CrmInvoiceListVo;

import java.util.List;

public interface CrmContractInvoiceRepository {
    List<CrmInvoiceListVo> queryList(CrmInvoiceListQry crmInvoiceListQry);

    List<CrmInvoiceListByCustomerIdVo> queryListByCustomerId(CrmInvoiceListByCustomerIdQry crmInvoiceListQry);
}
