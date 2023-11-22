package com.meta.crm.domain.tunnel.db;


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
public interface CrmBusinessRepository {

    /**
     * insert crmBusiness info
     *
     * @param crmBusiness:
     * @return void
     * @method insertCrmBusiness
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    void insertCrmBusiness(CrmBusiness crmBusiness);

    /**
     * batch insert crmBusiness info
     *
     * @param crmBusinesss:
     * @return void
     * @method insertCrmBusiness
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    void batchInsertCrmBusiness(List<CrmBusiness> crmBusinesss);

    /**
     * update crmBusiness info
     *
     * @param crmBusiness:
     * @return int
     * @method updateCrmBusiness
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    int updateCrmBusiness(CrmBusiness crmBusiness);

    /**
     * update crmBusiness info By pk
     *
     * @param crmBusiness:
     * @return int
     * @method updateCrmBusinessByPk
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    int updateCrmBusinessByPk(CrmBusiness crmBusiness);

    /**
     * list crmBusiness info
     *
     * @param crmBusiness:
     * @return List<CrmBusiness>
     * @method listCrmBusiness
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    List<CrmBusiness> listCrmBusiness(CrmBusinessRo crmBusiness);

    /**
     * 查询商机列表
     *
     * @param crmBusinessRo
     * @return
     */
    List<BusinessListVo> queryBusinessList(CrmBusinessRo crmBusinessRo);

    List<CrmBusiness> businessNameCheck(CrmBusinessRo crmBusinessRo);

    List<CrmBusiness> listCrmBusinessWithContactId(CrmBusinessRo contactQryRo);

    CrmBusiness getById(Long id);
}
