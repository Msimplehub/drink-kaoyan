package com.meta.crm.web.rest;

import com.meta.framework.common.annotation.Log;
import com.meta.framework.common.core.controller.BaseController;
import com.meta.framework.core.CommonRes;
import com.meta.framework.common.core.page.TableDataInfo;
import com.meta.framework.common.enums.BusinessType;
import com.meta.crm.intf.cmd.business.BusinessChangeContactCmd;
import com.meta.crm.intf.cmd.business.BusinessChangeStageCmd;
import com.meta.crm.intf.cmd.business.BusinessSaveCmd;
import com.meta.crm.intf.cmd.business.BusinessUpdateCmd;
import com.meta.crm.intf.req.business.BusinessContactQry;
import com.meta.crm.intf.req.business.BusinessDetailQry;
import com.meta.crm.intf.req.business.BusinessListQry;
import com.meta.crm.intf.req.business.BusinessNameCheckQry;
import com.meta.crm.intf.req.business.CustomerBusinessListQry;
import com.meta.crm.intf.res.vo.business.BusinessContactDetailListVo;
import com.meta.crm.intf.res.vo.business.BusinessDetailVo;
import com.meta.crm.intf.res.vo.business.BusinessListVo;
import com.meta.crm.intf.res.vo.business.BusinessNameCheckVo;
import com.meta.crm.intf.res.vo.business.CustomerBusinessListVo;
import com.meta.crm.service.app.business.CrmBusinessAppService;
import com.meta.crm.service.app.business.CrmBusinessQryService;
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
@RequestMapping("/crmBusiness")
public class CrmBusinessController extends BaseController {

    @Resource
    private CrmBusinessQryService crmBusinessQryService;

    @Resource
    private CrmBusinessAppService crmBusinessAppService;

    @GetMapping("/queryList")
    @Log(title = "查询商机列表", businessType = BusinessType.QUERY)
    public TableDataInfo<BusinessListVo> queryList(@Valid BusinessListQry req) {
        startPage();
        List<BusinessListVo> businessListVos = crmBusinessQryService.queryList(req);
        return getDataTable(businessListVos);
    }

    @GetMapping("/businessNameCheck")
    @Log(title = "检验商机名称是否重复", businessType = BusinessType.QUERY)
    public BusinessNameCheckVo businessNameCheck(@Validated BusinessNameCheckQry req) {
        return crmBusinessQryService.businessNameCheck(req);
    }

    @PostMapping("/add")
    @Log(title = "新增商机", businessType = BusinessType.INSERT)
    public void add(@Validated @RequestBody BusinessSaveCmd req) {
        crmBusinessAppService.add(req);
    }

    @GetMapping("/detail")
    @Log(title = "查询商机详情", businessType = BusinessType.QUERY)
    public BusinessDetailVo detail(@Validated BusinessDetailQry req) {
        return crmBusinessQryService.detail(req);
    }

    @PutMapping("/update")
    @Log(title = "更新商机", businessType = BusinessType.UPDATE)
    public void update(@Validated @RequestBody BusinessUpdateCmd req) {
        crmBusinessAppService.update(req);
    }

    @PostMapping("/changeStage")
    @Log(title = "变更商机阶段", businessType = BusinessType.UPDATE)
    public void changeStage(@Validated @RequestBody BusinessChangeStageCmd req) {
        crmBusinessAppService.changeStage(req);
    }

    @PostMapping("/changeContact")
    @Log(title = "变更商机联系人", businessType = BusinessType.UPDATE)
    public void changeContact(@Validated @RequestBody BusinessChangeContactCmd req) {
        crmBusinessAppService.changeContact(req);
    }

    @GetMapping("/queryByCustomerId")
    @Log(title = "查询联系人/客户关联商机列表", businessType = BusinessType.QUERY)
    public List<CustomerBusinessListVo> queryByCustomerId(@Validated CustomerBusinessListQry req) {
        return crmBusinessQryService.queryByCustomerId(req);
    }

    @GetMapping("/queryBusinessContact")
    @Log(title = "查询商机下联系人", businessType = BusinessType.QUERY)
    public List<BusinessContactDetailListVo> queryBusinessContact(@Validated BusinessContactQry req) {
        return crmBusinessQryService.queryBusinessContact(req);
    }
}
