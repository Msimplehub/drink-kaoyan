package com.meta.crm.service.app.assign;

import com.meta.crm.intf.cmd.assign.BatchChangeManagerCmd;
import com.meta.crm.intf.cmd.assign.UpdateAssignUserCmd;

public interface CrmAssignAppService {

    void updateAssignUser(UpdateAssignUserCmd changeAssignUserCmd);
    void batchChangeManager(BatchChangeManagerCmd cmd);
}
