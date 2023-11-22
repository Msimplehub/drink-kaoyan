package com.meta.crm.domain.tunnel.db;


import com.meta.crm.intf.entity.CrmCompanyInfo;
import com.meta.crm.intf.req.company.CompanyListQry;

import java.util.List;

/**
 * 企业工商信息
 * 
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:25
 */
public interface CrmCompanyInfoRepository {

	/**
	 * list tCompanyInfo info
	 * @method      listCrmCompanyInfo
	 * @param       crmCompanyInfo:
	 * @return      List<CrmCompanyInfo>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	CrmCompanyInfo getCompanyDetail(CompanyListQry crmCompanyInfo);

	/**
	 * list tCompanyInfo info
	 * @method      listCrmCompanyInfo
	 * @param       crmCompanyInfo:
	 * @return      List<CrmCompanyInfo>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	List<CrmCompanyInfo> listCompanyInfoByFuzzy(CompanyListQry crmCompanyInfo);

	/**
	 * list tCompanyInfo info
	 * @method      listCrmCompanyInfo
	 * @param       crmCompanyInfo:
	 * @return      List<CrmCompanyInfo>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	List<CrmCompanyInfo> listCrmCompanyInfo(CompanyListQry crmCompanyInfo);


	/**
	 * insert tCompanyInfo info
	 * @method      insertCrmCompanyInfo
	 * @param       crmCompanyInfo:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	void insertCrmCompanyInfo(CrmCompanyInfo crmCompanyInfo);

}
