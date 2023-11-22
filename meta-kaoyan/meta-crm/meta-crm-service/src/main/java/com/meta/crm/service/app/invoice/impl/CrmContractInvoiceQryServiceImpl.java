package com.meta.crm.service.app.invoice.impl;

import com.alibaba.fastjson.JSON;
import com.google.common.collect.Sets;
import com.meta.act.app.service.ISysDictDataService;
import com.meta.act.app.service.ISysUserService;
import com.meta.crm.domain.aggr.CrmCustomerDo;
import com.meta.crm.domain.tunnel.db.CrmContractInvoiceRepository;
import com.meta.crm.domain.tunnel.db.CrmCustomerRepository;
import com.meta.crm.intf.cmd.invoice.CrmContractInvoiceDetailQry;
import com.meta.crm.intf.constants.ClueDicTypeConstants;
import com.meta.crm.intf.req.invoice.CrmInvoiceListByCustomerIdQry;
import com.meta.crm.intf.req.invoice.CrmInvoiceListQry;
import com.meta.crm.intf.res.vo.invoice.ContractInvoiceReceiverVo;
import com.meta.crm.intf.res.vo.invoice.CrmContractInvoiceDetailVo;
import com.meta.crm.intf.res.vo.invoice.CrmInvoiceListByCustomerIdVo;
import com.meta.crm.intf.res.vo.invoice.CrmInvoiceListVo;
import com.meta.crm.service.app.invoice.CrmContractInvoiceQryService;
import com.meta.framework.common.utils.StringUtils;
import com.meta.framework.util.BeanUtil;
import com.meta.platform.area.domain.Areas;
import com.meta.platform.area.req.ro.AreasRo;
import com.meta.platform.area.service.AreasQryService;
import com.meta.platform.contract.domain.tunnel.db.ContractInvoiceReceiverRepository;
import com.meta.platform.contract.domain.tunnel.db.ContractInvoiceRepository;
import com.meta.platform.contract.domain.tunnel.db.ContractRepository;
import com.meta.platform.contract.intf.entity.Contract;
import com.meta.platform.contract.intf.entity.ContractInvoice;
import com.meta.platform.contract.intf.entity.ContractInvoiceReceiver;
import com.meta.platform.contract.intf.ro.ContractInvoiceReceiverRo;
import com.meta.platform.contract.intf.ro.ContractInvoiceRo;
import com.meta.platform.contract.intf.ro.ContractRo;
import com.meta.platform.file.config.OssServiceFactory;
import com.meta.platform.file.model.FileInfo;
import com.meta.platform.file.model.FileType;
import com.meta.platform.file.service.IFileService;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class CrmContractInvoiceQryServiceImpl implements CrmContractInvoiceQryService {
    @Resource
    private CrmCustomerRepository crmCustomerRepository;

    @Resource
    private ContractRepository contractRepository;

    @Resource
    private ContractInvoiceRepository contractInvoiceRepository;

    @Resource
    private ContractInvoiceReceiverRepository contractInvoiceReceiverRepository;

    @Resource
    private ISysUserService sysUserService;

    @Resource
    private ISysDictDataService sysDictDataService;

    @Resource
    private AreasQryService areasQryService;

    @Resource
    private OssServiceFactory fileServiceFactory;

    @Resource
    private CrmContractInvoiceRepository crmContractInvoiceRepository;

    @Override
    public CrmContractInvoiceDetailVo queryDetail(CrmContractInvoiceDetailQry crmContractInvoiceDetailQry) {
        ContractInvoiceRo contractInvoiceRo = new ContractInvoiceRo();
        contractInvoiceRo.setId(crmContractInvoiceDetailQry.getId());
        List<ContractInvoice> contractInvoices = contractInvoiceRepository.listContractInvoice(contractInvoiceRo);
        if (!CollectionUtils.isEmpty(contractInvoices) && contractInvoices.get(0) != null) {
            ContractInvoice contractInvoice = contractInvoices.get(0);
            CrmContractInvoiceDetailVo result = new CrmContractInvoiceDetailVo();
            BeanUtil.copyProperties(contractInvoice, result);
            CrmCustomerDo customerDo = crmCustomerRepository.getById(result.getCustomerId());
            if (customerDo != null) {
                result.setCustomerName(customerDo.getCustomerName());
            }
            ContractRo contractRo = new ContractRo();
            contractRo.setId(result.getContractId());
            List<Contract> contracts = contractRepository.listContract(contractRo);
            if (!CollectionUtils.isEmpty(contracts) && contracts.get(0) != null) {
                result.setContractName(contracts.get(0).getContractName());
            }

            Map<String, Map<String, String>> enumMap = sysDictDataService.queryDicNamesWithType(Arrays.
                    asList(ClueDicTypeConstants.INVOICE_TITLE_TYPE, ClueDicTypeConstants.INVOICE_TYPE, ClueDicTypeConstants.INVOICE_CREATE_TYPE));

            Map<String, String> titleType = enumMap.getOrDefault(ClueDicTypeConstants.INVOICE_TITLE_TYPE, Collections.emptyMap());
            result.setTitleTypeDesc(titleType.getOrDefault(result.getTitleType(), ""));

            Map<String, String> invoiceType = enumMap.getOrDefault(ClueDicTypeConstants.INVOICE_TYPE, Collections.emptyMap());
            result.setInvoiceTypeDesc(invoiceType.getOrDefault(result.getInvoiceType(), ""));

            Map<String, String> createType = enumMap.getOrDefault(ClueDicTypeConstants.INVOICE_CREATE_TYPE, Collections.emptyMap());
            result.setInvoiceCreateTypeDesc(createType.getOrDefault(result.getInvoiceCreateType(), ""));

            Set<String> fileIds = new HashSet<>();

            List<FileInfo> fileInfos = JSON.parseArray(result.getInvoiceFileIds(), FileInfo.class);

            if (!CollectionUtils.isEmpty(fileInfos)) {
                for (FileInfo fileInfo : fileInfos) {
                    fileIds.add(fileInfo.getId());
                }
                if (StringUtils.isNotEmpty(fileIds)) {
                    String fileType = FileType.ALIYUN.toString();
                    IFileService fileService = fileServiceFactory.getFileService(fileType);
                    fileInfos = fileService.findFilesByIds(new ArrayList<>(fileIds));
                    if (!CollectionUtils.isEmpty(fileInfos)) {
                        result.setFileUrls(fileInfos);
                    }
                }
            }

            HashSet<Long> userIds = Sets.newHashSet(result.getCreateBy());
            Map<Long, String> userNameMap = sysUserService.selectUserNameMapByIds(userIds);

            result.setCreateUserName(userNameMap.getOrDefault(result.getCreateBy(), ""));

            ContractInvoiceReceiverRo contractInvoiceReceiverRo = new ContractInvoiceReceiverRo();
            contractInvoiceReceiverRo.setInvoiceId(crmContractInvoiceDetailQry.getId());
            List<ContractInvoiceReceiver> contractInvoiceReceivers = contractInvoiceReceiverRepository.
                    listContractInvoiceReceiver(contractInvoiceReceiverRo);
            if (!CollectionUtils.isEmpty(contractInvoiceReceivers) && contractInvoiceReceivers.get(0) != null) {
                ContractInvoiceReceiver receiver = contractInvoiceReceivers.get(0);
                ContractInvoiceReceiverVo receiverVo = new ContractInvoiceReceiverVo();
                BeanUtil.copyProperties(receiver, receiverVo);
                Set<Long> areaIds = new HashSet<>();
                if (receiver.getReceiverProvince() != null) {
                    areaIds.add(receiver.getReceiverProvince());
                }
                if (receiver.getReceiverCity() != null) {
                    areaIds.add(receiver.getReceiverCity());
                }
                if (receiver.getReceiverDistrict() != null) {
                    areaIds.add(receiver.getReceiverDistrict());
                }
                if (!CollectionUtils.isEmpty(areaIds)) {
                    AreasRo areasRo = AreasRo.builder().areaIdList(new ArrayList<>(areaIds)).build();
                    List<Areas> areas = areasQryService.listAreas(areasRo);
                    Map<Long, String> areaMap = areas.stream().collect(Collectors.toMap(Areas::getAreaId, Areas::getAreaName));
                    receiverVo.setReceiverProvinceName(areaMap.getOrDefault(receiver.getReceiverProvince(), ""));
                    receiverVo.setReceiverCityName(areaMap.getOrDefault(receiver.getReceiverCity(), ""));
                    receiverVo.setReceiverDistrictName(areaMap.getOrDefault(receiver.getReceiverDistrict(), ""));
                }
                result.setInvoiceReceiver(receiverVo);
            }
            return result;
        }
        return null;
    }

    @Override
    public List<CrmInvoiceListVo> queryList(CrmInvoiceListQry crmInvoiceListQry) {
        crmInvoiceListQry.initEndTime();
        List<CrmInvoiceListVo> result = crmContractInvoiceRepository.queryList(crmInvoiceListQry);
        if (CollectionUtils.isEmpty(result)) {
            return Collections.emptyList();
        }

        Map<String, Map<String, String>> enumMap = sysDictDataService.queryDicNamesWithType(Arrays.
                asList(ClueDicTypeConstants.INVOICE_TITLE_TYPE, ClueDicTypeConstants.INVOICE_TYPE, ClueDicTypeConstants.INVOICE_CREATE_TYPE));
        Set<Long> userIds = new HashSet<>();

        for (CrmInvoiceListVo crmInvoiceListVo : result) {
            Map<String, String> titleType = enumMap.getOrDefault(ClueDicTypeConstants.INVOICE_TITLE_TYPE, Collections.emptyMap());
            crmInvoiceListVo.setTitleTypeDesc(titleType.getOrDefault(crmInvoiceListVo.getTitleType(), ""));

            Map<String, String> invoiceType = enumMap.getOrDefault(ClueDicTypeConstants.INVOICE_TYPE, Collections.emptyMap());
            crmInvoiceListVo.setInvoiceTypeDesc(invoiceType.getOrDefault(crmInvoiceListVo.getInvoiceType(), ""));

            Map<String, String> invoiceCreateType = enumMap.getOrDefault(ClueDicTypeConstants.INVOICE_CREATE_TYPE, Collections.emptyMap());
            crmInvoiceListVo.setInvoiceCreateTypeDesc(invoiceCreateType.getOrDefault(crmInvoiceListVo.getInvoiceCreateType(), ""));

            userIds.add(crmInvoiceListVo.getCreateUserId());
        }

        Map<Long, String> userNameMap = sysUserService.selectUserNameMapByIds(userIds);

        for (CrmInvoiceListVo crmInvoiceListVo : result) {
            crmInvoiceListVo.setCreateUserName(userNameMap.getOrDefault(crmInvoiceListVo.getCreateUserId(), ""));
        }

        return result;
    }

    @Override
    public List<CrmInvoiceListByCustomerIdVo> queryListByCustomerId(CrmInvoiceListByCustomerIdQry crmInvoiceListQry) {
        List<CrmInvoiceListByCustomerIdVo> result = crmContractInvoiceRepository.queryListByCustomerId(crmInvoiceListQry);
        if (!CollectionUtils.isEmpty(result)) {
            Map<String, Map<String, String>> enumMap = sysDictDataService.queryDicNamesWithType(Collections.singletonList(ClueDicTypeConstants.INVOICE_TYPE));
            if (enumMap.containsKey(ClueDicTypeConstants.INVOICE_TYPE)) {
                Map<String, String> typeMap = enumMap.get(ClueDicTypeConstants.INVOICE_TYPE);
                for (CrmInvoiceListByCustomerIdVo crmInvoiceListByCustomerIdVo : result) {
                    crmInvoiceListByCustomerIdVo.setInvoiceTypeDesc(typeMap.getOrDefault(crmInvoiceListByCustomerIdVo.getInvoiceType(), ""));
                }
            }
        }
        return result;
    }
}
