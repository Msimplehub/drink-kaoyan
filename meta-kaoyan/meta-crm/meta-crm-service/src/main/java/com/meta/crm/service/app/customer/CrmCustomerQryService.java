package com.meta.crm.service.app.customer;

import com.meta.crm.domain.aggr.CrmCustomerDo;
import com.meta.crm.intf.req.ro.CrmCustomerRo;
import com.meta.crm.intf.res.vo.customer.CrmCustomerDetailVo;
import com.meta.crm.intf.res.vo.customer.CrmCustomerVo;

import java.util.List;


public interface CrmCustomerQryService {

    /**
     * 查询客户列表
     * @param customer
     * @return
     */
    List<CrmCustomerDo> listCrmCustomer(CrmCustomerRo customer);

    CrmCustomerDo queryByName(String customerName);

    List<CrmCustomerVo> listCrmCustomerVo(CrmCustomerRo customer);

    CrmCustomerDetailVo queryDetailById(Long customerId);

}
