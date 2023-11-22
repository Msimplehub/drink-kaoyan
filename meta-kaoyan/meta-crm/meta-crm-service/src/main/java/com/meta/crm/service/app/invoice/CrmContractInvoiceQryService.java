package com.meta.crm.service.app.invoice;

import com.meta.crm.intf.cmd.invoice.CrmContractInvoiceDetailQry;
import com.meta.crm.intf.req.invoice.CrmInvoiceListByCustomerIdQry;
import com.meta.crm.intf.req.invoice.CrmInvoiceListQry;
import com.meta.crm.intf.res.vo.invoice.CrmContractInvoiceDetailVo;
import com.meta.crm.intf.res.vo.invoice.CrmInvoiceListByCustomerIdVo;
import com.meta.crm.intf.res.vo.invoice.CrmInvoiceListVo;

import java.util.List;

public interface CrmContractInvoiceQryService {
    CrmContractInvoiceDetailVo queryDetail(CrmContractInvoiceDetailQry crmContractInvoiceDetailQry);

    List<CrmInvoiceListVo> queryList(CrmInvoiceListQry crmInvoiceListQry);

    List<CrmInvoiceListByCustomerIdVo> queryListByCustomerId(CrmInvoiceListByCustomerIdQry crmInvoiceListQry);
}
