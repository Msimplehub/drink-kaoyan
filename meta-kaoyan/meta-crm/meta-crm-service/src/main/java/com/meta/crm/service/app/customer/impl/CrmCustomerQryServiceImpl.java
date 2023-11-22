package com.meta.crm.service.app.customer.impl;

import com.meta.crm.intf.res.vo.customer.CrmCustomerDetailVo;
import com.meta.framework.act.entity.SysUser;
import com.meta.crm.domain.tunnel.db.*;
import com.meta.crm.intf.constants.ClueDicTypeConstants;
import com.meta.crm.domain.aggr.CrmAssignUserDo;
import com.meta.crm.domain.aggr.CrmContactDo;
import com.meta.crm.domain.aggr.CrmCustomerDo;
import com.meta.crm.domain.aggr.CrmFollowDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.follow.BatchQueryLatestFollowRo;
import com.meta.crm.intf.req.ro.CrmContactRo;
import com.meta.crm.intf.req.ro.CrmCustomerRo;
import com.meta.crm.intf.res.vo.assign.CrmAssignUserVo;
import com.meta.crm.intf.res.vo.customer.CrmCustomerVo;
import com.meta.crm.intf.res.vo.follow.CrmFollowVo;
import com.meta.crm.service.app.customer.CrmCustomerQryService;
import com.meta.crm.service.factory.follow.CrmFollowVoFactory;
import com.meta.platform.area.domain.Areas;
import com.meta.platform.area.repository.AreasRepository;
import com.meta.platform.area.req.ro.AreasRo;
import com.meta.act.app.service.ISysDictDataService;
import com.meta.act.app.service.ISysUserService;
import com.meta.platform.contract.domain.aggr.ContractPlanFundDo;
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
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.*;

@Service
public class CrmCustomerQryServiceImpl implements CrmCustomerQryService {

    @Resource
    private CrmCustomerRepository customerRepository;

    @Resource
    private CrmAssignUserRepository crmAssignUserRepository;

    @Resource
    private CrmFollowRepository crmFollowRepository;

    @Resource
    private CrmBusinessRepository crmBusinessRepository;

    @Resource
    private ISysUserService sysUserService;

    @Resource
    private AreasRepository areasRepository;

    @Resource
    private CrmContactRepository contactRepository;

    @Resource
    private ISysDictDataService sysDictDataService;

    @Resource
    private CrmFollowVoFactory crmFollowVoFactory;

    @Resource
    private OssServiceFactory fileServiceFactory;

    @Resource
    private ContractRepository contractRepository;

    @Resource
    private ContractPlanFundRepository contractPlanFundRepository;

    @Resource
    private ContractFundRecordRepository contractFundRecordRepository;

    @Resource
    private ContractInvoiceRepository invoiceRepository;

    @Override
    public List<CrmCustomerDo> listCrmCustomer(CrmCustomerRo req) {

        // customers
        List<CrmCustomerDo> customerList =  customerRepository.listCrmCustomer(req);

        if (CollectionUtils.isEmpty(customerList)){
            return new ArrayList<>();
        }

        return customerList;
    }

    @Override
    public CrmCustomerDo queryByName(String customerName) {

        if (StringUtils.isEmpty(customerName)){
            return null;
        }

        // customers
        CrmCustomerDo customerDo =  customerRepository.getByName(customerName);

        return customerDo;
    }

    @Override
    public List<CrmCustomerVo> listCrmCustomerVo(CrmCustomerRo customer) {

        customer.dealTime();
        List<CrmCustomerDo> customerDos = customerRepository.listCrmCustomer(customer);
        if (CollectionUtils.isEmpty(customerDos)){
            return new ArrayList<>();
        }

        // 查询用IDs
        Set<Long> customerIds = new HashSet<>();
        Set<Long> sysUserIds = new HashSet<>();
        Set<Long> areaIds = new HashSet<>();

        for (CrmCustomerDo customerDo : customerDos) {
            customerIds.add(customerDo.getId());
            sysUserIds.add(customerDo.getCreateBy());
            areaIds.add(customerDo.getProvinceCode());
            areaIds.add(customerDo.getCityCode());
            areaIds.add(customerDo.getRegionCode());
        }

        // trans
        List<CrmCustomerVo> resList = new ArrayList<>();
        for (CrmCustomerDo customerDo : customerDos) {
            resList.add(CrmCustomerVo.of(customerDo));
        }

        /*
         省市区
         */
        AreasRo areasRo = AreasRo.builder().areaIdList(new ArrayList<>(areaIds)).build();
        List<Areas> areas = areasRepository.listAreas(areasRo);
        Map<Long, String> areasNameMap = new HashMap<>();
        for (Areas area : areas) {
            if (area != null){
                areasNameMap.put(area.getAreaId(), area.getAreaName());
            }
        }

        for (CrmCustomerVo crmCustomerVo : resList) {
            crmCustomerVo.setProvinceName(areasNameMap.get(crmCustomerVo.getProvinceCode()));
            crmCustomerVo.setCityName(areasNameMap.get(crmCustomerVo.getCityCode()));
            crmCustomerVo.setRegionName(areasNameMap.get(crmCustomerVo.getRegionCode()));
        }

        /*
         * 责任人
         */
        Map<Long, CrmAssignUserDo> assignUserMap= crmAssignUserRepository.mapByTargetIds(customerIds,
                TargetType.CUSTOMER);
        for (CrmCustomerVo crmCustomerVo : resList) {
            CrmAssignUserVo assignUserVo = CrmAssignUserVo.of(assignUserMap.get(crmCustomerVo.getId()));
            crmCustomerVo.setManager(assignUserVo);
        }

        for (CrmAssignUserDo value : assignUserMap.values()) {
            sysUserIds.add(value.getManagerId());
        }

        /*
         最近跟进信息
         */
        BatchQueryLatestFollowRo followRo = new BatchQueryLatestFollowRo(new ArrayList<>(customerIds),
                TargetType.CUSTOMER.getCode());
        Map<Long, CrmFollowVo> lastFollowDoMap =
                crmFollowVoFactory.buildBaseCrmFollowVo(crmFollowRepository.mapLatestFollowUp(followRo));

        for (CrmCustomerVo crmCustomerVo : resList) {
            crmCustomerVo.setLastFollowInfo(lastFollowDoMap.get(crmCustomerVo.getId()));
        }
        /*
         商机   //商机数量已经由sql带出
         */

        /*
         * 统一填充用户信息
         */
        Map<Long, SysUser> userNameMap = sysUserService.selectUserMapByIds(sysUserIds);

        userNameMap.forEach((k , user) -> {
            // 根据头像的文件ID查询文件url返回
            String fileType = FileType.ALIYUN.toString();
            IFileService fileService = fileServiceFactory.getFileService(fileType);
            List<FileInfo> avatarFiles = fileService.findFilesByIds(Arrays.asList(user.getAvatar()));
            if(avatarFiles != null && avatarFiles.size() > 0){
                user.setAvatar(avatarFiles.get(0).getUrl());
            }
        });

        for (CrmCustomerVo crmCustomerVo : resList) {

            SysUser createUser = userNameMap.get(crmCustomerVo.getCreateBy()) ;
            if (createUser != null){
                crmCustomerVo.setCreateUserName(createUser.getNickName());
            }

            CrmAssignUserVo assignUserVo = crmCustomerVo.getManager();
            if (assignUserVo != null){
                SysUser assignUser = userNameMap.get(assignUserVo.getManagerId());
                if (assignUser != null){
                    assignUserVo.setManagerName(assignUser.getNickName());
                    assignUserVo.setManagerAvatar(assignUser.getAvatar());
                }
            }
        }

        /*
         * 设置字典信息
         */
        // 查询字典
        Map<String, Map<String, String>> enumMap = sysDictDataService.
                queryDicNamesWithType(Arrays.asList(ClueDicTypeConstants.PROFESSION,
                        ClueDicTypeConstants.CUSTOMER_SOURCE, ClueDicTypeConstants.CUSTOMER_LEVER));

        for (CrmCustomerVo crmCustomerVo : resList) {
            // 设置描述
            crmCustomerVo.setProfessionDesc(enumMap.get(ClueDicTypeConstants.PROFESSION).get(crmCustomerVo.getProfession()));
            crmCustomerVo.setCustomerLevelDesc(enumMap.get(ClueDicTypeConstants.CUSTOMER_LEVER).get(crmCustomerVo.getCustomerLevel()));
            crmCustomerVo.setCustomerSourceDesc(enumMap.get(ClueDicTypeConstants.CUSTOMER_SOURCE).get(crmCustomerVo.getSource()));
        }

        return resList;
    }

    @Override
    public CrmCustomerDetailVo queryDetailById(Long customerId) {

        CrmCustomerRo customerRo = new CrmCustomerRo();
        customerRo.setId(customerId);
        List<CrmCustomerVo> resList = listCrmCustomerVo(customerRo);

        if (CollectionUtils.isEmpty(resList)){
            return null;
        }

        CrmCustomerDetailVo res = new CrmCustomerDetailVo();
        BeanUtils.copyProperties(resList.get(0), res);

        /*
         * 补充客户下的联系人数量
         */
        CrmContactRo contactRo = new CrmContactRo();
        contactRo.setCustomerId(customerId);
        List<CrmContactDo> contactDos = contactRepository.listCrmContact(contactRo);
        res.setContactCount(CollectionUtils.isEmpty(contactDos) ? 0 : contactDos.size());

        /*
         * 合同数量
         */
        ContractRo contractRo = new ContractRo();
        contractRo.setCustomerId(customerId);
        List<Contract> contracts = contractRepository.listContract(contractRo);
        res.setContractCount(CollectionUtils.isEmpty(contracts) ? 0 : contracts.size());

        /*
         * 计划数量
         */
        ContractPlanFundRo planFundRo = new ContractPlanFundRo();
        planFundRo.setCustomerId(customerId);
        List<ContractPlanFund> planFunds = contractPlanFundRepository.listContractPlanFund(planFundRo);
        res.setPlanFundCount(CollectionUtils.isEmpty(planFunds) ? 0 : planFunds.size());

        /*
         * 回款记录数量
         */
        ContractFundRecordRo recordRo = new ContractFundRecordRo();
        recordRo.setCustomerId(customerId);
        List<ContractFundRecord> records = contractFundRecordRepository.listContractFundRecord(recordRo);
        res.setFundRecordCount(CollectionUtils.isEmpty(records) ? 0 : records.size());

        /*
         * 开票记录数量
         */
        ContractInvoiceRo invoiceRo = new ContractInvoiceRo();
        invoiceRo.setCustomerId(customerId);
        List<ContractInvoice> invoices = invoiceRepository.listContractInvoice(invoiceRo);
        res.setContractInvoiceCount(CollectionUtils.isEmpty(invoices) ? 0 : invoices.size());

        return res;
    }
}
