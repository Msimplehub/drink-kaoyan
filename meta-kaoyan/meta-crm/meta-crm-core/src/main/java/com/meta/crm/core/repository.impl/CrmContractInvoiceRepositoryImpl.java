package com.meta.crm.core.repository.impl;

import com.meta.crm.core.mapper.CrmContractInvoiceMapper;
import com.meta.crm.core.repository.impl.base.TargetRepositoryImpl;
import com.meta.crm.domain.tunnel.db.CrmContractInvoiceRepository;
import com.meta.crm.intf.domain.TargetDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.invoice.CrmInvoiceListByCustomerIdQry;
import com.meta.crm.intf.req.invoice.CrmInvoiceListQry;
import com.meta.crm.intf.res.vo.invoice.CrmInvoiceListByCustomerIdVo;
import com.meta.crm.intf.res.vo.invoice.CrmInvoiceListVo;
import com.meta.platform.contract.core.mapper.ContractInvoiceMapper;
import com.meta.platform.contract.intf.entity.ContractInvoice;
import com.meta.platform.contract.intf.ro.ContractInvoiceRo;
import org.springframework.stereotype.Repository;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class CrmContractInvoiceRepositoryImpl extends TargetRepositoryImpl implements CrmContractInvoiceRepository {
    @Resource
    private ContractInvoiceMapper contractInvoiceMapper;

    @Resource
    private CrmContractInvoiceMapper crmContractInvoiceMapper;

    @Override
    public TargetDo queryTargetByTargets(Long targetId) {
        ContractInvoiceRo ro = new ContractInvoiceRo();
        ro.setId(targetId);
        List<ContractInvoice> contractInvoiceList = contractInvoiceMapper.listContractInvoice(ro);
        if (!CollectionUtils.isEmpty(contractInvoiceList) && contractInvoiceList.get(0) != null) {
            return new TargetDo() {
                @Override
                public Long getTargetId() {
                    return targetId;
                }

                @Override
                public TargetType getTargetType() {
                    return TargetType.CONTRACT_INVOICE;
                }

                @Override
                public String getTableShowName() {
                    return contractInvoiceList.get(0).getInvoiceTitle();
                }
            };
        }
        return null;
    }

    @Override
    public TargetType getTargetType() {
        return TargetType.CONTRACT_INVOICE;
    }

    @Override
    public List<CrmInvoiceListVo> queryList(CrmInvoiceListQry crmInvoiceListQry) {
        return crmContractInvoiceMapper.queryList(crmInvoiceListQry);
    }

    @Override
    public List<CrmInvoiceListByCustomerIdVo> queryListByCustomerId(CrmInvoiceListByCustomerIdQry crmInvoiceListQry) {
        return crmContractInvoiceMapper.queryListByCustomerId(crmInvoiceListQry);
    }
}
