package com.meta.crm.core.mapper;

import com.meta.crm.domain.aggr.CrmContractPlanFundDo;
import com.meta.crm.intf.req.ro.CrmContractPlanFundRo;
import com.meta.platform.contract.intf.entity.ContractPlanFund;
import com.meta.platform.contract.intf.ro.ContractPlanFundRo;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 合同计划回款
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-12-08 15:53:37
 */
@Repository
public interface CrmContractPlanFundMapper {

	/**
	 * list contractPlanFund info
	 * @method listContractPlanFund
	 * @return List<ContractPlanFund>
	 * @author      M.simple
	 * @date        2020-12-08 15:53:37
	 */
	List<ContractPlanFund> listTable(CrmContractPlanFundRo contractPlanFundRo);

	Integer queryBatchCountByContractId(Long contractId);
}
