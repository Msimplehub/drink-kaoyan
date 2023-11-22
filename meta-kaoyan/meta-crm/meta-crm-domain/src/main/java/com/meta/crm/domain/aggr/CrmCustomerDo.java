package com.meta.crm.domain.aggr;

import com.meta.crm.intf.domain.TargetDo;
import com.meta.crm.intf.cmd.customer.AddCustomerCmd;
import com.meta.crm.intf.cmd.customer.UpdateCustomerCmd;
import com.meta.crm.intf.entity.CrmCustomer;
import com.meta.crm.intf.enums.TargetType;
import lombok.Data;
import org.springframework.beans.BeanUtils;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;


@Data
public class CrmCustomerDo extends CrmCustomer implements TargetDo {

    public static CrmCustomerDo of(CrmCustomer crmCustomer){
        if (crmCustomer == null){
            return null;
        }
        CrmCustomerDo customerDo = new CrmCustomerDo();
        BeanUtils.copyProperties(crmCustomer, customerDo);

        return customerDo;
    }

    public static List<CrmCustomerDo> of(List<CrmCustomer> customers){

        if (CollectionUtils.isEmpty(customers)){
            return new ArrayList<>();
        }

        List<CrmCustomerDo> resList = new ArrayList<>();
        for (CrmCustomer entity : customers) {
            resList.add(CrmCustomerDo.of(entity));
        }

        return resList;
    }

    public static CrmCustomerDo create(AddCustomerCmd addCustomerCmd){
        CrmCustomerDo customerDo = new CrmCustomerDo();
        BeanUtils.copyProperties(addCustomerCmd, customerDo);

        return customerDo;
    }

    public void update(UpdateCustomerCmd updateCustomerCmd){
        Long id = this.getId();
        BeanUtils.copyProperties(updateCustomerCmd, this);
        this.setId(id);
    }


    @Override
    public Long getTargetId() {
        return getId();
    }

    @Override
    public TargetType getTargetType() {
        return TargetType.CUSTOMER;
    }

    @Override
    public String getTargetName() {
        return this.getCustomerName();
    }
}
