package com.meta.crm.domain.tunnel.db;


import com.meta.crm.intf.entity.CrmTemplateStage;
import com.meta.crm.intf.req.ro.CrmTemplateStageRo;

import java.util.List;

/**
 * 
 * 
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:25
 */
public interface CrmTemplateStageRepository{

	/**
	 * insert crmTemplateStage info
	 * @method      insertCrmTemplateStage
	 * @param       crmTemplateStage:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	void insertCrmTemplateStage(CrmTemplateStage crmTemplateStage);

	/**
	 * batch insert crmTemplateStage info
	 * @method      insertCrmTemplateStage
	 * @param       crmTemplateStages:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	void batchInsertCrmTemplateStage(List<CrmTemplateStage> crmTemplateStages);

	/**
	 * update crmTemplateStage info
	 * @method      updateCrmTemplateStage
	 * @param       crmTemplateStage:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	int updateCrmTemplateStage(CrmTemplateStage crmTemplateStage);

	/**
	 * update crmTemplateStage info By pk
	 * @method      updateCrmTemplateStageByPk
	 * @param       crmTemplateStage:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	int updateCrmTemplateStageByPk(CrmTemplateStage crmTemplateStage);

	/**
	 * list crmTemplateStage info
	 * @method      listCrmTemplateStage
	 * @param       crmTemplateStage:
	 * @return      List<CrmTemplateStage>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	List<CrmTemplateStage> listCrmTemplateStage(CrmTemplateStageRo crmTemplateStage);

	/**
	 * 查询默认阶段
	 * @param crmTemplateStageRo
	 * @return
	 */
	List<CrmTemplateStage> queryDefaultStage(CrmTemplateStageRo crmTemplateStageRo);
}
