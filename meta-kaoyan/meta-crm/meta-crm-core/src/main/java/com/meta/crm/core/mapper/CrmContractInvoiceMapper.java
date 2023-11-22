package com.meta.crm.core.mapper;

import com.meta.crm.intf.req.invoice.CrmInvoiceListByCustomerIdQry;
import com.meta.crm.intf.req.invoice.CrmInvoiceListQry;
import com.meta.crm.intf.res.vo.invoice.CrmInvoiceListByCustomerIdVo;
import com.meta.crm.intf.res.vo.invoice.CrmInvoiceListVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CrmContractInvoiceMapper {

    List<CrmInvoiceListVo> queryList(CrmInvoiceListQry crmInvoiceListQry);

    List<CrmInvoiceListByCustomerIdVo> queryListByCustomerId(CrmInvoiceListByCustomerIdQry crmInvoiceListQry);
}
