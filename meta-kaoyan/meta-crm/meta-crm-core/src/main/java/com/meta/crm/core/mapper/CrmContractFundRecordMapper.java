package com.meta.crm.core.mapper;

import com.meta.crm.intf.req.ro.CrmContractFundRecordRo;
import com.meta.crm.intf.req.ro.CrmContractPlanFundRo;
import com.meta.platform.contract.intf.entity.ContractFundRecord;
import com.meta.platform.contract.intf.entity.ContractPlanFund;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 合同回款记录
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-12-08 15:53:37
 */
@Repository
public interface CrmContractFundRecordMapper {

	List<ContractFundRecord> listTable(CrmContractFundRecordRo recordRo);

}
