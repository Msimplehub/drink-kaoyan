package com.meta.crm.service.app.business.impl;

import com.meta.act.app.service.ISysUserService;
import com.meta.crm.domain.aggr.CrmAssignUserDo;
import com.meta.crm.domain.aggr.CrmBusinessContactRelateDo;
import com.meta.crm.domain.aggr.CrmBusinessDo;
import com.meta.crm.domain.aggr.CrmContactDo;
import com.meta.crm.domain.aggr.CrmCustomerDo;
import com.meta.crm.domain.aggr.CrmFollowDo;
import com.meta.crm.domain.tunnel.db.CrmAssignUserRepository;
import com.meta.crm.domain.tunnel.db.CrmBusinessContactRelateRepository;
import com.meta.crm.domain.tunnel.db.CrmBusinessRepository;
import com.meta.crm.domain.tunnel.db.CrmContactRepository;
import com.meta.crm.domain.tunnel.db.CrmContractRelateRepository;
import com.meta.crm.domain.tunnel.db.CrmCustomerRepository;
import com.meta.crm.domain.tunnel.db.CrmFollowRepository;
import com.meta.crm.domain.tunnel.db.CrmTemplateStageRepository;
import com.meta.crm.intf.entity.CrmBusiness;
import com.meta.crm.intf.entity.CrmBusinessContactRelate;
import com.meta.crm.intf.entity.CrmContractRelate;
import com.meta.crm.intf.entity.CrmTemplateStage;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.business.BusinessContactQry;
import com.meta.crm.intf.req.business.BusinessDetailQry;
import com.meta.crm.intf.req.business.BusinessListQry;
import com.meta.crm.intf.req.business.BusinessNameCheckQry;
import com.meta.crm.intf.req.business.CustomerBusinessListQry;
import com.meta.crm.intf.req.follow.BatchQueryLatestFollowRo;
import com.meta.crm.intf.req.ro.CrmBusinessRo;
import com.meta.crm.intf.req.ro.CrmContractRelateRo;
import com.meta.crm.intf.req.ro.CrmTemplateStageRo;
import com.meta.crm.intf.res.vo.business.BusinessContactDetailListVo;
import com.meta.crm.intf.res.vo.business.BusinessDetailVo;
import com.meta.crm.intf.res.vo.business.BusinessListVo;
import com.meta.crm.intf.res.vo.business.BusinessNameCheckVo;
import com.meta.crm.intf.res.vo.business.CustomerBusinessListVo;
import com.meta.crm.intf.res.vo.follow.CrmFollowVo;
import com.meta.crm.service.app.business.CrmBusinessQryService;
import com.meta.crm.service.factory.follow.CrmFollowVoFactory;
import com.meta.framework.act.entity.SysUser;
import com.meta.platform.file.mapper.FileMapper;
import com.meta.platform.file.model.FileInfo;
import com.meta.platform.oplog.repository.OperateLogRepository;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class CrmBusinessQryServiceImpl implements CrmBusinessQryService {

    @Resource
    private CrmBusinessRepository crmBusinessRepository;

    @Resource
    private CrmTemplateStageRepository crmTemplateStageRepository;

    @Resource
    private CrmFollowRepository crmFollowRepository;

    @Resource
    private ISysUserService sysUserService;

    @Resource
    private CrmContactRepository crmContactRepository;

    @Resource
    private CrmCustomerRepository crmCustomerRepository;

    @Resource
    private CrmBusinessContactRelateRepository crmBusinessContactRelateRepository;

    @Resource
    private OperateLogRepository operateLogRepository;

    @Resource
    private CrmAssignUserRepository crmAssignUserRepository;

    @Resource
    private CrmFollowVoFactory crmFollowVoFactory;

    @Resource
    private FileMapper fileMapper;

    @Resource
    private CrmContractRelateRepository crmContractRelateRepository;

    @Override
    public List<BusinessListVo> queryList(BusinessListQry req) {
        CrmBusinessRo crmBusinessRo = req.createBusinessListRo();
        List<BusinessListVo> resultList = crmBusinessRepository.queryBusinessList(crmBusinessRo);
        if (CollectionUtils.isEmpty(resultList)) {
            return Collections.emptyList();
        }
        // 查询阶段描述
        CrmTemplateStageRo templateStageRo = CrmBusinessDo.getBusinessStageList(resultList);
        List<CrmTemplateStage> crmTemplateStages = crmTemplateStageRepository.listCrmTemplateStage(templateStageRo);

        // 查询跟进记录
        BatchQueryLatestFollowRo crmFollowRo = CrmBusinessDo.createQueryBusinessListFollowRo(resultList);
        // 跟进记录
        Map<Long, CrmFollowVo> lastFollowDoMap =
                crmFollowVoFactory.buildBaseCrmFollowVo(crmFollowRepository.mapLatestFollowUp(crmFollowRo));

        // 所有用户名称
        Set<Long> allUserIds = CrmBusinessDo.getBusinessListUserIds(resultList);
        Map<Long, SysUser> userMap = sysUserService.selectUserMapByIds(allUserIds);

        // 填充信息
        CrmBusinessDo.fillBusinessListOtherInfo(resultList, crmTemplateStages,
                lastFollowDoMap, userMap);

        return resultList;
    }

    @Override
    public BusinessNameCheckVo businessNameCheck(BusinessNameCheckQry req) {
        CrmBusinessRo crmBusinessRo = req.createCrmBusinessRo();
        List<CrmBusiness> crmBusinesses = crmBusinessRepository.businessNameCheck(crmBusinessRo);
        if (!CollectionUtils.isEmpty(crmBusinesses) && crmBusinesses.get(0) != null) {
            return new BusinessNameCheckVo(crmBusinesses.get(0));
        }
        return null;
    }

    @Override
    public BusinessDetailVo detail(BusinessDetailQry req) {
        CrmBusinessDo crmBusinessDo = new CrmBusinessDo();
        CrmBusinessRo businessDetailRo = req.createBusinessDetailRo();
        List<CrmBusiness> crmBusinesses = crmBusinessRepository.listCrmBusiness(businessDetailRo);
        if (!CollectionUtils.isEmpty(crmBusinesses) && crmBusinesses.get(0) != null) {
            CrmBusiness crmBusiness = crmBusinesses.get(0);
            BusinessDetailVo businessDetailVo = crmBusinessDo.createBusinessDetailVo(crmBusiness);

            CrmAssignUserDo crmAssignUserDo = crmAssignUserRepository.getByTargetId(crmBusiness.getId(), TargetType.BUSINESS);

            CrmFollowDo crmFollowDo = crmFollowRepository.queryLatestFollow(req.getId(), TargetType.BUSINESS);
            // 客户信息
            CrmCustomerDo customerDo = crmCustomerRepository.getById(businessDetailVo.getCustomerId());

            // 阶段配置
            List<CrmTemplateStage> crmTemplateStages = crmTemplateStageRepository.listCrmTemplateStage(crmBusinessDo.createTemplateStageRo());

            // 查询人员姓名
            Set<Long> userIds = crmBusinessDo.getAllBusinessDetailUserIds(crmAssignUserDo);
            Map<Long, SysUser> userMap = sysUserService.selectUserMapByIds(userIds);
            List<String> avatarFileIds = userMap.values().stream().map(SysUser::getAvatar).collect(Collectors.toList());

            List<FileInfo> avatarFileInfos = fileMapper.selectByIds(avatarFileIds);

            int contactCount = crmBusinessContactRelateRepository.countCrmBusinessContactRelate(req.createBusinessContactRelateRo());

            CrmContractRelateRo crmContractRelateRo = new CrmContractRelateRo();
            crmContractRelateRo.setTargetId(req.getId());
            crmContractRelateRo.setTargetType(TargetType.CONTRACT.getCode());
            List<CrmContractRelate> crmContractRelates = crmContractRelateRepository.listCrmContractRelate(crmContractRelateRo);
            int contractCount = CollectionUtils.isEmpty(crmContractRelates) ? 0 : crmContractRelates.size();

            // 填充信息
            CrmBusinessDo.fillBusinessDetailOtherInfo(businessDetailVo, customerDo, crmTemplateStages, userMap, avatarFileInfos,
                    crmAssignUserDo, crmFollowDo, contactCount, contractCount);

            return businessDetailVo;
        }
        return null;
    }

    @Override
    public List<CustomerBusinessListVo> queryByCustomerId(CustomerBusinessListQry req) {
        List<CrmBusiness> crmBusinesses = new ArrayList<>();

        if (req.getCustomerId() != null) {
            crmBusinesses = crmBusinessRepository.listCrmBusiness(req.createCustomerQryRo());
        }
        if (req.getContactId() != null) {
            crmBusinesses = crmBusinessRepository.listCrmBusinessWithContactId(req.createContactQryRo());
        }

        if (CollectionUtils.isEmpty(crmBusinesses)) {
            return Collections.emptyList();
        }

        // 阶段配置
        List<CrmTemplateStage> crmTemplateStages = crmTemplateStageRepository.listCrmTemplateStage(CrmBusinessDo.createCustomerTemplateStageRo(crmBusinesses));

        return CrmBusinessDo.createCustomerBusinessListVo(crmTemplateStages, crmBusinesses);
    }

    @Override
    public List<BusinessContactDetailListVo> queryBusinessContact(BusinessContactQry req) {
        // 联系人id + 联系人类型
        List<CrmBusinessContactRelate> crmBusinessContactRelateList = crmBusinessContactRelateRepository.
                listCrmBusinessContactRelate(req.createCrmBusinessContactRelateRo());
        if (CollectionUtils.isEmpty(crmBusinessContactRelateList)) {
            return Collections.emptyList();
        }

        // 联系人基础信息
        List<CrmContactDo> crmContactDos = crmContactRepository.
                listCrmContact(CrmBusinessContactRelateDo.createCrmContactRo(crmBusinessContactRelateList));

        return CrmBusinessDo.createBusinessContactList(crmBusinessContactRelateList, crmContactDos);
    }
}
