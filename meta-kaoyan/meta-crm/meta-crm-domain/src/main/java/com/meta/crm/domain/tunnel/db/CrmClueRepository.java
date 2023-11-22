package com.meta.crm.domain.tunnel.db;


import com.meta.crm.intf.entity.CrmClue;
import com.meta.crm.intf.req.ro.CrmClueRo;
import com.meta.crm.intf.res.vo.clue.ClueListVo;

import java.util.List;

/**
 * 线索主表
 * 
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:26
 */
public interface CrmClueRepository{

	/**
	 * insert crmClue info
	 * @method      insertCrmClue
	 * @param       crmClue:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	void insertCrmClue(CrmClue crmClue);

	/**
	 * batch insert crmClue info
	 * @method      insertCrmClue
	 * @param       crmClues:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	void batchInsertCrmClue(List<CrmClue> crmClues);

	/**
	 * update crmClue info
	 * @method      updateCrmClue
	 * @param       crmClue:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	int updateCrmClue(CrmClue crmClue);

	/**
	 * update crmClue info By pk
	 * @method      updateCrmClueByPk
	 * @param       crmClue:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	int updateCrmClueByPk(CrmClue crmClue);

	/**
	 * list crmClue info
	 * @method      listCrmClue
	 * @param       crmClue:
	 * @return      List<CrmClue>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	List<CrmClue> listCrmClue(CrmClueRo crmClue);

	List<ClueListVo> queryList(CrmClueRo ro);

    List<CrmClue> checkCluePhoneNum(CrmClueRo crmClueRo);
}
