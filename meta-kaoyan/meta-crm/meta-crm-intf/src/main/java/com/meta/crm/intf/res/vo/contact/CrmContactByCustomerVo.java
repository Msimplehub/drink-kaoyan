package com.meta.crm.intf.res.vo.contact;

import com.meta.crm.intf.entity.CrmContact;
import lombok.Data;
import org.springframework.beans.BeanUtils;

@Data
public class CrmContactByCustomerVo extends CrmContact {

    public static CrmContactByCustomerVo of(CrmContact contact){

        CrmContactByCustomerVo vo = new CrmContactByCustomerVo();
        BeanUtils.copyProperties(contact, vo);

        return vo;
    }
}
