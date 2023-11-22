package com.meta.crm.core.repository.impl;

import com.meta.crm.core.mapper.CrmTemplateStageMapper;
import com.meta.crm.domain.tunnel.db.*;
import com.meta.crm.intf.entity.*;
import com.meta.crm.intf.req.ro.CrmTemplateStageRo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 *  
 * @Title:      CrmTemplateStageRepositoryImpl
 * @Author:     M.simple
 * @Remark:     The modified content
 * @CreateDate: 2020-11-12 17:43:25
 * @Version:    v2.0
 */
@Service
public class CrmTemplateStageRepositoryImpl implements CrmTemplateStageRepository{

	@Autowired
	private CrmTemplateStageMapper crmTemplateStageMapper;

	/**
	 * insert crmTemplateStage info
	 * @method      insertCrmTemplateStage
	 * @param       crmTemplateStage:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	@Override
	public void insertCrmTemplateStage(CrmTemplateStage crmTemplateStage){
			crmTemplateStageMapper.insertCrmTemplateStage(crmTemplateStage);
	}

	/**
	 * batch insert crmTemplateStage info
	 * @method      insertCrmTemplateStage
	 * @param       crmTemplateStages:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	@Override
	public void batchInsertCrmTemplateStage(List<CrmTemplateStage> crmTemplateStages){
			crmTemplateStageMapper.batchInsertCrmTemplateStage(crmTemplateStages);
	}

	/**
	 * update crmTemplateStage info
	 * @method      updateCrmTemplateStage
	 * @param       crmTemplateStage:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	@Override
	public int updateCrmTemplateStage(CrmTemplateStage crmTemplateStage){
			return crmTemplateStageMapper.updateCrmTemplateStage(crmTemplateStage);
	}

	/**
	 * update crmTemplateStage info by Pk
	 * @method      updateCrmTemplateStageByPk
	 * @param       crmTemplateStage:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	@Override
	public int updateCrmTemplateStageByPk(CrmTemplateStage crmTemplateStage){
		return crmTemplateStageMapper.updateCrmTemplateStageByPk(crmTemplateStage);
	}

	/**
	 * list crmTemplateStage info
	 * @method      listCrmTemplateStage
	 * @param       crmTemplateStage:
	 * @return      List<CrmTemplateStage>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	@Override
	public List<CrmTemplateStage> listCrmTemplateStage(CrmTemplateStageRo crmTemplateStage){
			return crmTemplateStageMapper.listCrmTemplateStage(crmTemplateStage);
	}

	@Override
	public List<CrmTemplateStage> queryDefaultStage(CrmTemplateStageRo crmTemplateStageRo) {
		return crmTemplateStageMapper.queryDefaultStage(crmTemplateStageRo);
	}
}
