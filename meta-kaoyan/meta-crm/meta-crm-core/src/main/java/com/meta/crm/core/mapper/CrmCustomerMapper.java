package com.meta.crm.core.mapper;

import com.meta.crm.intf.entity.CrmCustomer;
import com.meta.crm.intf.req.ro.CrmCustomerRo;
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
public interface CrmCustomerMapper {

	/**
	 * insert crmCustomer info
	 * @method insertCrmCustomer
	 * @param       crmCustomer:
	 * @return void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	void insertCrmCustomer(CrmCustomer crmCustomer);

	/**
	 * batchInsert crmCustomer info
	 * @method insertCrmCustomer
	 * @param       crmCustomer:
	 * @return void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	void batchInsertCrmCustomer(List<CrmCustomer> crmCustomers);

	/**
	 * update crmCustomer info
	 * @method updateCrmCustomer
	 * @param       crmCustomer:
	 * @return int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	int updateCrmCustomer(CrmCustomer crmCustomer);

	/**
	 * update crmCustomer info by Pk
	 * @method updateCrmCustomerByPk
	 * @param       crmCustomer:
	 * @return int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	int updateCrmCustomerByPk(CrmCustomer crmCustomer);

	/**
	 * list crmCustomer info
	 * @method listCrmCustomer
	 * @return List<CrmCustomer>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	List<CrmCustomer> listCrmCustomer(CrmCustomerRo crmCustomerRo);


	/**
	 * query by id
	 * @return
	 */
	CrmCustomer getById(CrmCustomerRo idRo);

	/**
	 * query by name
	 * @return
	 */
	CrmCustomer getByName(CrmCustomerRo nameRo);

}
