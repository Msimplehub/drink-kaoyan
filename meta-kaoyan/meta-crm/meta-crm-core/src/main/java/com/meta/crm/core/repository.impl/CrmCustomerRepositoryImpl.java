package com.meta.crm.core.repository.impl;

import com.meta.crm.intf.exception.customer.CustomerNameRepeatException;
import com.meta.framework.common.utils.SecurityUtils;
import com.meta.crm.core.mapper.CrmAssignMapper;
import com.meta.crm.core.mapper.CrmBusinessMapper;
import com.meta.crm.core.mapper.CrmContactMapper;
import com.meta.crm.core.mapper.CrmCustomerMapper;
import com.meta.crm.core.repository.impl.base.TargetRepositoryImpl;
import com.meta.crm.domain.aggr.CrmBusinessDo;
import com.meta.crm.domain.aggr.CrmContactDo;
import com.meta.crm.domain.aggr.CrmCustomerDo;
import com.meta.crm.domain.tunnel.db.*;
import com.meta.crm.intf.entity.*;
import com.meta.crm.intf.domain.TargetDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.ro.CrmBusinessRo;
import com.meta.crm.intf.req.ro.CrmContactRo;
import com.meta.crm.intf.req.ro.CrmCustomerRo;
import com.meta.framework.common.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @Title:      CrmCustomerRepositoryImpl
 * @Author:     M.simple
 * @Remark:     The modified content
 * @CreateDate: 2020-11-12 17:43:26
 * @Version:    v2.0
 */
@Service
public class CrmCustomerRepositoryImpl  extends TargetRepositoryImpl implements CrmCustomerRepository {

	@Autowired
	private CrmCustomerMapper crmCustomerMapper;

	@Resource
	private CrmAssignMapper crmAssignMapper;

	@Resource
	private CrmBusinessMapper crmBusinessMapper;

	@Resource
	private CrmContactMapper crmContactMapper;

	@Override
	public void saveCrmCustomer(CrmCustomerDo crmCustomer) {

		// 新增or 更新
		if (crmCustomer.getId() == null){

			// 根据客户名查询
			CrmCustomerDo oldCustomerDo = this.getByName(crmCustomer.getCustomerName());
			if (oldCustomerDo != null){
				throw new CustomerNameRepeatException();
			}

			// 保存客户本体
			crmCustomer.setCreateBy(SecurityUtils.getUserId());
			crmCustomer.setUpdateBy(SecurityUtils.getUserId());
			crmCustomerMapper.insertCrmCustomer(crmCustomer);

		}
		else{

			CrmCustomerDo old = this.getById(crmCustomer.getId());

			if (!StringUtils.equals(old.getCustomerName(), crmCustomer.getCustomerName())){
				// 根据客户名查询
				CrmCustomerDo oldCustomerDo = this.getByName(crmCustomer.getCustomerName());
				if (oldCustomerDo != null){
					throw new CustomerNameRepeatException();
				}
			}

			crmCustomer.setUpdateBy(SecurityUtils.getUserId());
			crmCustomerMapper.updateCrmCustomerByPk(crmCustomer);
		}

	}

	@Override
	public void batchSaveCrmCustomer(List<CrmCustomerDo> crmCustomers) {

	}

	@Override
	public int updateCrmCustomer(CrmCustomerDo crmCustomer) {
		return 0;
	}

	@Override
	public int updateCrmCustomerByPk(CrmCustomerDo crmCustomer) {
		return 0;
	}

	/**
	 * list crmCustomer info
	 * @method      listCrmCustomer
	 * @param       crmCustomer:
	 * @return      List<CrmCustomer>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	@Override
	public List<CrmCustomerDo> listCrmCustomer(CrmCustomerRo crmCustomer){

		List<CrmCustomer> entitys = crmCustomerMapper.listCrmCustomer(crmCustomer);

		return CrmCustomerDo.of(entitys);
	}

	@Override
	public CrmCustomerDo getById(Long id) {

		if (id == null){
			return null;
		}

		CrmCustomerRo customerRo = new CrmCustomerRo();
		customerRo.setId(id);
		CrmCustomer customer = crmCustomerMapper.getById(customerRo);
		if (customer != null){
			CrmCustomerDo res =  CrmCustomerDo.of(customer);

			return res;
		}
		return null;
	}

	@Override
	public CrmCustomerDo getByName(String customerName) {
		CrmCustomerRo customerRo = new CrmCustomerRo();
		customerRo.setCustomerName(customerName);
		CrmCustomer customer = crmCustomerMapper.getByName(customerRo);
		if (customer != null){
			CrmCustomerDo res =  CrmCustomerDo.of(customer);

			return res;
		}
		return null;
	}

	/**
	 * 客户详情，展示客户下所有实体的跟进。
	 */
	@Override
	public List<TargetDo> queryShowFollowTargets(Long customerId) {

		// 查询客户信息
		CrmCustomerDo customerDo = this.getById(customerId);
		if (customerDo == null){
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
		if (!CollectionUtils.isEmpty(businesses)){
			for (CrmBusiness business : businesses) {
				targetDos.add(CrmBusinessDo.of(business));
			}
		}

		// 客户下的联系人
		CrmContactRo crmContactRo = new CrmContactRo();
		crmContactRo.setCustomerId(customerId);
		List<CrmContact> contactDos = crmContactMapper.listCrmContact(crmContactRo);
		if (!CollectionUtils.isEmpty(contactDos)){
			for (CrmContact contact : contactDos) {
				targetDos.add(CrmContactDo.of(contact));
			}
		}

		return targetDos;
	}

	@Override
	public TargetDo queryTargetByTargets(Long customerId) {
		// 查询客户信息
		CrmCustomerDo customerDo = this.getById(customerId);
		return customerDo;
	}

	@Override
	public TargetType getTargetType() {
		return TargetType.CUSTOMER;
	}
}
