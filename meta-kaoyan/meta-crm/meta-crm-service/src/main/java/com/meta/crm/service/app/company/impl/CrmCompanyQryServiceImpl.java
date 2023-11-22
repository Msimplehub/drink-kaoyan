package com.meta.crm.service.app.company.impl;

import com.meta.crm.domain.tunnel.db.CrmCompanyInfoRepository;
import com.meta.crm.intf.entity.CrmCompanyInfo;
import com.meta.crm.intf.req.company.CompanyListQry;
import com.meta.crm.service.app.company.CrmCompanyQryService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CrmCompanyQryServiceImpl implements CrmCompanyQryService {

    @Resource
    private CrmCompanyInfoRepository crmCompanyInfoRepository;

    @Override
    public CrmCompanyInfo getCompanyDetail(CompanyListQry companyListQry) {
        CrmCompanyInfo companyDetail =  crmCompanyInfoRepository.getCompanyDetail(companyListQry);
        return companyDetail;
    }

    @Override
    public List<CrmCompanyInfo> listCompanyInfoByFuzzy(CompanyListQry companyListQry) {
        List<CrmCompanyInfo> companyInfoList =  crmCompanyInfoRepository.listCompanyInfoByFuzzy(companyListQry);
        return companyInfoList;
    }

    @Override
    public List<CrmCompanyInfo> listCrmCompanyInfo(CompanyListQry companyListQry) {
        List<CrmCompanyInfo> companyInfoList =  crmCompanyInfoRepository.listCrmCompanyInfo(companyListQry);
        return companyInfoList;
    }
}
