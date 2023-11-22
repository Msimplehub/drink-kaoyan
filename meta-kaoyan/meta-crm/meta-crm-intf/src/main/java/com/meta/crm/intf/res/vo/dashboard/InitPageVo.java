package com.meta.crm.intf.res.vo.dashboard;

import com.meta.crm.intf.entity.CrmAssignUser;
import com.meta.crm.intf.entity.CrmBusiness;
import com.meta.crm.intf.entity.CrmTemplateStage;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.ro.CrmBusinessRo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.util.CollectionUtils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@Data
public class InitPageVo {
    @ApiModelProperty(value = "线索数量")
    private Integer clueCount = 0;

    @ApiModelProperty(value = "客户数量")
    private Integer customerCount = 0;

    @ApiModelProperty(value = "联系人数量")
    private Integer contactCount = 0;

    @ApiModelProperty(value = "商机数量")
    private Integer businessCount = 0;

    @ApiModelProperty(value = "销售漏斗")
    private List<SalesFunnelVo> salesFunnelVos = new ArrayList<>();

    @ApiModelProperty(value = "商机id")
    private List<Long> businessIds = new ArrayList<>();

    public void initCount(List<CrmAssignUser> crmAssignUsers) {
        for (CrmAssignUser crmAssignUser : crmAssignUsers) {
            if (crmAssignUser.getTargetType().equals(TargetType.CLUE.getCode())) {
                setClueCount(getClueCount() + 1);
            }
            if (crmAssignUser.getTargetType().equals(TargetType.CUSTOMER.getCode())) {
                setCustomerCount(getCustomerCount() + 1);
            }
            if (crmAssignUser.getTargetType().equals(TargetType.CONTACT.getCode())) {
                setContactCount(getContactCount() + 1);
            }
            if (crmAssignUser.getTargetType().equals(TargetType.BUSINESS.getCode())) {
                setBusinessCount(getBusinessCount() + 1);
                businessIds.add(crmAssignUser.getTargetId());
            }
        }

    }

    public CrmBusinessRo batchQueryBusinessRo() {
        if (CollectionUtils.isEmpty(businessIds)) {
            return null;
        }
        CrmBusinessRo ro = new CrmBusinessRo();
        ro.setBusinessIds(businessIds);
        ro.setDelFlag(0);
        return ro;
    }

    public void initStageAmount(List<CrmTemplateStage> crmTemplateStages, List<CrmBusiness> crmBusinesses) {
        Map<String, CrmTemplateStage> stageMap = crmTemplateStages.stream().collect(Collectors.toMap(CrmTemplateStage::getCode, Function.identity()));
        Map<String, BigDecimal> moneyMap = new HashMap<>();
        for (CrmBusiness crmBusiness : crmBusinesses) {
            String currentStageCode = crmBusiness.getCurrentStageCode();
            if (!moneyMap.containsKey(currentStageCode)) {
                moneyMap.put(currentStageCode, BigDecimal.ZERO);
            }
            BigDecimal decimal = moneyMap.get(currentStageCode);
            moneyMap.put(currentStageCode, decimal.add(crmBusiness.getEstimateDealAmount()));
        }
        for (Map.Entry<String, CrmTemplateStage> codeEntry : stageMap.entrySet()) {
            String code = codeEntry.getKey();
            CrmTemplateStage value = codeEntry.getValue();
            SalesFunnelVo salesFunnelVo = new SalesFunnelVo();
            salesFunnelVo.setSaleStageCode(code);
            salesFunnelVo.setSaleStageDesc(value.getName());
            salesFunnelVo.setSaleStageSort(value.getSort());
            salesFunnelVo.setTotalAmount(moneyMap.getOrDefault(code, BigDecimal.ZERO));
            getSalesFunnelVos().add(salesFunnelVo);
        }

        // 排序
        getSalesFunnelVos().sort(Comparator.comparing(SalesFunnelVo::getSaleStageSort));
    }
}
