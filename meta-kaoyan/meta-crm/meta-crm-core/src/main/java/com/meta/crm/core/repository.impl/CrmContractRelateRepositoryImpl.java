package com.meta.crm.core.repository.impl;

import com.meta.crm.core.mapper.CrmContractRelateMapper;
import com.meta.crm.domain.tunnel.db.CrmContractRelateRepository;
import com.meta.crm.intf.entity.CrmContractRelate;
import com.meta.crm.intf.req.ro.CrmContractRelateRo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 合同关系表
 *
 * @Title: CrmContractRelateRepositoryImpl
 * @Author: M.simple
 * @Remark: The modified content
 * @CreateDate: 2020-12-09 10:49:27
 * @Version: v2.0
 */
@Service
public class CrmContractRelateRepositoryImpl implements CrmContractRelateRepository {

    @Autowired
    private CrmContractRelateMapper crmContractRelateMapper;

    /**
     * insert crmContractRelate info
     *
     * @param crmContractRelate:
     * @return void
     * @method insertCrmContractRelate
     * @author M.simple
     * @date 2020-12-09 10:49:27
     */
    @Override
    public void insertCrmContractRelate(CrmContractRelate crmContractRelate) {
        crmContractRelateMapper.insertCrmContractRelate(crmContractRelate);
    }

    /**
     * batch insert crmContractRelate info
     *
     * @param crmContractRelates:
     * @return void
     * @method insertCrmContractRelate
     * @author M.simple
     * @date 2020-12-09 10:49:27
     */
    @Override
    public void batchInsertCrmContractRelate(List<CrmContractRelate> crmContractRelates) {
        crmContractRelateMapper.batchInsertCrmContractRelate(crmContractRelates);
    }

    /**
     * update crmContractRelate info
     *
     * @param crmContractRelate:
     * @return int
     * @method updateCrmContractRelate
     * @author M.simple
     * @date 2020-12-09 10:49:27
     */
    @Override
    public int updateCrmContractRelate(CrmContractRelate crmContractRelate) {
        return crmContractRelateMapper.updateCrmContractRelate(crmContractRelate);
    }

    /**
     * update crmContractRelate info by Pk
     *
     * @param crmContractRelate:
     * @return int
     * @method updateCrmContractRelateByPk
     * @author M.simple
     * @date 2020-12-09 10:49:27
     */
    @Override
    public int updateCrmContractRelateByPk(CrmContractRelate crmContractRelate) {
        return crmContractRelateMapper.updateCrmContractRelateByPk(crmContractRelate);
    }

    /**
     * list crmContractRelate info
     *
     * @param crmContractRelate:
     * @return List<CrmContractRelate>
     * @method listCrmContractRelate
     * @author M.simple
     * @date 2020-12-09 10:49:27
     */
    @Override
    public List<CrmContractRelate> listCrmContractRelate(CrmContractRelateRo crmContractRelate) {
        return crmContractRelateMapper.listCrmContractRelate(crmContractRelate);
    }

    @Override
    public void insertOrUpdate(List<CrmContractRelate> crmContractRelates) {
        for (CrmContractRelate crmContractRelate : crmContractRelates) {
            if (crmContractRelate.getId() == null) {
                insertCrmContractRelate(crmContractRelate);
            } else {
                updateCrmContractRelateByPk(crmContractRelate);
            }
        }
    }
}
