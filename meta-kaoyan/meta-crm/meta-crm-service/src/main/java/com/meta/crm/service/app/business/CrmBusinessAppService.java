package com.meta.crm.service.app.business;

import com.meta.crm.intf.cmd.business.BusinessChangeContactCmd;
import com.meta.crm.intf.cmd.business.BusinessChangeStageCmd;
import com.meta.crm.intf.cmd.business.BusinessSaveCmd;
import com.meta.crm.intf.cmd.business.BusinessUpdateCmd;

public interface CrmBusinessAppService {
    /**
     * 新增商机
     *
     * @param req
     */
    void add(BusinessSaveCmd req);

    /**
     * 更新商机
     *
     * @param req
     */
    void update(BusinessUpdateCmd req);

    /**
     * 调整阶段
     *
     * @param req
     */
    void changeStage(BusinessChangeStageCmd req);

    /**
     * 修改联系人
     *
     * @param req
     */
    void changeContact(BusinessChangeContactCmd req);
}
