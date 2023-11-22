package com.meta.crm.service.app.template.impl;

import com.meta.crm.intf.entity.*;
import com.meta.crm.domain.tunnel.db.*;
import com.meta.crm.intf.req.ro.CrmTemplateRo;
import com.meta.crm.service.app.template.CrmTemplateQryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 *  
 * @Title:      CrmTemplateQryServiceImpl
 * @Author:     M.simple
 * @Remark:     The modified content
 * @CreateDate: 2020-11-12 17:43:25
 * @Version:    v2.0
 */
@Service
public class CrmTemplateQryServiceImpl implements CrmTemplateQryService {

	@Autowired
	private CrmTemplateRepository  crmTemplateRepository;

	/**
	 * list crmTemplate info
	 * @method      listCrmTemplate
	 * @param       crmTemplate:
	 * @return      List<CrmTemplate>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	@Override
	public List<CrmTemplate> listCrmTemplate(CrmTemplateRo crmTemplate){
			return crmTemplateRepository.listCrmTemplate(crmTemplate);
	}

}
