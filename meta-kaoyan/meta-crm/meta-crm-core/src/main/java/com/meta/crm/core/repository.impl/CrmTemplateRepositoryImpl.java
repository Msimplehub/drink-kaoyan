package com.meta.crm.core.repository.impl;

import com.meta.crm.core.mapper.CrmTemplateMapper;
import com.meta.crm.domain.tunnel.db.*;
import com.meta.crm.intf.entity.*;
import com.meta.crm.intf.req.ro.CrmTemplateRo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 *  
 * @Title:      CrmTemplateRepositoryImpl
 * @Author:     M.simple
 * @Remark:     The modified content
 * @CreateDate: 2020-11-12 17:43:25
 * @Version:    v2.0
 */
@Service
public class CrmTemplateRepositoryImpl implements CrmTemplateRepository{

	@Autowired
	private CrmTemplateMapper crmTemplateMapper;

	/**
	 * insert crmTemplate info
	 * @method      insertCrmTemplate
	 * @param       crmTemplate:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	@Override
	public void insertCrmTemplate(CrmTemplate crmTemplate){
			crmTemplateMapper.insertCrmTemplate(crmTemplate);
	}

	/**
	 * batch insert crmTemplate info
	 * @method      insertCrmTemplate
	 * @param       crmTemplates:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	@Override
	public void batchInsertCrmTemplate(List<CrmTemplate> crmTemplates){
			crmTemplateMapper.batchInsertCrmTemplate(crmTemplates);
	}

	/**
	 * update crmTemplate info
	 * @method      updateCrmTemplate
	 * @param       crmTemplate:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	@Override
	public int updateCrmTemplate(CrmTemplate crmTemplate){
			return crmTemplateMapper.updateCrmTemplate(crmTemplate);
	}

	/**
	 * update crmTemplate info by Pk
	 * @method      updateCrmTemplateByPk
	 * @param       crmTemplate:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	@Override
	public int updateCrmTemplateByPk(CrmTemplate crmTemplate){
		return crmTemplateMapper.updateCrmTemplateByPk(crmTemplate);
	}

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
			return crmTemplateMapper.listCrmTemplate(crmTemplate);
	}

	@Override
	public List<CrmTemplate> listValidCrmTemplate(CrmTemplateRo queryTemplateRo) {
		return crmTemplateMapper.listValidCrmTemplate(queryTemplateRo);
	}
}
