package com.meta.crm.intf.req.company;

import lombok.Data;

@Data
public class CompanyListQry {

    /**
     * 企业信用编号
     */
    private String creditCode;

    /**
     * 公司名
     */
    private String companyName;

}
