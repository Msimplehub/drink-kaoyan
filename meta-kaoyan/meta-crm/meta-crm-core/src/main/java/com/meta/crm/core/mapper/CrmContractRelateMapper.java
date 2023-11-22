package com.meta.crm.core.mapper;


import com.meta.crm.intf.entity.CrmContractRelate;
import com.meta.crm.intf.req.ro.CrmContractRelateRo;

import java.util.List;

/**
 * 合同关系表
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-12-09 10:49:27
 */
public interface CrmContractRelateMapper {

	/**
	 * insert crmContractRelate info
	 * @method insertCrmContractRelate
	 * @param       crmContractRelate:
	 * @return void
	 * @author      M.simple
	 * @date        2020-12-09 10:49:27
	 */
	void insertCrmContractRelate(CrmContractRelate crmContractRelate);

	/**
	 * batchInsert crmContractRelate info
	 * @method insertCrmContractRelate
	 * @param       crmContractRelate:
	 * @return void
	 * @author      M.simple
	 * @date        2020-12-09 10:49:27
	 */
	void batchInsertCrmContractRelate(List<CrmContractRelate> crmContractRelates);

	/**
	 * update crmContractRelate info
	 * @method updateCrmContractRelate
	 * @param       crmContractRelate:
	 * @return int
	 * @author      M.simple
	 * @date        2020-12-09 10:49:27
	 */
	int updateCrmContractRelate(CrmContractRelate crmContractRelate);

	/**
	 * update crmContractRelate info by Pk
	 * @method updateCrmContractRelateByPk
	 * @param       crmContractRelate:
	 * @return int
	 * @author      M.simple
	 * @date        2020-12-09 10:49:27
	 */
	int updateCrmContractRelateByPk(CrmContractRelate crmContractRelate);

	/**
	 * list crmContractRelate info
	 * @method listCrmContractRelate
	 * @param       crmContractRelate:
	 * @return List<CrmContractRelate>
	 * @author      M.simple
	 * @date        2020-12-09 10:49:27
	 */
	List<CrmContractRelate> listCrmContractRelate(CrmContractRelateRo crmContractRelateRo);

}
