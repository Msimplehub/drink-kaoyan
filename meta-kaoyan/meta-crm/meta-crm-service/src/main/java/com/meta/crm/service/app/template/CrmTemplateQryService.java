package com.meta.crm.service.app.template;

import com.meta.crm.intf.entity.CrmTemplate;
import com.meta.crm.intf.req.ro.CrmTemplateRo;

import java.util.List;

/**
 * 
 * 
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:25
 */
public interface CrmTemplateQryService{

	/**
	 * list crmTemplate info
	 * @method      listCrmTemplate
	 * @param       crmTemplate:
	 * @return      List<CrmTemplate>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	List<CrmTemplate> listCrmTemplate(CrmTemplateRo crmTemplate);

}
