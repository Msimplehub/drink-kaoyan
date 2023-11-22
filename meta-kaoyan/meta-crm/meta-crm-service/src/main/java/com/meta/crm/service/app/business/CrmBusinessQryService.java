package com.meta.crm.service.app.business;

import com.meta.crm.intf.req.business.BusinessContactQry;
import com.meta.crm.intf.req.business.BusinessDetailQry;
import com.meta.crm.intf.req.business.BusinessListQry;
import com.meta.crm.intf.req.business.BusinessNameCheckQry;
import com.meta.crm.intf.req.business.CustomerBusinessListQry;
import com.meta.crm.intf.res.vo.business.BusinessContactDetailListVo;
import com.meta.crm.intf.res.vo.business.BusinessDetailVo;
import com.meta.crm.intf.res.vo.business.BusinessListVo;
import com.meta.crm.intf.res.vo.business.BusinessNameCheckVo;
import com.meta.crm.intf.res.vo.business.CustomerBusinessListVo;

import java.util.List;

public interface
CrmBusinessQryService {

    /**
     * 查询商机列表
     *
     * @param req
     * @return
     */
    List<BusinessListVo> queryList(BusinessListQry req);

    /**
     * 检查同客户下是否有重名的商机
     *
     * @param req
     * @return
     */
    BusinessNameCheckVo businessNameCheck(BusinessNameCheckQry req);

    /**
     * 查询详情
     *
     * @param req
     * @return
     */
    BusinessDetailVo detail(BusinessDetailQry req);

    /**
     * 查询客户下的商机
     *
     * @param req
     * @return
     */
    List<CustomerBusinessListVo> queryByCustomerId(CustomerBusinessListQry req);

    /**
     * 查询商机下联系人
     *
     * @param req
     * @return
     */
    List<BusinessContactDetailListVo> queryBusinessContact(BusinessContactQry req);
}
