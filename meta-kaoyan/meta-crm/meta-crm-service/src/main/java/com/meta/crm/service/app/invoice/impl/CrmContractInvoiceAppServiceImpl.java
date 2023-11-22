package com.meta.crm.service.app.invoice.impl;

import com.meta.act.app.service.ISysDictDataService;
import com.meta.crm.core.mapper.CrmFileRelateMapper;
import com.meta.crm.domain.aggr.CrmContractInvoiceDo;
import com.meta.crm.intf.cmd.invoice.CrmContractInvoiceCreateCmd;
import com.meta.crm.intf.cmd.invoice.CrmContractInvoiceUpdateCmd;
import com.meta.crm.intf.constants.ClueDicTypeConstants;
import com.meta.crm.intf.entity.CrmFileRelate;
import com.meta.crm.intf.enums.OperateTypeEnum;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.service.app.invoice.CrmContractInvoiceAppService;
import com.meta.platform.area.domain.Areas;
import com.meta.platform.area.req.ro.AreasRo;
import com.meta.platform.area.service.AreasQryService;
import com.meta.platform.contract.domain.tunnel.db.ContractInvoiceReceiverRepository;
import com.meta.platform.contract.domain.tunnel.db.ContractInvoiceRepository;
import com.meta.platform.contract.intf.entity.ContractInvoice;
import com.meta.platform.contract.intf.entity.ContractInvoiceReceiver;
import com.meta.platform.contract.intf.ro.ContractInvoiceReceiverRo;
import com.meta.platform.contract.intf.ro.ContractInvoiceRo;
import com.meta.platform.oplog.common.OperateLogHandler;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class CrmContractInvoiceAppServiceImpl implements CrmContractInvoiceAppService {
    @Resource
    private ContractInvoiceRepository contractInvoiceRepository;

    @Resource
    private ContractInvoiceReceiverRepository contractInvoiceReceiverRepository;

    @Resource
    private OperateLogHandler operateLogHandler;

    @Resource
    private ISysDictDataService sysDictDataService;

    @Resource
    private AreasQryService areasQryService;

    @Resource
    private CrmFileRelateMapper crmFileRelateMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void create(CrmContractInvoiceCreateCmd addContractInvoiceCmd) {
        ContractInvoice invoice = CrmContractInvoiceDo.createContractInvoice(addContractInvoiceCmd);
        contractInvoiceRepository.insertContractInvoice(invoice);

        ContractInvoiceReceiver receiver = CrmContractInvoiceDo.createContractInvoiceReceiver(invoice, addContractInvoiceCmd);
        contractInvoiceReceiverRepository.insertContractInvoiceReceiver(receiver);

        if (!CollectionUtils.isEmpty(addContractInvoiceCmd.getFileObjs())) {
            CrmFileRelate crmFileRelate = CrmContractInvoiceDo.createFileRelateFromAddCmd(invoice, addContractInvoiceCmd);
            crmFileRelateMapper.addCrmFileRelate(crmFileRelate);
        }

        operateLogHandler.addLog(TargetType.CONTRACT_INVOICE.getCode(), invoice.getId().toString(),
                OperateTypeEnum.INVOICE_ADD.getCode(), "新建了发票");
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(CrmContractInvoiceUpdateCmd crmContractInvoiceUpdateCmd) {
        ContractInvoiceRo contractInvoiceRo = new ContractInvoiceRo();
        contractInvoiceRo.setId(crmContractInvoiceUpdateCmd.getId());

        List<ContractInvoice> contractInvoices = contractInvoiceRepository.listContractInvoice(contractInvoiceRo);

        if (!CollectionUtils.isEmpty(contractInvoices) && contractInvoices.get(0) != null) {
            crmContractInvoiceUpdateCmd.initFieldDefaultValue();
            ContractInvoice contractInvoice = contractInvoices.get(0);
            // 枚举值
            Map<String, Map<String, String>> enumMap = sysDictDataService.queryDicNamesWithType(Arrays.
                    asList(ClueDicTypeConstants.INVOICE_TITLE_TYPE, ClueDicTypeConstants.INVOICE_CREATE_TYPE, ClueDicTypeConstants.INVOICE_TYPE));

            String mainInfoChange = CrmContractInvoiceDo.compareInvoiceMainInfo(contractInvoice, crmContractInvoiceUpdateCmd, enumMap);

            if (!StringUtils.isEmpty(mainInfoChange)) {
                contractInvoiceRepository.updateContractInvoiceByPk(contractInvoice);
            }

            if (contractInvoice.getInvoiceFileIds() != null) {
                CrmFileRelate crmFileRelate = CrmContractInvoiceDo.createFileRelateFromUpdateCmd(crmContractInvoiceUpdateCmd);
                crmFileRelateMapper.addCrmFileRelate(crmFileRelate);
            }

            ContractInvoiceReceiverRo contractInvoiceReceiverRo = new ContractInvoiceReceiverRo();
            contractInvoiceReceiverRo.setInvoiceId(crmContractInvoiceUpdateCmd.getId());

            List<ContractInvoiceReceiver> contractInvoiceReceivers = contractInvoiceReceiverRepository.listContractInvoiceReceiver(contractInvoiceReceiverRo);

            Set<Long> areaIds = CrmContractInvoiceDo.getAllAreaCodes(contractInvoiceReceivers, crmContractInvoiceUpdateCmd);

            List<Areas> areas = new ArrayList<>();

            if (!CollectionUtils.isEmpty(areaIds)) {
                AreasRo areasRo = AreasRo.builder().areaIdList(new ArrayList<>(areaIds)).build();
                areas = areasQryService.listAreas(areasRo);
            }

            String receiverChange = CrmContractInvoiceDo.compareInvoiceReceiverInfo(contractInvoiceReceivers, crmContractInvoiceUpdateCmd, areas);

            if (!StringUtils.isEmpty(receiverChange)) {
                mainInfoChange = mainInfoChange.concat(receiverChange);
                contractInvoiceReceiverRepository.insertOrUpdate(contractInvoiceReceivers);
            }

            if (!StringUtils.isEmpty(mainInfoChange)) {
                operateLogHandler.addLog(TargetType.CONTRACT_INVOICE.getCode(), crmContractInvoiceUpdateCmd.getId().toString(),
                        OperateTypeEnum.INVOICE_UPDATE.getCode(), mainInfoChange);
            }
        }
    }
}
