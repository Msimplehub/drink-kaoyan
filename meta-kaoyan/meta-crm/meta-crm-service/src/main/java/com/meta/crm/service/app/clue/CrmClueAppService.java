package com.meta.crm.service.app.clue;

import com.meta.crm.intf.cmd.clue.ClueConvertBusinessCmd;
import com.meta.crm.intf.cmd.clue.ClueReAssignCmd;
import com.meta.crm.intf.cmd.clue.ClueSaveCmd;
import com.meta.crm.intf.cmd.clue.ClueStatusUpdateCmd;
import com.meta.crm.intf.cmd.clue.ClueUpdateCmd;

public interface CrmClueAppService {
    /**
     * 新增销售线索
     *
     * @param req
     */
    void addClue(ClueSaveCmd req);

    /**
     * 重新分配
     *
     * @param req
     */
    void reAssignClue(ClueReAssignCmd req);

    /**
     * 关闭/打开线索
     *
     * @param req
     */
    void updateClueStatus(ClueStatusUpdateCmd req);

    /**
     * 添加线索跟进记录
     *
     * @param req
     */
//    void addFollowUp(ClueFollowUpAddCmd req);

    /**
     * 更新线索
     *
     * @param req
     */
    void update(ClueUpdateCmd req);

    /**
     * 转商机
     *
     * @param req
     */
    void convertToBusiness(ClueConvertBusinessCmd req);
}
