package com.meta.crm.service.app.company;

import com.meta.crm.intf.entity.CrmCompanyInfo;

public interface CrmCompanyAppService {
    /**
     * 新增企业工商信息
     *
     * @param crmCompanyInfo
     */
    void insertCrmCompanyInfo(CrmCompanyInfo crmCompanyInfo);

//    /**
//     * 重新分配
//     *
//     * @param req
//     */
//    void reAssignClue(ClueReAssignCmd req);
//
//    /**
//     * 关闭/打开线索
//     *
//     * @param req
//     */
//    void updateClueStatus(ClueStatusUpdateCmd req);
//
//    /**
//     * 添加线索跟进记录
//     *
//     * @param req
//     */
//    void addFollowUp(ClueFollowUpAddCmd req);
//
//    /**
//     * 线索列表
//     *
//     * @param req
//     * @return
//     */
//    List<ClueListVo> queryList(ClueListQry req);
}
