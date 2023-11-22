package com.meta.crm.domain.tunnel.db;


import com.meta.crm.intf.entity.CrmContact;
import com.meta.crm.domain.aggr.CrmContactDo;
import com.meta.crm.intf.req.ro.CrmContactRo;

import java.util.List;

/**
 *
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:26
 */
public interface CrmContactRepository{

	/**
	 * insert crmContact info
	 * @method      insertCrmContact
	 * @param       crmContact:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	void saveCrmContact(CrmContactDo crmContact);

	/**
	 * insert crmContact info
	 * @method      insertCrmContact
	 * @param       crmContact:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	void insertCrmContact(CrmContactDo crmContact);

	/**
	 * batch insert crmContact info
	 * @method      insertCrmContact
	 * @param       crmContacts:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	void batchInsertCrmContact(List<CrmContactDo> crmContacts);

	/**
	 * update crmContact info
	 * @method      updateCrmContact
	 * @param       crmContact:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	int updateCrmContact(CrmContactDo crmContact);

	/**
	 * update crmContact info By pk
	 * @method      updateCrmContactByPk
	 * @param       crmContact:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	int updateCrmContactByPk(CrmContact crmContact);

	/**
	 * list crmContact info
	 * @method      listCrmContact
	 * @param       crmContact:
	 * @return      List<CrmContact>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	List<CrmContactDo> listCrmContact(CrmContactRo crmContact);

	/**
	 * list crmContact info
	 * @method      listCrmContact
	 * @return      List<CrmContact>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	CrmContactDo getById(Long id);

	/**
	 * list crmContact info
	 * @method      listCrmContact
	 * @return      List<CrmContact>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	CrmContactDo getByMobileAndCustomerId(String mobile, Long customerId);
}
