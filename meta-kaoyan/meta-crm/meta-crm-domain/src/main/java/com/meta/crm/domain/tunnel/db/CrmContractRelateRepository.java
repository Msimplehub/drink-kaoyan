package com.meta.crm.domain.tunnel.db;

import com.meta.crm.intf.entity.CrmContractRelate;
import com.meta.crm.intf.req.contract.CrmContractListForFundPlanQry;
import com.meta.crm.intf.req.ro.CrmContractRelateRo;
import com.meta.crm.intf.res.vo.contract.CrmContractListForFundPlanVo;

import java.util.List;

/**
 * 合同关系表
 * 
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-12-09 10:49:27
 */
public interface CrmContractRelateRepository {

	/**
	 * insert crmContractRelate info
	 * @method      insertCrmContractRelate
	 * @param       crmContractRelate:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-12-09 10:49:27
	 */
	void insertCrmContractRelate(CrmContractRelate crmContractRelate);

	/**
	 * batch insert crmContractRelate info
	 * @method      insertCrmContractRelate
	 * @param       crmContractRelates:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-12-09 10:49:27
	 */
	void batchInsertCrmContractRelate(List<CrmContractRelate> crmContractRelates);

	/**
	 * update crmContractRelate info
	 * @method      updateCrmContractRelate
	 * @param       crmContractRelate:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-12-09 10:49:27
	 */
	int updateCrmContractRelate(CrmContractRelate crmContractRelate);

	/**
	 * update crmContractRelate info By pk
	 * @method      updateCrmContractRelateByPk
	 * @param       crmContractRelate:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-12-09 10:49:27
	 */
	int updateCrmContractRelateByPk(CrmContractRelate crmContractRelate);

	/**
	 * list crmContractRelate info
	 * @method      listCrmContractRelate
	 * @param       crmContractRelate:
	 * @return      List<CrmContractRelate>
	 * @author      M.simple
	 * @date        2020-12-09 10:49:27
	 */
	List<CrmContractRelate> listCrmContractRelate(CrmContractRelateRo crmContractRelate);

    void insertOrUpdate(List<CrmContractRelate> crmContractRelates);
}
