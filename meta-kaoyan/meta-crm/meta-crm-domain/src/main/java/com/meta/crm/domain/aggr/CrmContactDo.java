package com.meta.crm.domain.aggr;

import com.meta.framework.common.utils.SecurityUtils;
import com.meta.crm.intf.domain.TargetDo;
import com.meta.crm.intf.cmd.clue.ClueConvertBusinessCmd;
import com.meta.crm.intf.cmd.contact.AddContactCmd;
import com.meta.crm.intf.cmd.contact.UpdateContactCmd;
import com.meta.crm.intf.entity.CrmContact;
import com.meta.crm.intf.enums.AssignFollowerType;
import com.meta.crm.intf.enums.AssignRole;
import com.meta.crm.intf.enums.TargetType;
import lombok.Data;
import org.springframework.beans.BeanUtils;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Data
public class CrmContactDo extends CrmContact implements TargetDo {

    public static CrmContactDo create(AddContactCmd addContactCmd) {
        CrmContactDo contact = new CrmContactDo();
        BeanUtils.copyProperties(addContactCmd, contact);
        return contact;
    }

    public static CrmContactDo create(String contactName, String mobile, Long customerId) {
        CrmContactDo contact = new CrmContactDo();
        contact.setMobile(mobile);
        contact.setName(contactName);
        contact.setCustomerId(customerId);
        return contact;
    }

    public static CrmContactDo of(CrmContact entity) {
        if (entity == null) {
            return null;
        }

        CrmContactDo contact = new CrmContactDo();
        BeanUtils.copyProperties(entity, contact);
        return contact;
    }

    public static List<CrmContactDo> of(List<CrmContact> entitys) {
        if (CollectionUtils.isEmpty(entitys)) {
            return new ArrayList<>();
        }

        return entitys.stream().map(CrmContactDo::of).collect(Collectors.toList());
    }


    public void update(UpdateContactCmd updateContactCmd) {
        Long id = this.getId();
        BeanUtils.copyProperties(updateContactCmd, this);
        this.setId(id);
    }

    @Override
    public Long getTargetId() {
        return getId();
    }

    @Override
    public TargetType getTargetType() {
        return TargetType.CONTACT;
    }

    @Override
    public String getTargetName() {
        return this.getName();
    }

    public CrmAssignUserDo createConvertBusinessContactAssign(Long managerId) {
        CrmAssignUserDo crmAssignUserDo = new CrmAssignUserDo();
        crmAssignUserDo.setManagerType(AssignFollowerType.PERSON.getCode());
        crmAssignUserDo.setManagerId(managerId);
        crmAssignUserDo.setTargetType(TargetType.CONTACT.getCode());
        crmAssignUserDo.setTargetId(this.getId());
        crmAssignUserDo.setCreateBy(SecurityUtils.getUserId());
        crmAssignUserDo.setAssignRole(AssignRole.MAIN.getCode());
        return crmAssignUserDo;
    }

    public static CrmContactDo createContactConvertBusiness(ClueConvertBusinessCmd req, CrmCustomerDo crmCustomerDo) {
        CrmContactDo crmContact = new CrmContactDo();
        crmContact.setId(req.getContactId());
        crmContact.setMobile(req.getMobile());
        crmContact.setName(req.getName());
        crmContact.setCustomerId(crmCustomerDo.getId());
        return crmContact;
    }
}
