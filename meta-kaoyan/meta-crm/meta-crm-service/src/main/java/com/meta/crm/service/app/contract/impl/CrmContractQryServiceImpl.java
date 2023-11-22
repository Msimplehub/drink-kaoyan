package com.meta.crm.service.app.contract.impl;

import com.alibaba.fastjson.JSON;
import com.meta.act.app.service.ISysDictDataService;
import com.meta.act.app.service.ISysUserService;
import com.meta.crm.domain.aggr.CrmAssignUserDo;
import com.meta.crm.domain.aggr.CrmContactDo;
import com.meta.crm.domain.aggr.CrmContractDo;
import com.meta.crm.domain.aggr.CrmCustomerDo;
import com.meta.crm.domain.tunnel.db.CrmAssignUserRepository;
import com.meta.crm.domain.tunnel.db.CrmBusinessRepository;
import com.meta.crm.domain.tunnel.db.CrmContactRepository;
import com.meta.crm.domain.tunnel.db.CrmContractRelateRepository;
import com.meta.crm.domain.tunnel.db.CrmContractRepository;
import com.meta.crm.domain.tunnel.db.CrmCustomerRepository;
import com.meta.crm.domain.tunnel.db.CrmFollowRepository;
import com.meta.crm.intf.constants.ClueDicTypeConstants;
import com.meta.crm.intf.entity.CrmBusiness;
import com.meta.crm.intf.entity.CrmContractRelate;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.contract.CrmContractDetailQry;
import com.meta.crm.intf.req.contract.CrmContractListByCustomerBusinessQry;
import com.meta.crm.intf.req.contract.CrmContractListForFundPlanQry;
import com.meta.crm.intf.req.contract.CrmContractListQry;
import com.meta.crm.intf.req.contract.CrmContractNameCheckQry;
import com.meta.crm.intf.req.follow.BatchQueryLatestFollowRo;
import com.meta.crm.intf.req.ro.CrmContractRelateRo;
import com.meta.crm.intf.req.ro.CrmContractRo;
import com.meta.crm.intf.req.ro.CrmCustomerRo;
import com.meta.crm.intf.res.vo.contract.ContractBusinessName;
import com.meta.crm.intf.res.vo.contract.CrmContractDetailVo;
import com.meta.crm.intf.res.vo.contract.CrmContractListByCustomerBusinessVo;
import com.meta.crm.intf.res.vo.contract.CrmContractListForFundPlanVo;
import com.meta.crm.intf.res.vo.contract.CrmContractListVo;
import com.meta.crm.intf.res.vo.follow.CrmFollowVo;
import com.meta.crm.service.app.contract.CrmContractQryService;
import com.meta.crm.service.factory.follow.CrmFollowVoFactory;
import com.meta.framework.act.entity.SysUser;
import com.meta.framework.common.utils.StringUtils;
import com.meta.platform.contract.domain.tunnel.db.ContractFundRecordRepository;
import com.meta.platform.contract.domain.tunnel.db.ContractInvoiceRepository;
import com.meta.platform.contract.domain.tunnel.db.ContractPlanFundRepository;
import com.meta.platform.contract.domain.tunnel.db.ContractRepository;
import com.meta.platform.contract.intf.entity.Contract;
import com.meta.platform.contract.intf.entity.ContractFundRecord;
import com.meta.platform.contract.intf.entity.ContractInvoice;
import com.meta.platform.contract.intf.entity.ContractPlanFund;
import com.meta.platform.contract.intf.ro.ContractFundRecordRo;
import com.meta.platform.contract.intf.ro.ContractInvoiceRo;
import com.meta.platform.contract.intf.ro.ContractPlanFundRo;
import com.meta.platform.contract.intf.ro.ContractRo;
import com.meta.platform.file.config.OssServiceFactory;
import com.meta.platform.file.model.FileInfo;
import com.meta.platform.file.model.FileType;
import com.meta.platform.file.service.IFileService;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class CrmContractQryServiceImpl implements CrmContractQryService {
    @Resource
    private CrmAssignUserRepository crmAssignUserRepository;

    @Resource
    private ContractRepository contractRepository;

    @Resource
    private ISysDictDataService sysDictDataService;

    @Resource
    private ISysUserService sysUserService;

    @Resource
    private CrmContactRepository crmContactRepository;

    @Resource
    private CrmCustomerRepository crmCustomerRepository;

    @Resource
    private ContractPlanFundRepository contractPlanFundRepository;

    @Resource
    private ContractFundRecordRepository contractFundRecordRepository;

    @Resource
    private ContractInvoiceRepository contractInvoiceRepository;

    @Resource
    private CrmContractRelateRepository crmContractRelateRepository;

    @Resource
    private CrmBusinessRepository crmBusinessRepository;

    @Resource
    private OssServiceFactory fileServiceFactory;

    @Resource
    private CrmContractRepository crmContractRepository;

    @Resource
    private CrmFollowRepository crmFollowRepository;

    @Resource
    private CrmFollowVoFactory crmFollowVoFactory;

    @Override
    public CrmContractDetailVo queryDetail(CrmContractDetailQry crmContractDetailQry) {
        ContractRo contractRo = new ContractRo();
        contractRo.setId(crmContractDetailQry.getId());

        List<Contract> contracts = contractRepository.listContract(contractRo);

        if (!CollectionUtils.isEmpty(contracts) && contracts.get(0) != null) {
            Contract contract = contracts.get(0);
            CrmContractDetailVo result = new CrmContractDetailVo(contract);

            CrmCustomerDo customerDo = crmCustomerRepository.getById(result.getCustomerId());
            if (customerDo != null) {
                result.setCustomerName(customerDo.getCustomerName());
            }

            // 枚举值
            Map<String, Map<String, String>> enumMap = sysDictDataService.queryDicNamesWithType(Arrays.asList(ClueDicTypeConstants.CONTRACT_TYPE,
                    ClueDicTypeConstants.CONTRACT_STATUS, ClueDicTypeConstants.PAY_TYPE));
            if (enumMap.containsKey(ClueDicTypeConstants.CONTRACT_STATUS)) {
                result.setContractStatusDesc(enumMap.get(ClueDicTypeConstants.CONTRACT_STATUS).getOrDefault(result.getContractStatus(), ""));
            }

            //
            ContractPlanFundRo contractPlanFundRo = new ContractPlanFundRo();
            contractPlanFundRo.setContractId(crmContractDetailQry.getId());
            List<ContractPlanFund> contractPlanFunds = contractPlanFundRepository.listContractPlanFund(contractPlanFundRo);
            result.setPlanCount(contractPlanFunds.size());
            BigDecimal fundedAmount = BigDecimal.ZERO;
            for (ContractPlanFund contractPlanFund : contractPlanFunds) {
                fundedAmount = fundedAmount.add(contractPlanFund.getActualAmount());
            }
            BigDecimal cashedAmount = result.getContractAmount().subtract(fundedAmount);
            result.setFundedAmount(fundedAmount);
            result.setCashedAmount(cashedAmount);

            ContractFundRecordRo contractFundRecordRo = new ContractFundRecordRo();
            contractFundRecordRo.setContractId(crmContractDetailQry.getId());
            List<ContractFundRecord> contractFundRecords = contractFundRecordRepository.listContractFundRecord(contractFundRecordRo);
            result.setPlanRecordCount(contractFundRecords.size());

            ContractInvoiceRo contractInvoiceRo = new ContractInvoiceRo();
            contractInvoiceRo.setContractId(crmContractDetailQry.getId());
            List<ContractInvoice> contractInvoices = contractInvoiceRepository.listContractInvoice(contractInvoiceRo);
            BigDecimal invoiceAmount = BigDecimal.ZERO;
            for (ContractInvoice contractInvoice : contractInvoices) {
                invoiceAmount = invoiceAmount.add(contractInvoice.getInvoiceAmount());
            }
            result.setInvoiceAmount(invoiceAmount);
            result.setInvoiceCount(contractInvoices.size());

            CrmContractRelateRo crmContractRelateRo = new CrmContractRelateRo();
            crmContractRelateRo.setContractId(crmContractDetailQry.getId());
            crmContractRelateRo.setTargetType(TargetType.BUSINESS.getCode());
            List<CrmContractRelate> crmContractRelates = crmContractRelateRepository.listCrmContractRelate(crmContractRelateRo);

            if (!CollectionUtils.isEmpty(crmContractRelates) && crmContractRelates.get(0) != null) {
                CrmContractRelate crmContractRelate = crmContractRelates.get(0);
                result.setBusinessId(crmContractRelate.getTargetId());

                CrmBusiness business = crmBusinessRepository.getById(crmContractRelate.getTargetId());
                if (business != null) {
                    result.setBusinessName(business.getBusinessName());
                }
            }

            if (enumMap.containsKey(ClueDicTypeConstants.CONTRACT_TYPE)) {
                result.setContractTypeDesc(enumMap.get(ClueDicTypeConstants.CONTRACT_TYPE).getOrDefault(result.getContractType(), ""));
            }

            if (enumMap.containsKey(ClueDicTypeConstants.PAY_TYPE)) {
                result.setContractPayTypeDesc(enumMap.get(ClueDicTypeConstants.PAY_TYPE).getOrDefault(result.getContractPayType(), ""));
            }

            if (result.getCustomerSignContactId() != null) {
                CrmContactDo contactDo = crmContactRepository.getById(result.getCustomerSignContactId());
                if (contactDo != null) {
                    result.setCustomerSignContactName(contactDo.getName());
                }
            }

            Set<Long> userIds = new HashSet<>();

            CrmAssignUserDo assignUserDo = crmAssignUserRepository.getByTargetId(crmContractDetailQry.getId(), TargetType.CONTRACT);

            if (assignUserDo != null) {
                result.setAssignUserId(assignUserDo.getManagerId());
                userIds.add(assignUserDo.getManagerId());
            }
            if (result.getOurSideSignUserId() != null) {
                userIds.add(result.getOurSideSignUserId());
            }
            if (result.getCreateBy() != null) {
                userIds.add(result.getCreateBy());
            }

            Map<Long, SysUser> userNameMapByIds = sysUserService.selectUserMapByIds(userIds);
            result.setOurSideSignUserName(userNameMapByIds.getOrDefault(result.getOurSideSignUserId(), new SysUser()).getNickName());
            result.setCreateUserName(userNameMapByIds.getOrDefault(result.getCreateBy(), new SysUser()).getNickName());

            Set<String> totalFileIds = new HashSet<>();
            String avatarFileId = null;
            if (userNameMapByIds.containsKey(result.getAssignUserId())) {
                SysUser assignUser = userNameMapByIds.getOrDefault(result.getAssignUserId(), new SysUser());
                result.setAssignUserName(assignUser.getNickName());
                avatarFileId = assignUser.getAvatar();
                totalFileIds.add(avatarFileId);
            }

            List<FileInfo> fileInfos = JSON.parseArray(result.getContractFileIds(), FileInfo.class);

            if (!CollectionUtils.isEmpty(fileInfos)) {
                for (FileInfo fileInfo : fileInfos) {
                    totalFileIds.add(fileInfo.getId());
                }
            }

            if (StringUtils.isNotEmpty(totalFileIds)) {
                String fileType = FileType.ALIYUN.toString();
                IFileService fileService = fileServiceFactory.getFileService(fileType);
                fileInfos = fileService.findFilesByIds(new ArrayList<>(totalFileIds));
                Map<String, String> urlMap = fileInfos.stream().collect(Collectors.toMap(FileInfo::getId, FileInfo::getUrl));
                result.setAssignUserAvatar(urlMap.getOrDefault(avatarFileId, ""));

                if (!CollectionUtils.isEmpty(fileInfos)) {
                    // 去掉头像
                    Iterator<FileInfo> iterator = fileInfos.iterator();
                    do {
                        FileInfo next = iterator.next();
                        if (next.getId().equals(avatarFileId)) {
                            iterator.remove();
                        }
                    } while (iterator.hasNext());
                    result.setFileUrls(fileInfos);
                }
            }

            return result;
        }
        return null;
    }

    @Override
    public List<CrmContractListVo> queryList(CrmContractListQry crmContractListQry) {
        CrmContractRo crmContractRo = CrmContractDo.createQueryContractRo(crmContractListQry);
        List<CrmContractListVo> result = crmContractRepository.queryList(crmContractRo);
        if (CollectionUtils.isEmpty(result)) {
            return Collections.emptyList();
        }
        List<Long> contractIds = new ArrayList<>();
        Set<Long> customerIds = new HashSet<>();
        Set<Long> userIds = new HashSet<>();
        for (CrmContractListVo crmContractListVo : result) {
            contractIds.add(crmContractListVo.getId());
            customerIds.add(crmContractListVo.getCustomerId());
            userIds.add(crmContractListVo.getAssignUserId());
            userIds.add(crmContractListVo.getCreateUserId());
        }

        ContractPlanFundRo queryFundedAmountRo = new ContractPlanFundRo();
        queryFundedAmountRo.setContractIds(contractIds);
        List<ContractPlanFund> contractPlanFunds = contractPlanFundRepository.listContractPlanFund(queryFundedAmountRo);

        Map<Long, BigDecimal> fundedAmount = new HashMap<>();
        for (ContractPlanFund contractPlanFund : contractPlanFunds) {
            Long contractId = contractPlanFund.getContractId();
            if (!fundedAmount.containsKey(contractId)) {
                fundedAmount.put(contractId, BigDecimal.ZERO);
            }
            BigDecimal exist = fundedAmount.get(contractId);
            exist = exist.add(contractPlanFund.getActualAmount());
            fundedAmount.put(contractId, exist);
        }

        BatchQueryLatestFollowRo followRo = new BatchQueryLatestFollowRo(new ArrayList<>(contractIds),
                TargetType.CONTRACT.getCode());
        Map<Long, CrmFollowVo> lastFollowVoMap =
                crmFollowVoFactory.buildBaseCrmFollowVo(crmFollowRepository.mapLatestFollowUp(followRo));

        List<ContractBusinessName> contractBusinessNames = crmContractRepository.queryContractRelateBusinessName(contractIds);
        Map<Long, ContractBusinessName> businessNameMap = contractBusinessNames.stream().
                collect(Collectors.toMap(ContractBusinessName::getId, Function.identity()));

        Map<Long, String> customerNameMap = new HashMap<>();
        if (!CollectionUtils.isEmpty(customerIds)) {
            CrmCustomerRo crmCustomerRo = new CrmCustomerRo();
            crmCustomerRo.setIds(customerIds);
            List<CrmCustomerDo> crmCustomerDos = crmCustomerRepository.listCrmCustomer(crmCustomerRo);
            customerNameMap = crmCustomerDos.stream().collect(Collectors.toMap(CrmCustomerDo::getId, CrmCustomerDo::getCustomerName));
        }

        // 枚举值
        Map<String, Map<String, String>> enumMap = sysDictDataService.queryDicNamesWithType(Arrays.asList(ClueDicTypeConstants.CONTRACT_TYPE,
                ClueDicTypeConstants.CONTRACT_STATUS));

        Map<String, String> typeMap = enumMap.getOrDefault(ClueDicTypeConstants.CONTRACT_TYPE, Collections.emptyMap());

        Map<String, String> statusMap = enumMap.getOrDefault(ClueDicTypeConstants.CONTRACT_STATUS, Collections.emptyMap());

        Map<Long, String> userNameMap = sysUserService.selectUserNameMapByIds(userIds);
        for (CrmContractListVo crmContractListVo : result) {
            Long contractId = crmContractListVo.getId();
            crmContractListVo.setCustomerName(customerNameMap.getOrDefault(crmContractListVo.getCustomerId(), ""));
            ContractBusinessName businessName = businessNameMap.getOrDefault(contractId, new ContractBusinessName());
            crmContractListVo.setBusinessId(businessName.getBusinessId());
            crmContractListVo.setBusinessName(businessName.getBusinessName());

            crmContractListVo.setContractTypeDesc(typeMap.getOrDefault(crmContractListVo.getContractType(), ""));
            crmContractListVo.setContractStatusDesc(statusMap.getOrDefault(crmContractListVo.getContractStatus(), ""));

            crmContractListVo.setAssignUserName(userNameMap.getOrDefault(crmContractListVo.getAssignUserId(), ""));
            crmContractListVo.setCreateUserName(userNameMap.getOrDefault(crmContractListVo.getCreateUserId(), ""));

            crmContractListVo.setFundedAmount(fundedAmount.getOrDefault(contractId, BigDecimal.ZERO));

            crmContractListVo.setLastFollowInfo(lastFollowVoMap.get(contractId));
        }
        return result;
    }

    @Override
    public Contract checkContractName(CrmContractNameCheckQry contractNameCheckQry) {
        ContractRo contractRo = new ContractRo();
        contractRo.setId(contractNameCheckQry.getContractId());
        contractRo.setCustomerId(contractNameCheckQry.getCustomerId());
        contractRo.setContractName(contractNameCheckQry.getContractName());
        List<Contract> contracts = contractRepository.checkContractName(contractRo);
        if (!CollectionUtils.isEmpty(contracts) && contracts.get(0) != null) {
            return contracts.get(0);
        }
        return null;
    }

    @Override
    public List<CrmContractListForFundPlanVo> queryListForFundPlan(CrmContractListForFundPlanQry crmContractListQry) {
        return crmContractRepository.queryListForFundPlan(crmContractListQry);
    }

    @Override
    public List<CrmContractListByCustomerBusinessVo> queryListByCustomerOrBusinessId(CrmContractListByCustomerBusinessQry crmContractListQry) {
        List<CrmContractListByCustomerBusinessVo> result = crmContractRepository.queryListByCustomerOrBusinessId(crmContractListQry);
        if (!CollectionUtils.isEmpty(result)) {
            Map<String, Map<String, String>> enumMap = sysDictDataService.queryDicNamesWithType(Collections.singletonList(ClueDicTypeConstants.CONTRACT_STATUS));

            Set<Long> contractIds = new HashSet<>();

            for (CrmContractListByCustomerBusinessVo crmContractListByCustomerBusinessVo : result) {
                contractIds.add(crmContractListByCustomerBusinessVo.getContractId());
            }

            ContractPlanFundRo queryFundedAmountRo = new ContractPlanFundRo();
            queryFundedAmountRo.setContractIds(new ArrayList<>(contractIds));
            List<ContractPlanFund> contractPlanFunds = contractPlanFundRepository.listContractPlanFund(queryFundedAmountRo);

            Map<Long, BigDecimal> fundedAmount = new HashMap<>();
            for (ContractPlanFund contractPlanFund : contractPlanFunds) {
                Long contractId = contractPlanFund.getContractId();
                if (!fundedAmount.containsKey(contractId)) {
                    fundedAmount.put(contractId, BigDecimal.ZERO);
                }
                BigDecimal exist = fundedAmount.get(contractId);
                exist = exist.add(contractPlanFund.getActualAmount());
                fundedAmount.put(contractId, exist);
            }

            for (CrmContractListByCustomerBusinessVo crmContractListByCustomerBusinessVo : result) {
                Long contractId = crmContractListByCustomerBusinessVo.getContractId();
                crmContractListByCustomerBusinessVo.setContractFundedAmount(fundedAmount.getOrDefault(contractId, BigDecimal.ZERO));
            }

            if (enumMap.containsKey(ClueDicTypeConstants.CONTRACT_STATUS)) {
                Map<String, String> statusMap = enumMap.get(ClueDicTypeConstants.CONTRACT_STATUS);
                for (CrmContractListByCustomerBusinessVo crmContractListByCustomerBusinessVo : result) {
                    crmContractListByCustomerBusinessVo.setContractStatusDesc(statusMap.getOrDefault(crmContractListByCustomerBusinessVo.getContractStatus(), ""));
                }
            }
        }
        return result;
    }
}
