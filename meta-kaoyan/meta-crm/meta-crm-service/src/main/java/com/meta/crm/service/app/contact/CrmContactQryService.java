package com.meta.crm.service.app.contact;

import com.meta.crm.domain.aggr.CrmContactDo;
import com.meta.crm.intf.req.ro.CrmContactRo;
import com.meta.crm.intf.res.vo.contact.CrmContactByCustomerVo;
import com.meta.crm.intf.res.vo.contact.CrmContactVo;

import java.util.List;

public interface CrmContactQryService {

    /**
     * 查询联系人列表
     * @return
     */
    List<CrmContactVo> listCrmContacts(CrmContactRo contactRo);


    List<CrmContactByCustomerVo> listCrmContactsByCustomerId(Long customerId);

    CrmContactVo getDetailById(Long contactId);

    /**
     * 根据客户ID和手机号获取联系人
     * @return
     */
    CrmContactDo getContactByMobileAndCustomer(CrmContactRo contactRo);
}
