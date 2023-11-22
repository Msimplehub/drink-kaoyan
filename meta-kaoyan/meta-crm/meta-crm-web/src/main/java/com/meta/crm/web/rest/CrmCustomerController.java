package com.meta.crm.web.rest;

import com.github.pagehelper.PageHelper;
import com.meta.crm.intf.res.vo.customer.CrmCustomerDetailVo;
import com.meta.framework.common.annotation.Log;
import com.meta.framework.common.core.controller.BaseController;
import com.meta.framework.core.CommonRes;
import com.meta.framework.common.core.page.TableDataInfo;
import com.meta.framework.common.enums.BusinessType;
import com.meta.crm.intf.cmd.customer.AddCustomerCmd;
import com.meta.crm.intf.cmd.customer.UpdateCustomerCmd;
import com.meta.crm.domain.aggr.CrmCustomerDo;
import com.meta.crm.intf.req.ro.CrmCustomerRo;
import com.meta.crm.intf.res.vo.customer.CrmCustomerVo;
import com.meta.framework.util.PageLocalHepler;
import com.meta.crm.service.app.customer.CrmCustomerAppService;
import com.meta.crm.service.app.customer.CrmCustomerQryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("crmCustomer")
@Api("客户api")
public class CrmCustomerController extends BaseController {

    @Resource
    private CrmCustomerQryService crmCustomerQryService;

    @Resource
    private CrmCustomerAppService crmCustomerAppService;

    @GetMapping("/list")
    @ApiOperation("查询客户列表")
    @Log(title = "查询客户列表", businessType = BusinessType.QUERY)
    public TableDataInfo<CrmCustomerVo> list(CrmCustomerRo customerRo) {
        startPage();
        PageLocalHepler.setPageLocal(PageHelper.getLocalPage());
        TableDataInfo<CrmCustomerVo> res = getDataTable(crmCustomerQryService.listCrmCustomerVo(customerRo));
        res.setTotal(PageLocalHepler.getTotal());
        PageLocalHepler.clear();
        return res;
    }

    @GetMapping("/listAll")
    @ApiOperation("查询租户下客户列表")
    @Log(title = "查询租户下客户列表", businessType = BusinessType.QUERY)
    public List<CrmCustomerVo> listAll(CrmCustomerRo customerRo) {
        // TODO 简化
        return crmCustomerQryService.listCrmCustomerVo(customerRo);
    }

    @GetMapping("/detail")
    @ApiOperation("查询客户详情")
    @Log(title = "查询客户详情", businessType = BusinessType.QUERY)
    public CommonRes<CrmCustomerDetailVo> detail(CrmCustomerRo customerRo) {
        return CommonRes.success(crmCustomerQryService.queryDetailById(customerRo.getId()));
    }

    @GetMapping("/querySimpleInfoByName")
    @Log(title = "查询客户简易详情", businessType = BusinessType.QUERY)
    public CrmCustomerDo querySimpleInfoByName(String customerName) {
        return crmCustomerQryService.queryByName(customerName);
    }

    @PostMapping("/create")
    @Log(title = "创建客户", businessType = BusinessType.INSERT)
    public void create(@Valid @RequestBody AddCustomerCmd addCustomerCmd) {
        crmCustomerAppService.insertCrmCustomer(addCustomerCmd);
    }

    @PostMapping("/update")
    @Log(title = "更新客户", businessType = BusinessType.UPDATE)
    public void update(@RequestBody UpdateCustomerCmd updateCustomerCmd) {
        crmCustomerAppService.updateCrmCustomer(updateCustomerCmd);
    }

}
