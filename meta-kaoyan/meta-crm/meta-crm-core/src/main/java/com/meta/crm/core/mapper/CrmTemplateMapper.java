package com.meta.crm.core.mapper;

import com.meta.crm.intf.entity.CrmTemplate;
import com.meta.crm.intf.req.ro.CrmTemplateRo;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:25
 */
@Repository
public interface CrmTemplateMapper {

	/**
	 * insert crmTemplate info
	 * @method insertCrmTemplate
	 * @param       crmTemplate:
	 * @return void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	void insertCrmTemplate(CrmTemplate crmTemplate);

	/**
	 * batchInsert crmTemplate info
	 * @method insertCrmTemplate
	 * @param       crmTemplate:
	 * @return void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	void batchInsertCrmTemplate(List<CrmTemplate> crmTemplates);

	/**
	 * update crmTemplate info
	 * @method updateCrmTemplate
	 * @param       crmTemplate:
	 * @return int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	int updateCrmTemplate(CrmTemplate crmTemplate);

	/**
	 * update crmTemplate info by Pk
	 * @method updateCrmTemplateByPk
	 * @param       crmTemplate:
	 * @return int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	int updateCrmTemplateByPk(CrmTemplate crmTemplate);

	/**
	 * list crmTemplate info
	 * @method listCrmTemplate
	 * @param       crmTemplate:
	 * @return List<CrmTemplate>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	List<CrmTemplate> listCrmTemplate(CrmTemplateRo crmTemplateRo);

    List<CrmTemplate> listValidCrmTemplate(CrmTemplateRo queryTemplateRo);
}
