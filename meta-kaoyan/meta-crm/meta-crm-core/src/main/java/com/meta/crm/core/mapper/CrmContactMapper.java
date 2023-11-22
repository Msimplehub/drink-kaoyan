package com.meta.crm.core.mapper;

import com.meta.crm.intf.entity.CrmContact;
import com.meta.crm.intf.req.ro.CrmContactRo;
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
public interface CrmContactMapper {

	/**
	 * insert crmContact info
	 * @method insertCrmContact
	 * @param       crmContact:
	 * @return void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	void insertCrmContact(CrmContact crmContact);

	/**
	 * batchInsert crmContact info
	 * @method insertCrmContact
	 * @param       crmContact:
	 * @return void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	void batchInsertCrmContact(List<CrmContact> crmContacts);

	/**
	 * update crmContact info
	 * @method updateCrmContact
	 * @param       crmContact:
	 * @return int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	int updateCrmContact(CrmContact crmContact);

	/**
	 * update crmContact info by Pk
	 * @method updateCrmContactByPk
	 * @param       crmContact:
	 * @return int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	int updateCrmContactByPk(CrmContact crmContact);

	/**
	 * list crmContact info
	 * @method listCrmContact
	 * @return List<CrmContact>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	List<CrmContact> listCrmContact(CrmContactRo crmContactRo);

	/**
	 * getById
	 * @param id
	 * @return
	 */
	CrmContact getById(CrmContactRo crmContactRo);
}
