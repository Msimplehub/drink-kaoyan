package com.meta.crm.web.rest;

import com.meta.crm.intf.cmd.invoice.CrmContractInvoiceCreateCmd;
import com.meta.crm.intf.cmd.invoice.CrmContractInvoiceDetailQry;
import com.meta.crm.intf.cmd.invoice.CrmContractInvoiceUpdateCmd;
import com.meta.crm.intf.req.invoice.CrmInvoiceListByCustomerIdQry;
import com.meta.crm.intf.req.invoice.CrmInvoiceListQry;
import com.meta.crm.intf.res.vo.invoice.CrmInvoiceListVo;
import com.meta.crm.service.app.invoice.CrmContractInvoiceAppService;
import com.meta.crm.service.app.invoice.CrmContractInvoiceQryService;
import com.meta.framework.common.annotation.Log;
import com.meta.framework.common.core.controller.BaseController;
import com.meta.framework.common.core.page.TableDataInfo;
import com.meta.framework.common.enums.BusinessType;
import com.meta.framework.core.CommonRes;
import org.springframework.validation.annotation.Validated;
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
@RequestMapping("crmContractInvoice")
public class CrmContractInvoiceController extends BaseController {

    @Resource
    private CrmContractInvoiceAppService crmContractInvoiceAppService;

    @Resource
    private CrmContractInvoiceQryService crmContractInvoiceQryService;

    @PostMapping("/create")
    @Log(title = "创建发票", businessType = BusinessType.INSERT)
    public CommonRes create(@Valid @RequestBody CrmContractInvoiceCreateCmd addContractInvoiceCmd) {
        crmContractInvoiceAppService.create(addContractInvoiceCmd);
        return CommonRes.success();
    }

    @GetMapping("/queryDetail")
    @Log(title = "查询发票详情", businessType = BusinessType.QUERY)
    public CommonRes queryDetail(@Valid CrmContractInvoiceDetailQry crmContractInvoiceDetailQry) {
        return CommonRes.success(crmContractInvoiceQryService.queryDetail(crmContractInvoiceDetailQry));
    }

    @PutMapping("/update")
    @Log(title = "更新发票", businessType = BusinessType.UPDATE)
    public CommonRes update(@Valid @RequestBody CrmContractInvoiceUpdateCmd crmContractInvoiceUpdateCmd) {
        crmContractInvoiceAppService.update(crmContractInvoiceUpdateCmd);
        return CommonRes.success();
    }

    @GetMapping("/queryList")
    @Log(title = "查询发票列表", businessType = BusinessType.QUERY)
    public TableDataInfo queryList(@Validated CrmInvoiceListQry crmInvoiceListQry) {
        startPage();
        List<CrmInvoiceListVo> crmContractListVos = crmContractInvoiceQryService.queryList(crmInvoiceListQry);
        return getDataTable(crmContractListVos);
    }

    @GetMapping("/queryListByCustomerId")
    @Log(title = "查询发票列表", businessType = BusinessType.QUERY)
    public CommonRes queryListByCustomerId(@Validated CrmInvoiceListByCustomerIdQry crmInvoiceListQry) {
        return CommonRes.success(crmContractInvoiceQryService.queryListByCustomerId(crmInvoiceListQry));
    }

}
