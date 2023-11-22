package com.meta.crm.domain.aggr;

import com.meta.crm.intf.cmd.business.BusinessChangeStageCmd;
import com.meta.crm.intf.cmd.business.BusinessUpdateCmd;
import com.meta.crm.intf.cmd.clue.ClueConvertBusinessCmd;
import com.meta.crm.intf.domain.TargetDo;
import com.meta.crm.intf.entity.CrmBusiness;
import com.meta.crm.intf.entity.CrmBusinessContactRelate;
import com.meta.crm.intf.entity.CrmClue;
import com.meta.crm.intf.entity.CrmTemplate;
import com.meta.crm.intf.entity.CrmTemplateStage;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.log.ClueConvertLog;
import com.meta.crm.intf.req.follow.BatchQueryLatestFollowRo;
import com.meta.crm.intf.req.ro.CrmTemplateStageRo;
import com.meta.crm.intf.res.vo.business.BusinessContactDetailListVo;
import com.meta.crm.intf.res.vo.business.BusinessDetailVo;
import com.meta.crm.intf.res.vo.business.BusinessListVo;
import com.meta.crm.intf.res.vo.business.BusinessStageDetailListVo;
import com.meta.crm.intf.res.vo.business.CustomerBusinessListVo;
import com.meta.crm.intf.res.vo.follow.CrmFollowVo;
import com.meta.framework.act.entity.SysUser;
import com.meta.framework.common.utils.SecurityUtils;
import com.meta.framework.common.utils.StringUtils;
import com.meta.platform.file.model.FileInfo;
import lombok.Data;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.util.CollectionUtils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;
import java.util.stream.Collectors;

@Data
public class CrmBusinessDo extends CrmBusiness implements TargetDo {

    public CrmBusinessDo() {
    }

    public CrmBusinessDo(CrmBusiness crmBusiness) {
        BeanUtils.copyProperties(crmBusiness, this);
    }

    public static CrmBusinessDo of(CrmBusiness entity) {
        if (entity == null) {
            return null;
        }

        CrmBusinessDo business = new CrmBusinessDo();
        BeanUtils.copyProperties(entity, business);
        return business;
    }

    public static List<CrmBusinessDo> of(List<CrmBusiness> entitys) {
        if (CollectionUtils.isEmpty(entitys)) {
            return new ArrayList<>();
        }

        return entitys.stream().map(CrmBusinessDo::of).collect(Collectors.toList());
    }

    public static CrmTemplateStageRo getBusinessStageList(List<BusinessListVo> resultList) {
        CrmTemplateStageRo ro = new CrmTemplateStageRo();
        ro.setStageCodes(resultList.stream().map(BusinessListVo::getCurrentStageCode).collect(Collectors.toSet()));
        return ro;
    }

    public static BatchQueryLatestFollowRo createQueryBusinessListFollowRo(List<BusinessListVo> resultList) {
        BatchQueryLatestFollowRo ro = new BatchQueryLatestFollowRo();
        ro.setTargetIds(new ArrayList<>(resultList.stream().map(BusinessListVo::getBusinessId).collect(Collectors.toSet())));
        ro.setTargetType(TargetType.BUSINESS.getCode());
        return ro;
    }

    public static Set<Long> getBusinessListUserIds(List<BusinessListVo> resultList) {
        Set<Long> userIds = new HashSet<>();
        for (BusinessListVo businessListVo : resultList) {
            userIds.add(businessListVo.getCreateBy());
            userIds.add(businessListVo.getUserId());
        }
        return userIds;
    }

    public static void fillBusinessListOtherInfo(List<BusinessListVo> resultList, List<CrmTemplateStage> crmTemplateStages,
                                                 Map<Long, CrmFollowVo> crmFollows, Map<Long, SysUser> userNameMap) {
        Map<String, String> stageNameMap = crmTemplateStages.stream().collect(Collectors.toMap(CrmTemplateStage::getCode, CrmTemplateStage::getName));
        for (BusinessListVo businessListVo : resultList) {
            String currentStageCode = businessListVo.getCurrentStageCode();
            if (stageNameMap.containsKey(currentStageCode)) {
                businessListVo.setCurrentStageDesc(stageNameMap.get(currentStageCode));
            }

            Long userId = businessListVo.getUserId();
            businessListVo.setUserName(userNameMap.getOrDefault(userId, new SysUser()).getNickName());
            Long businessId = businessListVo.getBusinessId();

            // 跟进信息
            if (crmFollows.containsKey(businessId)) {
                businessListVo.setLastFollowInfo(crmFollows.get(businessId));
            }

            Long createUserId = businessListVo.getCreateBy();
            businessListVo.setCreateUserName(userNameMap.getOrDefault(createUserId, new SysUser()).getNickName());
        }

    }

    public static void fillBusinessDetailOtherInfo(BusinessDetailVo businessDetailVo, CrmCustomerDo customerDo,
                                                   List<CrmTemplateStage> crmTemplateStages,
                                                   Map<Long, SysUser> userNameMap, List<FileInfo> avatarFileInfos,
                                                   CrmAssignUserDo crmAssignUserDo,
                                                   CrmFollowDo crmFollowDo, int contactCount, int contractCount) {
        // 客户名
        if (customerDo != null) {
            businessDetailVo.setCustomerName(customerDo.getCustomerName());
        }
        Map<String, CrmTemplateStage> stageMap = new HashMap<>();
        // 阶段列表
        List<BusinessStageDetailListVo> businessStageDetailListVos = new ArrayList<>();
        String currentStageCode = businessDetailVo.getCurrentStageCode();
        for (CrmTemplateStage crmTemplateStage : crmTemplateStages) {
            stageMap.put(crmTemplateStage.getCode(), crmTemplateStage);
            BusinessStageDetailListVo vo = new BusinessStageDetailListVo();
            vo.setStageCode(crmTemplateStage.getCode());
            vo.setStageDesc(crmTemplateStage.getName());
            vo.setSort(crmTemplateStage.getSort());
            vo.setIsCurrent(crmTemplateStage.getCode().equals(currentStageCode));
            businessStageDetailListVos.add(vo);
        }
        businessDetailVo.setBusinessStageDetailListVos(businessStageDetailListVos);

        // 当前阶段名
        if (stageMap.containsKey(currentStageCode) && stageMap.get(currentStageCode) != null) {
            CrmTemplateStage crmTemplateStage = stageMap.get(currentStageCode);
            businessDetailVo.setCurrentStageDesc(crmTemplateStage.getName());
            businessDetailVo.setCurrentStageSort(crmTemplateStage.getSort());
        }

        if (crmFollowDo != null) {
            businessDetailVo.setFollowUpDate(crmFollowDo.getCreateTime());
        }

        // 人员名称
        Long createBy = businessDetailVo.getCreateBy();
        if (userNameMap.containsKey(createBy)) {
            businessDetailVo.setCreateByName(userNameMap.get(createBy).getNickName());
        }

        Map<String, String> avatarMap = avatarFileInfos.stream().collect(Collectors.toMap(FileInfo::getId, FileInfo::getUrl));

        if (crmAssignUserDo != null && crmAssignUserDo.getManagerId() != null) {
            businessDetailVo.setManagerId(crmAssignUserDo.getManagerId());
            SysUser orDefault = userNameMap.getOrDefault(crmAssignUserDo.getManagerId(), new SysUser());
            businessDetailVo.setManagerName(orDefault.getNickName());
            String avatarFileId = orDefault.getAvatar();
            businessDetailVo.setManagerAvatar(avatarMap.getOrDefault(avatarFileId, ""));
        }

        businessDetailVo.setContactCount(contactCount);
        businessDetailVo.setContractCount(contractCount);
    }

    public static List<BusinessContactDetailListVo> createBusinessContactList(List<CrmBusinessContactRelate> crmBusinessContactRelateList,
                                                                              List<CrmContactDo> crmContactDos) {
        // 联系人
        List<BusinessContactDetailListVo> businessContactDetailListVos = new ArrayList<>();
        Map<Long, CrmContactDo> contactBaseInfoMap = crmContactDos.stream().
                collect(Collectors.toMap(CrmContactDo::getId, Function.identity()));

        for (CrmBusinessContactRelate crmBusinessContactRelate : crmBusinessContactRelateList) {
            BusinessContactDetailListVo vo = new BusinessContactDetailListVo();
            vo.setId(crmBusinessContactRelate.getId());
            vo.setType(crmBusinessContactRelate.getType());
            Long contactId = crmBusinessContactRelate.getContactId();
            vo.setContactId(contactId);
            if (contactBaseInfoMap.containsKey(contactId)) {
                CrmContactDo crmContactDo = contactBaseInfoMap.get(contactId);
                vo.setContactName(crmContactDo.getName());
                vo.setApartment(crmContactDo.getApartment());
                vo.setPosition(crmContactDo.getPosition());
                vo.setMobile(crmContactDo.getMobile());
                vo.setStandScore(crmContactDo.getStandScore());
            }
            businessContactDetailListVos.add(vo);
        }

        return businessContactDetailListVos;
    }

    static String handleNull(String original) {
        return original == null ? "" : original;
    }

    public static String updateBusinessBase(CrmBusiness crmBusiness, BusinessUpdateCmd req) {
        if (crmBusiness.equals(req)) {
            return "";
        }
        StringBuilder stringBuilder = new StringBuilder();
        if (!StringUtils.equals(crmBusiness.getBusinessName(), req.getBusinessName())) {
            stringBuilder.append("将商机名称由 ").append(handleNull(crmBusiness.getBusinessName())).append(" 变更为 ").append(handleNull(req.getBusinessName())).append("<br>");
            crmBusiness.setBusinessName(req.getBusinessName());
        } else {
            crmBusiness.setBusinessName(null);
        }

        if (crmBusiness.getEstimateDealAmount().compareTo(req.getEstimateDealAmount()) != 0) {
            stringBuilder.append("将商机预计成交金额由 ").append(crmBusiness.getEstimateDealAmount()).append(" 变更为 ").append(req.getEstimateDealAmount()).append("<br>");
            crmBusiness.setEstimateDealAmount(req.getEstimateDealAmount());
        } else {
            crmBusiness.setEstimateDealAmount(null);
        }

        if (!crmBusiness.getEstimateDealDate().equals(req.getEstimateDealDate())) {
            stringBuilder.append("将商机预计成交日期由 ").append(DateFormatUtils.format(crmBusiness.getEstimateDealDate(), "yyyy-MM-dd"))
                    .append(" 变更为 ").append(DateFormatUtils.format(req.getEstimateDealDate(), "yyyy-MM-dd")).append("<br>");
            crmBusiness.setEstimateDealDate(req.getEstimateDealDate());
        } else {
            crmBusiness.setEstimateDealDate(null);
        }

        if (!StringUtils.equals(crmBusiness.getRemark(), req.getRemark())) {
            stringBuilder.append("将商机备注由 ").append(handleNull(crmBusiness.getRemark())).append(" 变更为 ").append(handleNull(req.getRemark())).append("<br>");
            crmBusiness.setRemark(req.getRemark());
        } else {
            crmBusiness.setRemark(null);
        }

        // 比较
        return stringBuilder.toString();
    }

    public static CrmTemplateStageRo createCustomerTemplateStageRo(List<CrmBusiness> crmBusinesses) {
        CrmTemplateStageRo ro = new CrmTemplateStageRo();
        ro.setStageCodes(crmBusinesses.stream().map(CrmBusiness::getCurrentStageCode).collect(Collectors.toSet()));
        return ro;
    }

    public static List<CustomerBusinessListVo> createCustomerBusinessListVo(List<CrmTemplateStage> crmTemplateStages, List<CrmBusiness> crmBusinesses) {
        List<CustomerBusinessListVo> result = new ArrayList<>();
        Map<String, String> stageNameMap = crmTemplateStages.stream().collect(Collectors.toMap(CrmTemplateStage::getCode, CrmTemplateStage::getName));
        for (CrmBusiness crmBusiness : crmBusinesses) {
            CustomerBusinessListVo vo = new CustomerBusinessListVo();
            BeanUtils.copyProperties(crmBusiness, vo);
            vo.setCurrentStageDesc(stageNameMap.getOrDefault(vo.getCurrentStageCode(), ""));
            result.add(vo);
        }
        return result;
    }

    public static String updateBusinessStage(CrmBusiness crmBusiness, BusinessChangeStageCmd req, List<CrmTemplateStage> crmTemplateStages, Map<String, String> loseReasonMap) {
        StringBuilder stringBuilder = new StringBuilder();
        String currentStageCode = crmBusiness.getCurrentStageCode();
        String nextStageCode = req.getNextStageCode();
        Map<String, String> stageNameMap = crmTemplateStages.stream().collect(Collectors.toMap(CrmTemplateStage::getCode, CrmTemplateStage::getName));
        if (!currentStageCode.equals(nextStageCode)) {
            stringBuilder.append("将商机阶段由 ").append(stageNameMap.getOrDefault(currentStageCode, ""))
                    .append(" 变更为 ").append(stageNameMap.getOrDefault(nextStageCode, "")).append("<br>");
            crmBusiness.setCurrentStageCode(nextStageCode);
        }
        if (!StringUtils.isEmpty(req.getLoseReason())) {
            stringBuilder.append("输单理由: ").append(loseReasonMap.getOrDefault(req.getLoseReason(), "")).append("<br>");
            crmBusiness.setLoseReason(req.getLoseReason());
        }
        if (!StringUtils.isEmpty(req.getLoseDesc())) {
            stringBuilder.append("输单描述: ").append(req.getLoseDesc()).append("<br>");
            crmBusiness.setLoseDesc(req.getLoseDesc());
        }
        crmBusiness.setUpdateBy(SecurityUtils.getUserId());
        if (req.getDealDate() != null) {
            stringBuilder.append("将商机成交日期由 ").append(crmBusiness.getRealDealDate() == null ? "" : DateFormatUtils.format(crmBusiness.getRealDealDate(), "yyyy-MM-dd"))
                    .append(" 变更为 ").append(DateFormatUtils.format(req.getDealDate(), "yyyy-MM-dd")).append("<br>");
            crmBusiness.setRealDealDate(req.getDealDate());
        }
        return stringBuilder.toString();
    }

    public BusinessDetailVo createBusinessDetailVo(CrmBusiness crmBusiness) {
        BusinessDetailVo vo = new BusinessDetailVo();
        BeanUtils.copyProperties(crmBusiness, vo);
        BeanUtils.copyProperties(crmBusiness, this);
        return vo;
    }

    public CrmBusiness createFromClue(ClueConvertBusinessCmd req, CrmTemplate crmTemplate, CrmCustomerDo crmCustomerDo) {
        CrmBusiness crmBusiness = new CrmBusiness();
        crmBusiness.setBusinessName(req.getBusinessName());
        crmBusiness.setClueId(req.getClueId());
        crmBusiness.setCustomerId(crmCustomerDo.getId());
        crmBusiness.setTemplateId(crmTemplate.getId());
        crmBusiness.setCurrentStageCode(req.getBusinessStage());
        crmBusiness.setEstimateDealAmount(req.getEstimateDealAmount());
        crmBusiness.setEstimateDealDate(req.getEstimateDealDate());
        crmBusiness.setCreateBy(SecurityUtils.getUserId());
        return crmBusiness;
    }

    public CrmCustomerDo createCustomerDo(ClueConvertBusinessCmd req, CrmClue crmClue) {
        CrmCustomerDo crmCustomerDo = new CrmCustomerDo();
        crmCustomerDo.setId(req.getCustomerId());
        crmCustomerDo.setSource(crmClue.getClueSource());
        crmCustomerDo.setCustomerName(req.getCustomerName());
        crmCustomerDo.setCompanyId(req.getCompanyId());
        crmCustomerDo.setClueId(req.getClueId());
        return crmCustomerDo;
    }

    public CrmTemplateStageRo createTemplateStageRo() {
        CrmTemplateStageRo ro = new CrmTemplateStageRo();
        ro.setTemplateId(getTemplateId());
        return ro;
    }

    public Set<Long> getAllBusinessDetailUserIds(CrmAssignUserDo crmAssignUserDo) {
        Set<Long> result = new HashSet<>();
        result.add(getCreateBy());
        if (crmAssignUserDo != null) {
            result.add(crmAssignUserDo.getManagerId());
        }
        return result;
    }

    @Override
    public Long getTargetId() {
        return getId();
    }

    @Override
    public TargetType getTargetType() {
        return TargetType.BUSINESS;
    }

    @Override
    public String getTargetName() {
        return this.getBusinessName();
    }

    public ClueConvertLog createConvertLog(CrmClue crmClue) {
        ClueConvertLog log = new ClueConvertLog();
        log.setLog("将销售线索转为商机,转换前线索: #targetName#");
        log.setTargetType("clue");
        log.setTargetId(crmClue.getId().toString());
        log.setTargetName(crmClue.getInformantName());
        return log;
    }

    public static void main(String[] args) {
        BigDecimal bigDecimal = BigDecimal.valueOf(2000);
        System.out.println(bigDecimal.compareTo(new BigDecimal("2000.00")));
    }
}
