package com.meta.crm.service.app.contract;


import com.meta.crm.intf.entity.CrmContractRelate;
import com.meta.crm.intf.req.ro.CrmContractRelateRo;

import java.util.List;

/**
 * 合同关系表
 * 
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-12-09 10:49:27
 */
public interface CrmContractRelateQryService{

	/**
	 * list crmContractRelate info
	 * @method      listCrmContractRelate
	 * @param       crmContractRelate:
	 * @return      List<CrmContractRelate>
	 * @author      M.simple
	 * @date        2020-12-09 10:49:27
	 */
	List<CrmContractRelate> listCrmContractRelate(CrmContractRelateRo crmContractRelate);

}
