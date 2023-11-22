package com.meta.crm.service.app.customer.impl;

import com.meta.crm.domain.aggr.CrmAssignUserDo;
import com.meta.crm.domain.aggr.CrmCustomerDo;
import com.meta.crm.domain.tunnel.db.CrmAssignUserRepository;
import com.meta.crm.domain.tunnel.db.CrmCustomerRepository;
import com.meta.crm.intf.cmd.customer.AddCustomerCmd;
import com.meta.crm.intf.cmd.customer.UpdateCustomerCmd;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.exception.BusinessException;
import com.meta.crm.intf.exception.customer.CustomerNameRepeatException;
import com.meta.crm.service.app.opLog.CustomerOpLogContentBuilder;
import com.meta.crm.service.app.customer.CrmCustomerAppService;
import com.meta.platform.oplog.common.OperateLogHandler;
import com.meta.crm.intf.enums.OperateTypeEnum;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class CrmCustomerAppServiceImpl implements CrmCustomerAppService {

    @Resource
    private CrmCustomerRepository crmCustomerRepository;

    @Resource
    private CrmAssignUserRepository crmAssignUserRepository;

    @Resource
    private OperateLogHandler operateLogHandler;

    @Resource
    private CustomerOpLogContentBuilder customerOpLogContentBuilder;

    @Override
    public void insertCrmCustomer(AddCustomerCmd addCustomerCmd) {

        // 根据客户名查询
        CrmCustomerDo oldCustomerDo = crmCustomerRepository.getByName(addCustomerCmd.getCustomerName());
        if (oldCustomerDo != null){
            throw new CustomerNameRepeatException();
        }

        // 创建客户，组装责任人
        CrmCustomerDo customerDo = CrmCustomerDo.create(addCustomerCmd);
        crmCustomerRepository.saveCrmCustomer(customerDo);

        // 创建分配关系
        CrmAssignUserDo crmAssignDo = CrmAssignUserDo.createCustomerAssignUser(
                addCustomerCmd.getManagerId(), customerDo.getId());
        crmAssignUserRepository.saveCrmAssignUser(crmAssignDo);

        //操作日志
        operateLogHandler.addLog(TargetType.CUSTOMER.getCode(), customerDo.getId().toString(),
                OperateTypeEnum.CUSTOMER_ADD.getCode(), customerOpLogContentBuilder.buildCreateContent(customerDo));
    }

    @Override
    public void updateCrmCustomer(UpdateCustomerCmd updateCustomerCmd) {

        CrmCustomerDo customerDo = crmCustomerRepository.getById(updateCustomerCmd.getId());

        if (customerDo == null){
            throw new BusinessException("客户不存在");
        }

        CrmCustomerDo old = new CrmCustomerDo();
        customerDo.transform(old);

        customerDo.update(updateCustomerCmd);

        crmCustomerRepository.saveCrmCustomer(customerDo);

        //操作日志
        operateLogHandler.addLog(TargetType.CUSTOMER.getCode(), customerDo.getId().toString(),
                OperateTypeEnum.CUSTOMER_UPDATE.getCode(), customerOpLogContentBuilder.buildUpdateContent(old, customerDo));
    }
}
