package com.meta.crm.web.rest;

import com.meta.crm.intf.cmd.contract.CrmContractSaveCmd;
import com.meta.crm.intf.cmd.contract.CrmContractUpdateCmd;
import com.meta.crm.intf.req.contract.CrmContractDetailQry;
import com.meta.crm.intf.req.contract.CrmContractListByCustomerBusinessQry;
import com.meta.crm.intf.req.contract.CrmContractListForFundPlanQry;
import com.meta.crm.intf.req.contract.CrmContractListQry;
import com.meta.crm.intf.req.contract.CrmContractNameCheckQry;
import com.meta.crm.intf.res.vo.contract.CrmContractListByCustomerBusinessVo;
import com.meta.crm.intf.res.vo.contract.CrmContractListVo;
import com.meta.crm.service.app.contract.CrmContractAppService;
import com.meta.crm.service.app.contract.CrmContractQryService;
import com.meta.framework.common.annotation.Log;
import com.meta.framework.common.core.controller.BaseController;
import com.meta.framework.common.core.page.TableDataInfo;
import com.meta.framework.common.enums.BusinessType;
import com.meta.framework.core.CommonRes;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("crmContract")
public class CrmContractController extends BaseController {

    @Resource
    private CrmContractAppService crmContractAppService;

    @Resource
    private CrmContractQryService crmContractQryService;

    @GetMapping("/checkContractName")
    @Log(title = "校验合同名称", businessType = BusinessType.QUERY)
    public CommonRes checkContractName(@Valid CrmContractNameCheckQry contractNameCheckQry) {
        return CommonRes.success(crmContractQryService.checkContractName(contractNameCheckQry));
    }

    @PostMapping("/create")
    @Log(title = "创建合同", businessType = BusinessType.INSERT)
    public CommonRes create(@Valid @RequestBody CrmContractSaveCmd addContractCmd) {
        crmContractAppService.create(addContractCmd);
        return CommonRes.success();
    }

    @GetMapping("/queryDetail")
    @Log(title = "查询合同详情", businessType = BusinessType.QUERY)
    public CommonRes queryDetail(@Valid CrmContractDetailQry crmContractDetailQry) {
        return CommonRes.success(crmContractQryService.queryDetail(crmContractDetailQry));
    }

    @PutMapping("/update")
    @Log(title = "更新合同", businessType = BusinessType.UPDATE)
    public CommonRes update(@Valid @RequestBody CrmContractUpdateCmd crmContractUpdateCmd) {
        crmContractAppService.update(crmContractUpdateCmd);
        return CommonRes.success();
    }

    @GetMapping("/queryList")
    @Log(title = "查询合同列表", businessType = BusinessType.QUERY)
    public TableDataInfo queryList(CrmContractListQry crmContractListQry) {
        startPage();
        List<CrmContractListVo> crmContractListVos = crmContractQryService.queryList(crmContractListQry);
        return getDataTable(crmContractListVos);
    }

    @GetMapping("/queryListForFundPlan")
    @Log(title = "创建回款计划查询列表", businessType = BusinessType.QUERY)
    public CommonRes queryListForFundPlan(CrmContractListForFundPlanQry crmContractListQry) {
        return CommonRes.success(crmContractQryService.queryListForFundPlan(crmContractListQry));
    }

    @GetMapping("/queryListByCustomerOrBusinessId")
    @Log(title = "根据客户id或者商机id查询合同列表", businessType = BusinessType.QUERY)
    public CommonRes queryListByCustomerOrBusinessId(CrmContractListByCustomerBusinessQry crmContractListQry) {
        List<CrmContractListByCustomerBusinessVo> crmContractListByCustomerBusinessVos = crmContractQryService.
                queryListByCustomerOrBusinessId(crmContractListQry);
        return CommonRes.success(crmContractListByCustomerBusinessVos);
    }

}
