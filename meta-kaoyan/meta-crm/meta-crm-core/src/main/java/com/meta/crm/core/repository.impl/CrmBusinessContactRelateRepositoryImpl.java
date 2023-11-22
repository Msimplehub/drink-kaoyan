package com.meta.crm.core.repository.impl;

import com.meta.crm.core.mapper.CrmBusinessContactRelateMapper;
import com.meta.crm.domain.tunnel.db.CrmBusinessContactRelateRepository;
import com.meta.crm.intf.entity.CrmBusinessContactRelate;
import com.meta.crm.intf.req.ro.CrmBusinessContactRelateRo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;

/**
 * 商机关联联系人
 *
 * @Title: CrmBusinessContactRelateRepositoryImpl
 * @Author: M.simple
 * @Remark: The modified content
 * @CreateDate: 2020-11-12 17:43:25
 * @Version: v2.0
 */
@Service
public class CrmBusinessContactRelateRepositoryImpl implements CrmBusinessContactRelateRepository {

    @Autowired
    private CrmBusinessContactRelateMapper crmBusinessContactRelateMapper;

    /**
     * insert crmBusinessContactRelate info
     *
     * @param crmBusinessContactRelate:
     * @return void
     * @method insertCrmBusinessContactRelate
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    @Override
    public void insertCrmBusinessContactRelate(CrmBusinessContactRelate crmBusinessContactRelate) {
        crmBusinessContactRelateMapper.insertCrmBusinessContactRelate(crmBusinessContactRelate);
    }

    /**
     * batch insert crmBusinessContactRelate info
     *
     * @param crmBusinessContactRelates:
     * @return void
     * @method insertCrmBusinessContactRelate
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    @Override
    public void batchInsertCrmBusinessContactRelate(List<CrmBusinessContactRelate> crmBusinessContactRelates) {
        if (!CollectionUtils.isEmpty(crmBusinessContactRelates)) {
            for (CrmBusinessContactRelate crmBusinessContactRelate : crmBusinessContactRelates) {
                crmBusinessContactRelateMapper.insertCrmBusinessContactRelate(crmBusinessContactRelate);
            }
        }
    }

    /**
     * update crmBusinessContactRelate info
     *
     * @param crmBusinessContactRelate:
     * @return int
     * @method updateCrmBusinessContactRelate
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    @Override
    public int updateCrmBusinessContactRelate(CrmBusinessContactRelate crmBusinessContactRelate) {
        return crmBusinessContactRelateMapper.updateCrmBusinessContactRelate(crmBusinessContactRelate);
    }

    /**
     * update crmBusinessContactRelate info by Pk
     *
     * @param crmBusinessContactRelate:
     * @return int
     * @method updateCrmBusinessContactRelateByPk
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    @Override
    public int updateCrmBusinessContactRelateByPk(CrmBusinessContactRelate crmBusinessContactRelate) {
        return crmBusinessContactRelateMapper.updateCrmBusinessContactRelateByPk(crmBusinessContactRelate);
    }

    /**
     * list crmBusinessContactRelate info
     *
     * @param crmBusinessContactRelate:
     * @return List<CrmBusinessContactRelate>
     * @method listCrmBusinessContactRelate
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    @Override
    public List<CrmBusinessContactRelate> listCrmBusinessContactRelate(CrmBusinessContactRelateRo crmBusinessContactRelate) {
        return crmBusinessContactRelateMapper.listCrmBusinessContactRelate(crmBusinessContactRelate);
    }

    @Override
    public int countCrmBusinessContactRelate(CrmBusinessContactRelateRo crmBusinessContactRelate) {
        return crmBusinessContactRelateMapper.countCrmBusinessContactRelate(crmBusinessContactRelate);
    }

    @Override
    public void batchInsertOrUpdateCrmBusinessContactRelate(List<CrmBusinessContactRelate> updateRelateContactList) {
        for (CrmBusinessContactRelate crmBusinessContactRelate : updateRelateContactList) {
            if (crmBusinessContactRelate.getId() != null) {
                updateCrmBusinessContactRelateByPk(crmBusinessContactRelate);
            } else {
                insertCrmBusinessContactRelate(crmBusinessContactRelate);
            }
        }
    }
}
