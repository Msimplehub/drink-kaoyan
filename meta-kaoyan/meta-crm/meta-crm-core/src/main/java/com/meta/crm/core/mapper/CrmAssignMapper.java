package com.meta.crm.core.mapper;

import com.meta.crm.intf.entity.CrmAssignUser;
import com.meta.crm.intf.req.ro.CrmAssignRo;

import java.util.List;

/**
 *
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:25
 */
public interface CrmAssignMapper {

	/**
	 * insert crmAssign info
	 * @method insertCrmAssign
	 * @param       crmAssign:
	 * @return void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	void insertCrmAssign(CrmAssignUser crmAssign);

	/**
	 * batchInsert crmAssign info
	 * @method insertCrmAssign
	 * @return void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	void batchInsertCrmAssign(List<CrmAssignUser> crmAssigns);

	/**
	 * update crmAssign info
	 * @method updateCrmAssign
	 * @param       crmAssign:
	 * @return int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	int updateCrmAssign(CrmAssignUser crmAssign);

	/**
	 * update crmAssign info by Pk
	 * @method updateCrmAssignByPk
	 * @param       crmAssign:
	 * @return int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	int updateCrmAssignByPk(CrmAssignUser crmAssign);

	/**
	 * list crmAssign info
	 * @method listCrmAssign
	 * @param       crmAssignRo:
	 * @return List<CrmAssign>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	List<CrmAssignUser> listCrmAssign(CrmAssignRo crmAssignRo);

	/**
	 * list crmAssign info
	 * @method listCrmAssign
	 * @param       params  keys: targetIds, targetType:
	 * @return List<CrmAssign>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	List<CrmAssignUser> listByTargetIds(CrmAssignRo crmAssignRo);

}
