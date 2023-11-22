package com.meta.crm.service.app.contract.impl;

import com.meta.crm.domain.tunnel.db.CrmContractRelateRepository;
import com.meta.crm.intf.entity.CrmContractRelate;
import com.meta.crm.intf.req.ro.CrmContractRelateRo;
import com.meta.crm.service.app.contract.CrmContractRelateQryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 *  合同关系表
 * @Title:      CrmContractRelateQryServiceImpl
 * @Author:     M.simple
 * @Remark:     The modified content
 * @CreateDate: 2020-12-09 10:49:27
 * @Version:    v2.0
 */
@Service
public class CrmContractRelateQryServiceImpl implements CrmContractRelateQryService {

	@Autowired
	private CrmContractRelateRepository crmContractRelateRepository;

	/**
	 * list crmContractRelate info
	 * @method      listCrmContractRelate
	 * @param       crmContractRelate:
	 * @return      List<CrmContractRelate>
	 * @author      M.simple
	 * @date        2020-12-09 10:49:27
	 */
	@Override
	public List<CrmContractRelate> listCrmContractRelate(CrmContractRelateRo crmContractRelate){
			return crmContractRelateRepository.listCrmContractRelate(crmContractRelate);
	}

}
