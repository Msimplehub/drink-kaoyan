package com.meta.crm.web.rest;

import com.meta.crm.intf.cmd.follow.AddFollowCmd;
import com.meta.crm.intf.req.follow.ListFollowByTargetRo;
import com.meta.crm.intf.req.ro.CrmFollowRo;
import com.meta.crm.intf.res.vo.follow.CrmFollowVo;
import com.meta.framework.util.PageLocalHepler;
import com.meta.crm.service.app.follow.CrmFollowAppService;
import com.meta.crm.service.app.follow.CrmFollowQryService;
import com.meta.framework.common.annotation.Log;
import com.meta.framework.common.core.controller.BaseController;
import com.meta.framework.common.core.page.TableDataInfo;
import com.meta.framework.common.enums.BusinessType;
import com.meta.framework.core.CommonRes;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;

@RestController
@RequestMapping("crmFollow")
public class CrmFollowController extends BaseController {

    @Resource
    private CrmFollowAppService crmFollowAppService;

    @Resource
    private CrmFollowQryService crmFollowQryService;

    @PostMapping("/create")
    @Log(title = "记录跟进", businessType = BusinessType.INSERT)
    public void create(@Valid @RequestBody AddFollowCmd addFollowCmd) {
        crmFollowAppService.insertFollow(addFollowCmd);
    }

    @GetMapping("/listByTarget")
    @Log(title = "查询目标对象下跟进记录", businessType = BusinessType.QUERY)
    public TableDataInfo<CrmFollowVo> listByTarget(ListFollowByTargetRo listFollowByTargetRo) {
        TableDataInfo res = getDataTable(crmFollowQryService.listByTarget(listFollowByTargetRo));
        res.setTotal(PageLocalHepler.getTotal());
        PageLocalHepler.clear();
        return res;
    }

    @GetMapping("/list")
    @Log(title = "查询跟进记录", businessType = BusinessType.QUERY)
    public TableDataInfo<CrmFollowVo> list(CrmFollowRo crmFollowRo) {
        TableDataInfo res = getDataTable(crmFollowQryService.listPage(crmFollowRo));
        res.setTotal(PageLocalHepler.getTotal());
        PageLocalHepler.clear();
        return res;
    }

}
