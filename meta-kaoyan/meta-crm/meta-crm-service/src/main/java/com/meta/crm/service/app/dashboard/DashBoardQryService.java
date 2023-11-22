package com.meta.crm.service.app.dashboard;

import com.meta.crm.intf.req.dashboard.InitPageQry;
import com.meta.crm.intf.res.vo.dashboard.InitPageVo;

public interface DashBoardQryService {
    /**
     * 初始化仪表盘
     *
     * @param initPageQry
     * @return
     */
    InitPageVo initPage(InitPageQry initPageQry);
}
