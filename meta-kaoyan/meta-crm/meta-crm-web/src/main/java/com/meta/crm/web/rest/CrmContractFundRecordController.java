package com.meta.crm.web.rest;

import com.github.pagehelper.PageHelper;
import com.meta.crm.intf.cmd.contractfundrecord.CrmAddContractFundRecordCmd;
import com.meta.crm.intf.req.contractfundrecord.FundRecordDetailQry;
import com.meta.crm.intf.req.ro.CrmContractFundRecordRo;
import com.meta.crm.intf.req.ro.CrmContractPlanFundRo;
import com.meta.crm.intf.res.vo.contract.CrmContractDetailVo;
import com.meta.crm.intf.res.vo.contractfundrecord.CrmContractFundRecordDetailVo;
import com.meta.crm.intf.res.vo.contractfundrecord.CrmContractFundRecordVo;
import com.meta.crm.intf.res.vo.contractplanfund.CrmContractPlanFundVo;
import com.meta.crm.service.app.contractfundrecord.CrmContractFundRecordAppService;
import com.meta.crm.service.app.contractfundrecord.CrmContractFundRecordQryService;
import com.meta.crm.service.app.contractplanfund.CrmContractPlanFundAppService;
import com.meta.crm.service.app.contractplanfund.CrmContractPlanFundQryService;
import com.meta.framework.common.annotation.Log;
import com.meta.framework.common.core.controller.BaseController;
import com.meta.framework.common.core.page.TableDataInfo;
import com.meta.framework.common.enums.BusinessType;
import com.meta.framework.core.CommonRes;
import com.meta.framework.util.PageLocalHepler;
import com.meta.platform.contract.intf.cmd.contractfundrecord.AddContractFundRecordCmd;
import com.meta.platform.contract.intf.cmd.contractplanfund.AddContractPlanFundCmd;
import com.meta.platform.contract.intf.cmd.contractplanfund.CheckAmountCmd;
import com.meta.platform.contract.intf.cmd.contractplanfund.UpdateContractPlanFundCmd;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;

@RestController
@RequestMapping("crmContractFundRecord")
public class CrmContractFundRecordController extends BaseController {

    @Resource
    private CrmContractFundRecordAppService recordAppService;

    @Resource
    private CrmContractFundRecordQryService recordQryService;

    @PostMapping("/create")
    @Log(title = "创建回款计划", businessType = BusinessType.INSERT)
    public CommonRes create(@Valid @RequestBody CrmAddContractFundRecordCmd addContractFundRecordCmd) {
        recordAppService.createFundRecord(addContractFundRecordCmd);
        return CommonRes.success();
    }

    @GetMapping("/list")
    @Log(title = "分页查询回款计划列表", businessType = BusinessType.QUERY)
    public TableDataInfo<CrmContractFundRecordVo> list(CrmContractFundRecordRo recordRo) {
        recordRo.dealTime();
        startPage();
        PageLocalHepler.setPageLocal(PageHelper.getLocalPage());
        TableDataInfo res = getDataTable(recordQryService.list(recordRo));
        res.setTotal(PageLocalHepler.getTotal());
        PageLocalHepler.clear();
        return res;
    }

    @GetMapping("/listNoPage")
    @Log(title = "详情页查询回款计划列表", businessType = BusinessType.QUERY)
    public TableDataInfo<CrmContractFundRecordVo> listNoPage(CrmContractFundRecordRo recordRo) {
        TableDataInfo res = getDataTable(recordQryService.listSimple(recordRo));
        return res;
    }

    @GetMapping("/detail")
    @Log(title = "详情页查询回款计划列表", businessType = BusinessType.QUERY)
    public CommonRes<CrmContractFundRecordDetailVo> detail(FundRecordDetailQry fundRecordDetailQry) {
        CrmContractFundRecordDetailVo res = recordQryService.detail(fundRecordDetailQry);
        return CommonRes.success(res);
    }

}
