package com.meta.crm.service.app.contact.impl;

import com.meta.framework.common.utils.StringUtils;
import com.meta.crm.domain.tunnel.db.CrmAssignUserRepository;
import com.meta.crm.domain.tunnel.db.CrmContactRepository;
import com.meta.crm.intf.cmd.contact.AddContactCmd;
import com.meta.crm.intf.cmd.contact.UpdateContactCmd;
import com.meta.crm.domain.aggr.CrmAssignUserDo;
import com.meta.crm.domain.aggr.CrmContactDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.exception.BusinessException;
import com.meta.crm.service.app.opLog.ContactOpLogContentBuilder;
import com.meta.crm.intf.req.ro.CrmContactRo;
import com.meta.crm.service.app.contact.CrmContactAppService;
import com.meta.platform.oplog.common.OperateLogHandler;
import com.meta.crm.intf.enums.OperateTypeEnum;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CrmContactAppServiceImpl implements CrmContactAppService {

    @Resource
    private CrmContactRepository crmContactRepository;

    @Resource
    private CrmAssignUserRepository crmAssignUserRepository;

    @Resource
    private OperateLogHandler operateLogHandler;

    @Resource
    private ContactOpLogContentBuilder contactOpLogContentBuilder;

    @Override
    public void insertContact(AddContactCmd addContactCmd) {

        // 手机号不能重复
        if (StringUtils.isNotEmpty(addContactCmd.getMobile())){
            CrmContactRo crmContactRo = new CrmContactRo();
            crmContactRo.setCustomerId(addContactCmd.getCustomerId());
            crmContactRo.setMobile(addContactCmd.getMobile());
            List<CrmContactDo> checkMobileDo = crmContactRepository.listCrmContact(crmContactRo);
            if (!CollectionUtils.isEmpty(checkMobileDo)){
                throw new BusinessException("手机号不能重复");
            }
        }

        // 创建联系人
        CrmContactDo contactDo = CrmContactDo.create(addContactCmd);
        crmContactRepository.insertCrmContact(contactDo);

        // 负责人
        CrmAssignUserDo assignUserDo = CrmAssignUserDo.createContactAssignUser(
                addContactCmd.getManagerId(),
                contactDo.getId()
        );
        crmAssignUserRepository.saveCrmAssignUser(assignUserDo);

        //操作日志
        operateLogHandler.addLog(TargetType.CONTACT.getCode(), contactDo.getId().toString(),
                OperateTypeEnum.CONTACT_ADD.getCode(), contactOpLogContentBuilder.buildCreateContent(contactDo));
    }

    @Override
    public void updateContact(UpdateContactCmd updateContactCmd) {
        CrmContactDo contactDo = crmContactRepository.getById(updateContactCmd.getId());

        if (contactDo == null){
            return;
        }

        CrmContactDo old = new CrmContactDo();
        contactDo.transform(old);

        // 手机号不能重复
        if (StringUtils.isNotEmpty(updateContactCmd.getMobile())
            && !updateContactCmd.getMobile().equals(old.getMobile())){
            CrmContactRo crmContactRo = new CrmContactRo();
            crmContactRo.setMobile(updateContactCmd.getMobile());
            crmContactRo.setCustomerId(contactDo.getCustomerId());
            List<CrmContactDo> checkMobileDo = crmContactRepository.listCrmContact(crmContactRo);
            if (!CollectionUtils.isEmpty(checkMobileDo)){
                throw new BusinessException("手机号不能重复");
            }
        }

        contactDo.update(updateContactCmd);
        crmContactRepository.updateCrmContactByPk(contactDo);

        //操作日志
        operateLogHandler.addLog(TargetType.CONTACT.getCode(), contactDo.getId().toString(),
                OperateTypeEnum.CONTACT_UPDATE.getCode(), contactOpLogContentBuilder.buildUpdateContent(old, contactDo));
    }
}
