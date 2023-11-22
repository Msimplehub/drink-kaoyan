package com.meta.crm.domain.tunnel.db;


import com.meta.crm.intf.entity.CrmBusinessContactRelate;
import com.meta.crm.intf.req.ro.CrmBusinessContactRelateRo;

import java.util.List;

/**
 * 商机关联联系人
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:25
 */
public interface CrmBusinessContactRelateRepository {

    /**
     * insert crmBusinessContactRelate info
     *
     * @param crmBusinessContactRelate:
     * @return void
     * @method insertCrmBusinessContactRelate
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    void insertCrmBusinessContactRelate(CrmBusinessContactRelate crmBusinessContactRelate);

    /**
     * batch insert crmBusinessContactRelate info
     *
     * @param crmBusinessContactRelates:
     * @return void
     * @method insertCrmBusinessContactRelate
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    void batchInsertCrmBusinessContactRelate(List<CrmBusinessContactRelate> crmBusinessContactRelates);

    /**
     * update crmBusinessContactRelate info
     *
     * @param crmBusinessContactRelate:
     * @return int
     * @method updateCrmBusinessContactRelate
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    int updateCrmBusinessContactRelate(CrmBusinessContactRelate crmBusinessContactRelate);

    /**
     * update crmBusinessContactRelate info By pk
     *
     * @param crmBusinessContactRelate:
     * @return int
     * @method updateCrmBusinessContactRelateByPk
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    int updateCrmBusinessContactRelateByPk(CrmBusinessContactRelate crmBusinessContactRelate);

    /**
     * list crmBusinessContactRelate info
     *
     * @param crmBusinessContactRelate:
     * @return List<CrmBusinessContactRelate>
     * @method listCrmBusinessContactRelate
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    List<CrmBusinessContactRelate> listCrmBusinessContactRelate(CrmBusinessContactRelateRo crmBusinessContactRelate);

    /**
     * 统计数量
     *
     * @param crmBusinessContactRelate
     * @return
     */
    int countCrmBusinessContactRelate(CrmBusinessContactRelateRo crmBusinessContactRelate);

    void batchInsertOrUpdateCrmBusinessContactRelate(List<CrmBusinessContactRelate> updateRelateContactList);
}
