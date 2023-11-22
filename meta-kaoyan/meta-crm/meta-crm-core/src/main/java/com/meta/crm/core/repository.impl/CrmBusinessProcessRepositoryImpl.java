package com.meta.crm.core.repository.impl;

import com.meta.crm.core.mapper.CrmBusinessProcessMapper;
import com.meta.crm.domain.tunnel.db.*;
import com.meta.crm.intf.entity.*;
import com.meta.crm.intf.req.ro.CrmBusinessProcessRo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 *  
 * @Title:      CrmBusinessProcessRepositoryImpl
 * @Author:     M.simple
 * @Remark:     The modified content
 * @CreateDate: 2020-11-12 17:43:25
 * @Version:    v2.0
 */
@Service
public class CrmBusinessProcessRepositoryImpl implements CrmBusinessProcessRepository{

	@Autowired
	private CrmBusinessProcessMapper crmBusinessProcessMapper;

	/**
	 * insert crmBusinessProcess info
	 * @method      insertCrmBusinessProcess
	 * @param       crmBusinessProcess:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	@Override
	public void insertCrmBusinessProcess(CrmBusinessProcess crmBusinessProcess){
			crmBusinessProcessMapper.insertCrmBusinessProcess(crmBusinessProcess);
	}

	/**
	 * batch insert crmBusinessProcess info
	 * @method      insertCrmBusinessProcess
	 * @param       crmBusinessProcesss:
	 * @return      void
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	@Override
	public void batchInsertCrmBusinessProcess(List<CrmBusinessProcess> crmBusinessProcesss){
			crmBusinessProcessMapper.batchInsertCrmBusinessProcess(crmBusinessProcesss);
	}

	/**
	 * update crmBusinessProcess info
	 * @method      updateCrmBusinessProcess
	 * @param       crmBusinessProcess:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	@Override
	public int updateCrmBusinessProcess(CrmBusinessProcess crmBusinessProcess){
			return crmBusinessProcessMapper.updateCrmBusinessProcess(crmBusinessProcess);
	}

	/**
	 * update crmBusinessProcess info by Pk
	 * @method      updateCrmBusinessProcessByPk
	 * @param       crmBusinessProcess:
	 * @return      int
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	@Override
	public int updateCrmBusinessProcessByPk(CrmBusinessProcess crmBusinessProcess){
		return crmBusinessProcessMapper.updateCrmBusinessProcessByPk(crmBusinessProcess);
	}

	/**
	 * list crmBusinessProcess info
	 * @method      listCrmBusinessProcess
	 * @param       crmBusinessProcess:
	 * @return      List<CrmBusinessProcess>
	 * @author      M.simple
	 * @date        2020-11-12 17:43:25
	 */
	@Override
	public List<CrmBusinessProcess> listCrmBusinessProcess(CrmBusinessProcessRo crmBusinessProcess){
			return crmBusinessProcessMapper.listCrmBusinessProcess(crmBusinessProcess);
	}

}
