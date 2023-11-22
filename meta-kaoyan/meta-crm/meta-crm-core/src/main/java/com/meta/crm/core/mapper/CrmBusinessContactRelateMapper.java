package com.meta.crm.core.mapper;

import com.meta.crm.intf.entity.CrmBusinessContactRelate;
import com.meta.crm.intf.req.ro.CrmBusinessContactRelateRo;

import java.util.List;

/**
 * 商机关联联系人
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:25
 */
public interface CrmBusinessContactRelateMapper {

	/**
	 * insert crmBusinessContactRelate info
	 * @method insertCrmBusinessContactRelate
	 * @param       crmBusinessContactRelate:
	 * @return void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	void insertCrmBusinessContactRelate(CrmBusinessContactRelate crmBusinessContactRelate);

	/**
	 * batchInsert crmBusinessContactRelate info
	 * @method insertCrmBusinessContactRelate
	 * @param       crmBusinessContactRelate:
	 * @return void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	void batchInsertCrmBusinessContactRelate(List<CrmBusinessContactRelate> crmBusinessContactRelates);

	/**
	 * update crmBusinessContactRelate info
	 * @method updateCrmBusinessContactRelate
	 * @param       crmBusinessContactRelate:
	 * @return int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	int updateCrmBusinessContactRelate(CrmBusinessContactRelate crmBusinessContactRelate);

	/**
	 * update crmBusinessContactRelate info by Pk
	 * @method updateCrmBusinessContactRelateByPk
	 * @param       crmBusinessContactRelate:
	 * @return int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	int updateCrmBusinessContactRelateByPk(CrmBusinessContactRelate crmBusinessContactRelate);

	/**
	 * list crmBusinessContactRelate info
	 * @method listCrmBusinessContactRelate
	 * @param       crmBusinessContactRelate:
	 * @return List<CrmBusinessContactRelate>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	List<CrmBusinessContactRelate> listCrmBusinessContactRelate(CrmBusinessContactRelateRo crmBusinessContactRelateRo);

    int countCrmBusinessContactRelate(CrmBusinessContactRelateRo crmBusinessContactRelate);
}
