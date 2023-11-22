package com.meta.crm.domain.tunnel.db;

import com.meta.crm.domain.aggr.CrmCustomerDo;
import com.meta.crm.intf.req.ro.CrmCustomerRo;

import java.util.List;

/**
 *
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:26
 */
public interface CrmCustomerRepository{

	/**
	 * insert crmCustomer info
	 * @method      insertCrmCustomer
	 * @param       crmCustomer:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	void saveCrmCustomer(CrmCustomerDo crmCustomer);

	/**
	 * batch insert crmCustomer info
	 * @method      insertCrmCustomer
	 * @param       crmCustomers:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	void batchSaveCrmCustomer(List<CrmCustomerDo> crmCustomers);

	/**
	 * update crmCustomer info
	 * @method      updateCrmCustomer
	 * @param       crmCustomer:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	int updateCrmCustomer(CrmCustomerDo crmCustomer);

	/**
	 * update crmCustomer info By pk
	 * @method      updateCrmCustomerByPk
	 * @param       crmCustomer:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	int updateCrmCustomerByPk(CrmCustomerDo crmCustomer);

	/**
	 * list crmCustomer info
	 * @method      listCrmCustomer
	 * @param       crmCustomer:
	 * @return      List<CrmCustomer>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	List<CrmCustomerDo> listCrmCustomer(CrmCustomerRo crmCustomer);

	/**
	 * list crmCustomer info
	 * @method      listCrmCustomer
	 * @return      List<CrmCustomer>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	CrmCustomerDo getById(Long id);

	/**
	 * list crmCustomer info
	 * @method      listCrmCustomer
	 * @return      List<CrmCustomer>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	CrmCustomerDo getByName(String customerName);

}
