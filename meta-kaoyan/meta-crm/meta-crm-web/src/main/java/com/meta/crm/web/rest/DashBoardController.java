package com.meta.crm.web.rest;

import com.meta.framework.common.annotation.Log;
import com.meta.framework.core.CommonRes;
import com.meta.framework.common.enums.BusinessType;
import com.meta.crm.intf.req.dashboard.InitPageQry;
import com.meta.crm.intf.res.vo.dashboard.InitPageVo;
import com.meta.crm.service.app.dashboard.DashBoardQryService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/crmDashBoard")
public class DashBoardController {

    @Resource
    private DashBoardQryService dashBoardQryService;

    @GetMapping("/initPage")
    @Log(title = "查询仪表盘", businessType = BusinessType.QUERY)
    public InitPageVo initPage(InitPageQry initPageQry) {
        return dashBoardQryService.initPage(initPageQry);
    }
}
