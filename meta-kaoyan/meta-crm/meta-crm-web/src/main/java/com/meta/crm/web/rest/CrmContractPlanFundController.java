package com.meta.crm.web.rest;

import com.github.pagehelper.PageHelper;
import com.meta.crm.intf.cmd.contractplanfund.CrmAddContractPlanFundCmd;
import com.meta.crm.intf.cmd.contractplanfund.CrmUpdateContractPlanFundCmd;
import com.meta.crm.intf.req.contractplanfund.PlanFundDetailQry;
import com.meta.crm.intf.req.ro.CrmContractPlanFundRo;
import com.meta.crm.intf.res.vo.contractplanfund.CrmContractPlanFundDetailVo;
import com.meta.crm.intf.res.vo.contractplanfund.CrmContractPlanFundVo;
import com.meta.crm.service.app.contractplanfund.CrmContractPlanFundAppService;
import com.meta.crm.service.app.contractplanfund.CrmContractPlanFundQryService;
import com.meta.framework.common.annotation.Log;
import com.meta.framework.common.core.controller.BaseController;
import com.meta.framework.common.core.page.TableDataInfo;
import com.meta.framework.common.enums.BusinessType;
import com.meta.framework.core.CommonRes;
import com.meta.framework.util.PageLocalHepler;
import com.meta.platform.contract.intf.cmd.contractplanfund.AddContractPlanFundCmd;
import com.meta.platform.contract.intf.cmd.contractplanfund.CheckAmountCmd;
import com.meta.platform.contract.intf.cmd.contractplanfund.UpdateContractPlanFundCmd;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;

@RestController
@RequestMapping("crmContractPlanFund")
public class CrmContractPlanFundController extends BaseController {

    @Resource
    private CrmContractPlanFundAppService fundAppService;

    @Resource
    private CrmContractPlanFundQryService fundQryService;

    @PostMapping("/create")
    @Log(title = "创建回款计划", businessType = BusinessType.INSERT)
    public CommonRes create(@Valid @RequestBody CrmAddContractPlanFundCmd addContractPlanFundCmd) {
        fundAppService.createPlanFund(addContractPlanFundCmd);
        return CommonRes.success();
    }

    @PostMapping("/update")
    @Log(title = "更新回款计划", businessType = BusinessType.UPDATE)
    public CommonRes update(@RequestBody CrmUpdateContractPlanFundCmd updateContractPlanFundCmd) {
        fundAppService.updatePlanFund(updateContractPlanFundCmd);
        return CommonRes.success();
    }

    @GetMapping("/list")
    @Log(title = "分页查询回款计划列表", businessType = BusinessType.QUERY)
    public TableDataInfo<CrmContractPlanFundVo> list(CrmContractPlanFundRo planFundRo) {
        startPage();
        PageLocalHepler.setPageLocal(PageHelper.getLocalPage());
        TableDataInfo res = getDataTable(fundQryService.list(planFundRo));
        res.setTotal(PageLocalHepler.getTotal());
        PageLocalHepler.clear();
        return res;
    }

    @GetMapping("/detail")
    @Log(title = "回款计划详情", businessType = BusinessType.QUERY)
    public CommonRes<CrmContractPlanFundDetailVo> detail(PlanFundDetailQry planFundRo) {
        return CommonRes.success(fundQryService.detail(planFundRo));
    }

    @GetMapping("/listNoPage")
    @Log(title = "详情页查询回款计划列表", businessType = BusinessType.QUERY)
    public TableDataInfo<CrmContractPlanFundVo> listNoPage(CrmContractPlanFundRo planFundRo) {
        TableDataInfo res = getDataTable(fundQryService.listSimple(planFundRo));
        return res;
    }

}
