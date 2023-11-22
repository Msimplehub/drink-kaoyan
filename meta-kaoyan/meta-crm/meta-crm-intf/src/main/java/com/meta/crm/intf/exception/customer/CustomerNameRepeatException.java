package com.meta.crm.intf.exception.customer;

import com.meta.crm.intf.exception.BusinessException;

public class CustomerNameRepeatException extends BusinessException {
    public CustomerNameRepeatException(){
        super("客户名重复");
    }
}
