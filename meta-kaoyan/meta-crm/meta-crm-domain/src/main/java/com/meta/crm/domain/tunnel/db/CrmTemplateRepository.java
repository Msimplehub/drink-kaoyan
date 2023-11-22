package com.meta.crm.domain.tunnel.db;


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
public interface CrmTemplateRepository{

	/**
	 * insert crmTemplate info
	 * @method      insertCrmTemplate
	 * @param       crmTemplate:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	void insertCrmTemplate(CrmTemplate crmTemplate);

	/**
	 * batch insert crmTemplate info
	 * @method      insertCrmTemplate
	 * @param       crmTemplates:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	void batchInsertCrmTemplate(List<CrmTemplate> crmTemplates);

	/**
	 * update crmTemplate info
	 * @method      updateCrmTemplate
	 * @param       crmTemplate:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	int updateCrmTemplate(CrmTemplate crmTemplate);

	/**
	 * update crmTemplate info By pk
	 * @method      updateCrmTemplateByPk
	 * @param       crmTemplate:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	int updateCrmTemplateByPk(CrmTemplate crmTemplate);

	/**
	 * list crmTemplate info
	 * @method      listCrmTemplate
	 * @param       crmTemplate:
	 * @return      List<CrmTemplate>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	List<CrmTemplate> listCrmTemplate(CrmTemplateRo crmTemplate);

    List<CrmTemplate> listValidCrmTemplate(CrmTemplateRo queryTemplateRo);
}
