package com.meta.crm.core.repository.impl;

import com.meta.crm.core.mapper.CrmBusinessMapper;
import com.meta.crm.core.mapper.CrmContactMapper;
import com.meta.crm.core.mapper.CrmCustomerMapper;
import com.meta.crm.core.repository.impl.base.TargetRepositoryImpl;
import com.meta.crm.domain.tunnel.db.CrmBusinessRepository;
import com.meta.crm.intf.entity.CrmBusiness;
import com.meta.crm.intf.entity.CrmContact;
import com.meta.crm.domain.aggr.CrmBusinessDo;
import com.meta.crm.domain.aggr.CrmContactDo;
import com.meta.crm.domain.aggr.CrmCustomerDo;
import com.meta.crm.intf.domain.TargetDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.ro.CrmBusinessRo;
import com.meta.crm.intf.req.ro.CrmContactRo;
import com.meta.crm.intf.req.ro.CrmCustomerRo;
import com.meta.crm.intf.res.vo.business.BusinessListVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 商机主表
 *
 * @Title: CrmBusinessRepositoryImpl
 * @Author: M.simple
 * @Remark: The modified content
 * @CreateDate: 2020-11-12 17:43:25
 * @Version: v2.0
 */
@Service
public class CrmBusinessRepositoryImpl extends TargetRepositoryImpl implements CrmBusinessRepository {

    @Autowired
    private CrmBusinessMapper crmBusinessMapper;

    @Resource
    private CrmCustomerMapper crmCustomerMapper;

    @Resource
    private CrmContactMapper crmContactMapper;

    /**
     * insert crmBusiness info
     *
     * @param crmBusiness:
     * @return void
     * @method insertCrmBusiness
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    @Override
    public void insertCrmBusiness(CrmBusiness crmBusiness) {
        crmBusinessMapper.insertCrmBusiness(crmBusiness);
    }

    /**
     * batch insert crmBusiness info
     *
     * @param crmBusinesss:
     * @return void
     * @method insertCrmBusiness
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    @Override
    public void batchInsertCrmBusiness(List<CrmBusiness> crmBusinesss) {
        crmBusinessMapper.batchInsertCrmBusiness(crmBusinesss);
    }

    /**
     * update crmBusiness info
     *
     * @param crmBusiness:
     * @return int
     * @method updateCrmBusiness
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    @Override
    public int updateCrmBusiness(CrmBusiness crmBusiness) {
        return crmBusinessMapper.updateCrmBusiness(crmBusiness);
    }

    /**
     * update crmBusiness info by Pk
     *
     * @param crmBusiness:
     * @return int
     * @method updateCrmBusinessByPk
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    @Override
    public int updateCrmBusinessByPk(CrmBusiness crmBusiness) {
        return crmBusinessMapper.updateCrmBusinessByPk(crmBusiness);
    }

    /**
     * list crmBusiness info
     *
     * @param crmBusiness:
     * @return List<CrmBusiness>
     * @method listCrmBusiness
     * @author M.simple
     * @date 2020-11-12 17:43:25
     */
    @Override
    public List<CrmBusiness> listCrmBusiness(CrmBusinessRo crmBusiness) {
        return crmBusinessMapper.listCrmBusiness(crmBusiness);
    }

    @Override
    public List<BusinessListVo> queryBusinessList(CrmBusinessRo crmBusinessRo) {
        return crmBusinessMapper.queryBusinessList(crmBusinessRo);
    }

    @Override
    public List<CrmBusiness> businessNameCheck(CrmBusinessRo crmBusinessRo) {
        return crmBusinessMapper.businessNameCheck(crmBusinessRo);
    }

    @Override
    public List<CrmBusiness> listCrmBusinessWithContactId(CrmBusinessRo contactQryRo) {
        return crmBusinessMapper.listCrmBusinessWithContactId(contactQryRo);
    }

    @Override
    public CrmBusiness getById(Long id) {
        if (id == null){
            return null;
        }
        CrmBusinessRo crmBusinessRo = new CrmBusinessRo();
        crmBusinessRo.setId(id);
        List<CrmBusiness> businesses = this.listCrmBusiness(crmBusinessRo);
        if (CollectionUtils.isEmpty(businesses)) {
            return null;
        }
        return businesses.get(0);
    }

    /**
     * 联系人详情，展示联系人所在客户下所有实体的跟进。
     */
    @Override
    public List<TargetDo> queryShowFollowTargets(Long businessId) {

        // 查询商机本身信息
        CrmBusiness curBusiness = this.getById(businessId);
        if (curBusiness == null) {
            return new ArrayList<>();
        }

        // 查询客户信息
        Long customerId = curBusiness.getCustomerId();
        CrmCustomerRo customerRo = new CrmCustomerRo();
        customerRo.setId(customerId);
        CrmCustomerDo customerDo = CrmCustomerDo.of(crmCustomerMapper.getById(customerRo));
        if (customerDo == null) {
            return new ArrayList<>();
        }

        //res
        List<TargetDo> targetDos = new ArrayList<>();

        // 客户本身
        targetDos.add(customerDo);

        // 客户下的商机
        CrmBusinessRo businessRo = new CrmBusinessRo();
        businessRo.setCustomerId(customerId);
        List<CrmBusiness> businesses = crmBusinessMapper.listCrmBusiness(businessRo);
        if (!CollectionUtils.isEmpty(businesses)) {
            for (CrmBusiness business : businesses) {
                targetDos.add(CrmBusinessDo.of(business));
            }
        }

        // 客户下的联系人
        CrmContactRo crmContactRo = new CrmContactRo();
        crmContactRo.setCustomerId(customerId);
        List<CrmContact> contactDos = crmContactMapper.listCrmContact(crmContactRo);
        if (!CollectionUtils.isEmpty(contactDos)) {
            for (CrmContact contact : contactDos) {
                targetDos.add(CrmContactDo.of(contact));
            }
        }

        return targetDos;
    }

    @Override
    public TargetDo queryTargetByTargets(Long targetId) {
        return CrmBusinessDo.of(this.getById(targetId));
    }

    @Override
    public TargetType getTargetType() {
        return TargetType.BUSINESS;
    }
}
