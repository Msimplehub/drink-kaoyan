package com.meta.crm.web.rest;

import com.meta.framework.common.annotation.Log;
import com.meta.framework.core.CommonRes;
import com.meta.framework.common.enums.BusinessType;
import com.meta.crm.intf.cmd.assign.BatchChangeManagerCmd;
import com.meta.crm.service.app.assign.CrmAssignAppService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.validation.Valid;


@RestController
@RequestMapping("/crmAssign")
public class CrmAssignController{

	@Resource
	private CrmAssignAppService crmAssignAppService;

	@PostMapping("/batchChangeManager")
	@Log(title = "批量分配", businessType = BusinessType.UPDATE)
	public void batchChangeManager(@Valid @RequestBody BatchChangeManagerCmd cmd)
	{
		crmAssignAppService.batchChangeManager(cmd);
	}
}
