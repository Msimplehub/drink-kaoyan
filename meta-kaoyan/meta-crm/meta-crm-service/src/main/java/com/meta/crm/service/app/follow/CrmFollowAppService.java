package com.meta.crm.service.app.follow;

import com.meta.crm.intf.cmd.follow.AddFollowCmd;

public interface CrmFollowAppService {
    void insertFollow(AddFollowCmd addFollowCmd);
}
