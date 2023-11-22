package com.meta.crm.core.repository.impl;

import com.meta.framework.common.utils.SecurityUtils;
import com.meta.crm.core.mapper.CrmBusinessMapper;
import com.meta.crm.core.mapper.CrmContactMapper;
import com.meta.crm.core.mapper.CrmCustomerMapper;
import com.meta.crm.domain.tunnel.db.*;
import com.meta.crm.core.repository.impl.base.TargetRepositoryImpl;
import com.meta.crm.intf.entity.*;
import com.meta.crm.domain.aggr.CrmBusinessDo;
import com.meta.crm.domain.aggr.CrmContactDo;
import com.meta.crm.domain.aggr.CrmCustomerDo;
import com.meta.crm.intf.domain.TargetDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.ro.CrmBusinessRo;
import com.meta.crm.intf.req.ro.CrmContactRo;
import com.meta.crm.intf.req.ro.CrmCustomerRo;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @Title:      CrmContactRepositoryImpl
 * @Author:     M.simple
 * @Remark:     The modified content
 * @CreateDate: 2020-11-12 17:43:26
 * @Version:    v2.0
 */
@Service
public class CrmContactRepositoryImpl extends TargetRepositoryImpl implements CrmContactRepository{

	@Resource
	private CrmContactMapper crmContactMapper;

	@Resource
	private CrmCustomerMapper crmCustomerMapper;

	@Resource
	private CrmBusinessMapper crmBusinessMapper;

	@Override
	public void saveCrmContact(CrmContactDo crmContact) {
		if (crmContact.getId() == null){
			insertCrmContact(crmContact);
		}
		else {
			updateCrmContactByPk(crmContact);
		}
	}

	/**
	 * insert crmContact info
	 * @method      insertCrmContact
	 * @param       crmContact:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	@Override
	public void insertCrmContact(CrmContactDo crmContact){
		crmContact.setCreateBy(SecurityUtils.getUserId());
		crmContact.setUpdateBy(SecurityUtils.getUserId());
		crmContactMapper.insertCrmContact(crmContact);
	}

	/**
	 * batch insert crmContact info
	 * @method      insertCrmContact
	 * @param       crmContacts:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	@Override
	public void batchInsertCrmContact(List<CrmContactDo> crmContacts){
		if (CollectionUtils.isEmpty(crmContacts)){
			return;
		}

		crmContactMapper.batchInsertCrmContact(new ArrayList<>(crmContacts));
	}

	/**
	 * update crmContact info
	 * @method      updateCrmContact
	 * @param       crmContact:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	@Override
	public int updateCrmContact(CrmContactDo crmContact){
		crmContact.setUpdateBy(SecurityUtils.getUserId());
		return crmContactMapper.updateCrmContact(crmContact);
	}

	/**
	 * update crmContact info by Pk
	 * @method      updateCrmContactByPk
	 * @param       crmContact:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	@Override
	public int updateCrmContactByPk(CrmContact crmContact){
		crmContact.setUpdateBy(SecurityUtils.getUserId());
		return crmContactMapper.updateCrmContactByPk(crmContact);
	}

	/**
	 * list crmContact info
	 * @method      listCrmContact
	 * @param       crmContact:
	 * @return      List<CrmContact>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:26
	 */
	@Override
	public List<CrmContactDo> listCrmContact(CrmContactRo crmContact){
		return CrmContactDo.of(crmContactMapper.listCrmContact(crmContact));
	}

	@Override
	public CrmContactDo getById(Long id) {
		CrmContactRo contactRo = new CrmContactRo();
		contactRo.setId(id);
		CrmContact contact = crmContactMapper.getById(contactRo);
		return CrmContactDo.of(contact);
	}

	@Override
	public CrmContactDo getByMobileAndCustomerId(String mobile, Long customerId) {
		CrmContactRo contactRo = new CrmContactRo();
		contactRo.setCustomerId(customerId);
		contactRo.setMobile(mobile);
		List<CrmContact> resList = crmContactMapper.listCrmContact(contactRo);
		if (CollectionUtils.isEmpty(resList)){
			return null;
		}

		return CrmContactDo.of(resList.get(0));
	}

	/**
	 * 联系人详情，展示联系人所在客户下所有实体的跟进。
	 */
	@Override
	public List<TargetDo> queryShowFollowTargets(Long contactId) {

		// 查询联系人信息
		CrmContactDo contactDo = this.getById(contactId);
		if (contactDo == null){
			return new ArrayList<>();
		}

		// 查询客户信息
		Long customerId = contactDo.getCustomerId();
		CrmCustomerRo customerRo = new CrmCustomerRo();
		customerRo.setId(customerId);
		CrmCustomerDo customerDo = CrmCustomerDo.of(crmCustomerMapper.getById(customerRo));
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
	public TargetDo queryTargetByTargets(Long targetId) {
		return getById(targetId);
	}

	@Override
	public TargetType getTargetType() {
		return TargetType.CONTACT;
	}
}
