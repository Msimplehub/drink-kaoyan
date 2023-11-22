package com.meta.crm.core.mapper;

import com.meta.crm.intf.entity.CrmBusiness;
import com.meta.crm.intf.req.ro.CrmBusinessRo;
import com.meta.crm.intf.res.vo.business.BusinessListVo;

import java.util.List;

/**
 * 商机主表
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:25
 */
public interface CrmBusinessMapper {

	/**
	 * insert crmBusiness info
	 * @method insertCrmBusiness
	 * @param       crmBusiness:
	 * @return void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	void insertCrmBusiness(CrmBusiness crmBusiness);

	/**
	 * batchInsert crmBusiness info
	 * @method insertCrmBusiness
	 * @param       crmBusiness:
	 * @return void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	void batchInsertCrmBusiness(List<CrmBusiness> crmBusinesss);

	/**
	 * update crmBusiness info
	 * @method updateCrmBusiness
	 * @param       crmBusiness:
	 * @return int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	int updateCrmBusiness(CrmBusiness crmBusiness);

	/**
	 * update crmBusiness info by Pk
	 * @method updateCrmBusinessByPk
	 * @param       crmBusiness:
	 * @return int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	int updateCrmBusinessByPk(CrmBusiness crmBusiness);

	/**
	 * list crmBusiness info
	 * @method listCrmBusiness
	 * @param       crmBusiness:
	 * @return List<CrmBusiness>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	List<CrmBusiness> listCrmBusiness(CrmBusinessRo crmBusinessRo);

    List<BusinessListVo> queryBusinessList(CrmBusinessRo crmBusinessRo);

    List<CrmBusiness> businessNameCheck(CrmBusinessRo crmBusinessRo);

    List<CrmBusiness> listCrmBusinessWithContactId(CrmBusinessRo contactQryRo);
}
