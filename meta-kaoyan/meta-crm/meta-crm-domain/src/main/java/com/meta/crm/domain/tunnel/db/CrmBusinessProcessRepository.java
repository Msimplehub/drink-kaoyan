package com.meta.crm.domain.tunnel.db;


import com.meta.crm.intf.entity.CrmBusinessProcess;
import com.meta.crm.intf.req.ro.CrmBusinessProcessRo;

import java.util.List;

/**
 * 
 * 
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:25
 */
public interface CrmBusinessProcessRepository{

	/**
	 * insert crmBusinessProcess info
	 * @method      insertCrmBusinessProcess
	 * @param       crmBusinessProcess:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	void insertCrmBusinessProcess(CrmBusinessProcess crmBusinessProcess);

	/**
	 * batch insert crmBusinessProcess info
	 * @method      insertCrmBusinessProcess
	 * @param       crmBusinessProcesss:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	void batchInsertCrmBusinessProcess(List<CrmBusinessProcess> crmBusinessProcesss);

	/**
	 * update crmBusinessProcess info
	 * @method      updateCrmBusinessProcess
	 * @param       crmBusinessProcess:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	int updateCrmBusinessProcess(CrmBusinessProcess crmBusinessProcess);

	/**
	 * update crmBusinessProcess info By pk
	 * @method      updateCrmBusinessProcessByPk
	 * @param       crmBusinessProcess:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	int updateCrmBusinessProcessByPk(CrmBusinessProcess crmBusinessProcess);

	/**
	 * list crmBusinessProcess info
	 * @method      listCrmBusinessProcess
	 * @param       crmBusinessProcess:
	 * @return      List<CrmBusinessProcess>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	List<CrmBusinessProcess> listCrmBusinessProcess(CrmBusinessProcessRo crmBusinessProcess);

}
