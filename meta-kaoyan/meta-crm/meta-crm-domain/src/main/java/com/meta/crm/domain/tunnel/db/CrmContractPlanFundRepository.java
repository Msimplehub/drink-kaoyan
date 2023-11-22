package com.meta.crm.domain.tunnel.db;


import com.meta.crm.domain.aggr.CrmContactDo;
import com.meta.crm.domain.aggr.CrmContractPlanFundDo;
import com.meta.crm.intf.entity.CrmContact;
import com.meta.crm.intf.req.ro.CrmContactRo;
import com.meta.crm.intf.req.ro.CrmContractPlanFundRo;

import java.util.List;

/**
 *
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:26
 */
public interface CrmContractPlanFundRepository {

	void insertContractPlanFund(CrmContractPlanFundDo planFundDo);

	int updateCrmContractPlanFundByPk(CrmContractPlanFundDo planFundDo);

	List<CrmContractPlanFundDo> list(CrmContractPlanFundRo fundRo);

	List<CrmContractPlanFundDo> getByIdList(List<Long> ids);

	CrmContractPlanFundDo getById(Long id);

	Integer queryBatchCountByContractId(Long contractId);

    CrmContractPlanFundDo getByIdWithName(Long id);
}
