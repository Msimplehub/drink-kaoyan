package com.meta.crm.core.repository.impl;

import com.meta.crm.core.mapper.CrmCompanyInfoMapper;
import com.meta.crm.domain.tunnel.db.*;
import com.meta.crm.intf.entity.*;
import com.meta.crm.intf.req.company.CompanyListQry;
import com.meta.crm.intf.req.ro.CrmCompanyInfoRo;
import com.meta.framework.util.BeanUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 *  企业工商信息
 * @Title:      CrmCompanyInfoRepositoryImpl
 * @Author:     M.simple
 * @Remark:     The modified content
 * @CreateDate: 2020-11-12 17:43:25
 * @Version:    v2.0
 */
@Service
public class CrmCompanyInfoRepositoryImpl implements CrmCompanyInfoRepository {

	@Autowired
	private CrmCompanyInfoMapper crmCompanyInfoMapper;

	@Override
	public CrmCompanyInfo getCompanyDetail(CompanyListQry crmCompanyInfo) {
		CrmCompanyInfoRo ro = BeanUtil.copyProperties(CrmCompanyInfoRo.class, crmCompanyInfo);
		return crmCompanyInfoMapper.getCompanyDetail(ro);
	}

	@Override
	public List<CrmCompanyInfo> listCompanyInfoByFuzzy(CompanyListQry crmCompanyInfo) {
		CrmCompanyInfoRo ro = BeanUtil.copyProperties(CrmCompanyInfoRo.class, crmCompanyInfo);
		return crmCompanyInfoMapper.listCompanyInfoByFuzzy(ro);
	}

	@Override
	public List<CrmCompanyInfo> listCrmCompanyInfo(CompanyListQry crmCompanyInfo) {
		CrmCompanyInfoRo ro = BeanUtil.copyProperties(CrmCompanyInfoRo.class, crmCompanyInfo);
		return crmCompanyInfoMapper.listCrmCompanyInfo(ro);
	}

	@Override
	public void insertCrmCompanyInfo(CrmCompanyInfo crmCompanyInfo) {
		crmCompanyInfoMapper.insertCrmCompanyInfo(crmCompanyInfo);
	}


//	/**
//	 * insert tCompanyInfo info
//	 * @method      insertCrmCompanyInfo
//	 * @param       crmCompanyInfo:
//	 * @return      void
//	 * @author      M.simple
//	 * @date        2020-11-12 17:43:25
//	 */
//	@Override
//	public void insertCrmCompanyInfo(CrmCompanyInfo crmCompanyInfo){
//			crmCompanyInfoMapper.insertCrmCompanyInfo(crmCompanyInfo);
//	}
//
//	/**
//	 * batch insert tCompanyInfo info
//	 * @method      insertCrmCompanyInfo
//	 * @param       crmCompanyInfos:
//	 * @return      void
//	 * @author      M.simple
//	 * @date        2020-11-12 17:43:25
//	 */
//	@Override
//	public void batchInsertCrmCompanyInfo(List<CrmCompanyInfo> crmCompanyInfos){
//			crmCompanyInfoMapper.batchInsertCrmCompanyInfo(crmCompanyInfos);
//	}
//
//	/**
//	 * update tCompanyInfo info
//	 * @method      updateCrmCompanyInfo
//	 * @param       crmCompanyInfo:
//	 * @return      int
//	 * @author      M.simple
//	 * @date        2020-11-12 17:43:25
//	 */
//	@Override
//	public int updateCrmCompanyInfo(CrmCompanyInfo crmCompanyInfo){
//			return crmCompanyInfoMapper.updateCrmCompanyInfo(crmCompanyInfo);
//	}
//
//	/**
//	 * update tCompanyInfo info by Pk
//	 * @method      updateCrmCompanyInfoByPk
//	 * @param       crmCompanyInfo:
//	 * @return      int
//	 * @author      M.simple
//	 * @date        2020-11-12 17:43:25
//	 */
//	@Override
//	public int updateCrmCompanyInfoByPk(CrmCompanyInfo crmCompanyInfo){
//		return crmCompanyInfoMapper.updateCrmCompanyInfoByPk(crmCompanyInfo);
//	}
//
//	/**
//	 * list tCompanyInfo info
//	 * @method      listCrmCompanyInfo
//	 * @param       tCompanyInfo:
//	 * @return      List<CrmCompanyInfo>
//	 * @author      M.simple
//	 * @date        2020-11-12 17:43:25
//	 */
//	@Override
//	public List<CrmCompanyInfo> listCrmCompanyInfo(CrmCompanyInfoRo tCompanyInfo){
//			return crmCompanyInfoMapper.listCrmCompanyInfo(tCompanyInfo);
//	}

}
