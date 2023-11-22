package com.meta.crm.intf.cmd.business;

import com.meta.framework.common.utils.SecurityUtils;
import com.meta.crm.intf.entity.CrmBusiness;
import com.meta.crm.intf.entity.CrmBusinessContactRelate;
import com.meta.crm.intf.enums.BusinessContactTypeEnum;
import com.meta.crm.intf.req.ro.CrmBusinessRo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.beans.BeanUtils;

import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;

@Data
public class BusinessSaveCmd extends CrmBusiness {

    @NotNull(message = "商机阶段为空")
    @ApiModelProperty(value = "商机阶段")
    private String currentStageCode;

    @NotNull(message = "阶段模板id为空")
    @ApiModelProperty(value = "阶段模板id")
    private Long templateId;

    @NotNull(message = "客户id为空")
    @ApiModelProperty(value = "客户id")
    private Long customerId;

    @NotNull(message = "商机责任人为空")
    @ApiModelProperty(value = "商机责任人")
    private Long assignUserId;

    @ApiModelProperty(value = "C联系人")
    private Long confirmContactUserId;

    @ApiModelProperty(value = "1W联系人")
    private Long winContactUserId;

    public CrmBusiness createBusiness() {
        CrmBusiness crmBusiness = new CrmBusiness();
        BeanUtils.copyProperties(this, crmBusiness);
        crmBusiness.setCreateBy(SecurityUtils.getUserId());
        return crmBusiness;
    }

    public List<CrmBusinessContactRelate> createBusinessContactList(CrmBusiness crmBusiness) {
        List<CrmBusinessContactRelate> result = new ArrayList<>();
        if (this.getConfirmContactUserId() != null) {
            CrmBusinessContactRelate crmBusinessContactRelate = new CrmBusinessContactRelate();
            crmBusinessContactRelate.setBusinessId(crmBusiness.getId());
            crmBusinessContactRelate.setContactId(this.getConfirmContactUserId());
            crmBusinessContactRelate.setType(BusinessContactTypeEnum.C.code);
            result.add(crmBusinessContactRelate);
        }
        if (this.getWinContactUserId() != null) {
            CrmBusinessContactRelate crmBusinessContactRelate = new CrmBusinessContactRelate();
            crmBusinessContactRelate.setBusinessId(crmBusiness.getId());
            crmBusinessContactRelate.setContactId(this.getWinContactUserId());
            crmBusinessContactRelate.setType(BusinessContactTypeEnum.ONE_W.code);
            result.add(crmBusinessContactRelate);
        }
        return result;
    }

    public CrmBusinessRo createCheckBusinessNameRo() {
        CrmBusinessRo ro = new CrmBusinessRo();
        ro.setCustomerId(this.getCustomerId());
        ro.setBusinessName(this.getBusinessName());
        return ro;
    }
}
