package com.meta.crm.web.rest;

import com.github.pagehelper.PageHelper;
import com.meta.crm.domain.aggr.CrmContactDo;
import com.meta.framework.common.annotation.Log;
import com.meta.framework.common.core.controller.BaseController;
import com.meta.framework.core.CommonRes;
import com.meta.framework.common.core.page.TableDataInfo;
import com.meta.framework.common.enums.BusinessType;
import com.meta.crm.intf.cmd.contact.AddContactCmd;
import com.meta.crm.intf.cmd.contact.UpdateContactCmd;
import com.meta.crm.intf.req.ro.CrmContactRo;
import com.meta.crm.intf.res.vo.contact.CrmContactByCustomerVo;
import com.meta.crm.intf.res.vo.contact.CrmContactVo;
import com.meta.framework.util.PageLocalHepler;
import com.meta.crm.service.app.contact.CrmContactAppService;
import com.meta.crm.service.app.contact.CrmContactQryService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("crmContact")
public class CrmContactController extends BaseController {

    @Resource
    private CrmContactQryService crmContactQryService;

    @Resource
    private CrmContactAppService crmContactAppService;

    @GetMapping("/list")
    @Log(title = "查询联系人列表", businessType = BusinessType.QUERY)
    public TableDataInfo list(CrmContactRo crmContactRo) {
        startPage();
        PageLocalHepler.setPageLocal(PageHelper.getLocalPage());
        TableDataInfo res = getDataTable(crmContactQryService.listCrmContacts(crmContactRo));
        res.setTotal(PageLocalHepler.getTotal());
        PageLocalHepler.clear();
        return res;
    }

    @GetMapping("/listNoPage")
    @Log(title = "查询联系人列表不分页", businessType = BusinessType.QUERY)
    public List<CrmContactVo> listNoPage(CrmContactRo crmContactRo) {
        return crmContactQryService.listCrmContacts(crmContactRo);
    }

    @GetMapping("/listByCustomerId")
    @Log(title = "根据客户ID查询联系人", businessType = BusinessType.QUERY)
    public List<CrmContactByCustomerVo> listCrmContactsByCustomerId(Long customerId) {
        return crmContactQryService.listCrmContactsByCustomerId(customerId);
    }

    @GetMapping("/detail")
    @Log(title = "查询联系人详情", businessType = BusinessType.QUERY)
    public CrmContactVo detail(CrmContactRo crmContactRo) {
        return crmContactQryService.getDetailById(crmContactRo.getId());
    }

    @GetMapping("/queryByMobileAndCustomer")
    @Log(title = "根据手机号和客户查询联系人", businessType = BusinessType.QUERY)
    public CrmContactDo queryByMobileAndCustomer(CrmContactRo crmContactRo) {
        return crmContactQryService.getContactByMobileAndCustomer(crmContactRo);
    }

    @PostMapping("/create")
    @Log(title = "创建联系人", businessType = BusinessType.INSERT)
    public void create(@Valid @RequestBody AddContactCmd addContactCmd) {
        crmContactAppService.insertContact(addContactCmd);
    }

    @PostMapping("/update")
    @Log(title = "更新联系人", businessType = BusinessType.UPDATE)
    public void update(@Valid @RequestBody UpdateContactCmd updateContactCmd) {
        crmContactAppService.updateContact(updateContactCmd);
    }

}
