package com.meta.crm.domain.tunnel.db;


import com.meta.crm.domain.aggr.CrmContractFundRecordDo;
import com.meta.crm.domain.aggr.CrmContractPlanFundDo;
import com.meta.crm.intf.req.ro.CrmContractFundRecordRo;
import com.meta.crm.intf.req.ro.CrmContractPlanFundRo;

import java.util.List;

/**
 *
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:26
 */
public interface CrmContractFundRecordRepository {

	List<CrmContractFundRecordDo> listTable(CrmContractFundRecordRo fundRo);

	CrmContractFundRecordDo getById(Long id);

	CrmContractFundRecordDo getByIdWithName(Long id);

}
