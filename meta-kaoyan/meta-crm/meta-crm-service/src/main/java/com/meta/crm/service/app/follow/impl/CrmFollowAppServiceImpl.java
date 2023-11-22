package com.meta.crm.service.app.follow.impl;

import com.meta.crm.domain.tunnel.db.CrmFollowRepository;
import com.meta.crm.intf.cmd.follow.AddFollowCmd;
import com.meta.crm.domain.aggr.CrmFollowDo;
import com.meta.crm.service.app.follow.CrmFollowAppService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class CrmFollowAppServiceImpl implements CrmFollowAppService {

    @Resource
    private CrmFollowRepository crmFollowRepository;

    @Override
    public void insertFollow(AddFollowCmd addFollowCmd) {
        CrmFollowDo followDo = CrmFollowDo.create(addFollowCmd);
        crmFollowRepository.insertCrmFollow(followDo);
    }
}
