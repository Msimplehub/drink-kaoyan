package com.meta.crm.domain.tunnel.db;


import com.meta.crm.intf.entity.CrmFollow;
import com.meta.crm.domain.aggr.CrmFollowDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.follow.BatchQueryLatestFollowRo;
import com.meta.crm.intf.req.follow.ListFollowByTargetListRo;
import com.meta.crm.intf.req.ro.CrmFollowRo;

import java.util.List;
import java.util.Map;

/**
 *
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:26
 */
public interface CrmFollowRepository{

	/**
	 * insert crmFollow info
	 * @method      insertCrmFollow
	 * @param       crmFollow:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	void insertCrmFollow(CrmFollowDo crmFollow);

	/**
	 * batch insert crmFollow info
	 * @method      insertCrmFollow
	 * @param       crmFollows:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	void batchInsertCrmFollow(List<CrmFollow> crmFollows);

	/**
	 * update crmFollow info
	 * @method      updateCrmFollow
	 * @param       crmFollow:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	int updateCrmFollow(CrmFollow crmFollow);

	/**
	 * update crmFollow info By pk
	 * @method      updateCrmFollowByPk
	 * @param       crmFollow:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	int updateCrmFollowByPk(CrmFollow crmFollow);

	/**
	 * list crmFollow info
	 * @method      listCrmFollow
	 * @param       crmFollow:
	 * @return      List<CrmFollow>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	List<CrmFollowDo> listCrmFollow(CrmFollowRo crmFollow);

	List<CrmFollowDo> listByTargets(ListFollowByTargetListRo targetDos);

	List<CrmFollowDo> batchQueryLatestFollowUp(BatchQueryLatestFollowRo crmFollowRo);

    Map<Long, CrmFollowDo> mapLatestFollowUp(BatchQueryLatestFollowRo crmFollowRo);

    CrmFollowDo queryLatestFollow(Long targetId, TargetType targetType);
}
