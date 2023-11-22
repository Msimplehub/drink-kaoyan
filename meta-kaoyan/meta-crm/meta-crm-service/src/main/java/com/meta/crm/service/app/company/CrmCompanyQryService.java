package com.meta.crm.service.app.company;

import com.meta.crm.intf.entity.CrmCompanyInfo;
import com.meta.crm.intf.req.company.CompanyListQry;

import java.util.List;

public interface CrmCompanyQryService {

    List<CrmCompanyInfo> listCompanyInfoByFuzzy(CompanyListQry companyListQry);

    List<CrmCompanyInfo> listCrmCompanyInfo(CompanyListQry companyListQry);

    CrmCompanyInfo getCompanyDetail(CompanyListQry companyListQry);

}
