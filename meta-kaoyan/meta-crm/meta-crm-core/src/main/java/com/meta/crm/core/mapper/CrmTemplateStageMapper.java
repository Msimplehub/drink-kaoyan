package com.meta.crm.core.mapper;

import com.meta.crm.intf.entity.CrmTemplateStage;
import com.meta.crm.intf.req.ro.CrmTemplateStageRo;
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
public interface CrmTemplateStageMapper {

	/**
	 * insert crmTemplateStage info
	 * @method insertCrmTemplateStage
	 * @param       crmTemplateStage:
	 * @return void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	void insertCrmTemplateStage(CrmTemplateStage crmTemplateStage);

	/**
	 * batchInsert crmTemplateStage info
	 * @method insertCrmTemplateStage
	 * @param       crmTemplateStage:
	 * @return void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	void batchInsertCrmTemplateStage(List<CrmTemplateStage> crmTemplateStages);

	/**
	 * update crmTemplateStage info
	 * @method updateCrmTemplateStage
	 * @param       crmTemplateStage:
	 * @return int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	int updateCrmTemplateStage(CrmTemplateStage crmTemplateStage);

	/**
	 * update crmTemplateStage info by Pk
	 * @method updateCrmTemplateStageByPk
	 * @param       crmTemplateStage:
	 * @return int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	int updateCrmTemplateStageByPk(CrmTemplateStage crmTemplateStage);

	/**
	 * list crmTemplateStage info
	 * @method listCrmTemplateStage
	 * @param       crmTemplateStage:
	 * @return List<CrmTemplateStage>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	List<CrmTemplateStage> listCrmTemplateStage(CrmTemplateStageRo crmTemplateStageRo);

    List<CrmTemplateStage> queryDefaultStage(CrmTemplateStageRo crmTemplateStageRo);
}
