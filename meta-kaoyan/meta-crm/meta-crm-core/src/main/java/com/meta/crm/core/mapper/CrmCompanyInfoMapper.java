package com.meta.crm.core.mapper;

import com.meta.crm.intf.entity.CrmCompanyInfo;
import com.meta.crm.intf.req.ro.CrmCompanyInfoRo;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 企业工商信息
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:25
 */
@Repository
public interface CrmCompanyInfoMapper {
	/**
	 * list tCompanyInfo info
	 *
	 * @param companyInfoRo:
	 * @return List<CrmCompanyInfo>
	 * @method listCrmCompanyInfo
	 * @author M.simple
	 * @date 2020-11-12 17:43:25
	 */
	CrmCompanyInfo getCompanyDetail(CrmCompanyInfoRo companyInfoRo);

		/**
	 * list tCompanyInfo info
	 *
	 * @param companyInfoRo:
	 * @return List<CrmCompanyInfo>
	 * @method listCrmCompanyInfo
	 * @author M.simple
	 * @date 2020-11-12 17:43:25
	 */
	List<CrmCompanyInfo> listCompanyInfoByFuzzy(CrmCompanyInfoRo companyInfoRo);

		/**
	 * list tCompanyInfo info
	 *
	 * @param companyInfoRo:
	 * @return List<CrmCompanyInfo>
	 * @method listCrmCompanyInfo
	 * @author M.simple
	 * @date 2020-11-12 17:43:25
	 */
	List<CrmCompanyInfo> listCrmCompanyInfo(CrmCompanyInfoRo companyInfoRo);


	/**
	 * insert tCompanyInfo info
	 *
	 * @param crmCompanyInfo:
	 * @return void
	 * @method insertCrmCompanyInfo
	 * @author M.simple
	 * @date 2020-11-12 17:43:25
	 */
	void insertCrmCompanyInfo(CrmCompanyInfo crmCompanyInfo);

}
