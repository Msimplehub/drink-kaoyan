package com.meta.crm.core.mapper;

import com.meta.crm.intf.common.TargetObj;
import com.meta.crm.intf.entity.CrmFollow;
import com.meta.crm.intf.req.follow.BatchQueryLatestFollowRo;
import com.meta.crm.intf.req.ro.CrmFollowRo;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 *
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:26
 */
@Repository
public interface CrmFollowMapper {

	/**
	 * insert crmFollow info
	 * @method insertCrmFollow
	 * @param       crmFollow:
	 * @return void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	void insertCrmFollow(CrmFollow crmFollow);

	/**
	 * batchInsert crmFollow info
	 * @method insertCrmFollow
	 * @param       crmFollow:
	 * @return void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	void batchInsertCrmFollow(List<CrmFollow> crmFollows);

	/**
	 * update crmFollow info
	 * @method updateCrmFollow
	 * @param       crmFollow:
	 * @return int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	int updateCrmFollow(CrmFollow crmFollow);

	/**
	 * update crmFollow info by Pk
	 * @method updateCrmFollowByPk
	 * @param       crmFollow:
	 * @return int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	int updateCrmFollowByPk(CrmFollow crmFollow);

	/**
	 * list crmFollow info
	 * @method listCrmFollow
	 * @param       crmFollow:
	 * @return List<CrmFollow>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	List<CrmFollow> listCrmFollow(CrmFollowRo crmFollowRo);

	List<CrmFollow> listByTargets(List<TargetObj> targets);

    List<CrmFollow> batchQueryLatestFollowUp(BatchQueryLatestFollowRo clueIds);
}
