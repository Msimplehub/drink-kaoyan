package com.meta.crm.intf.res.vo.contract;

import com.meta.framework.util.BeanUtil;
import com.meta.platform.contract.intf.entity.Contract;
import com.meta.platform.file.model.FileInfo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
public class CrmContractDetailVo extends Contract {
    @ApiModelProperty("客户名")
    private String customerName;

    @ApiModelProperty("合同状态描述")
    private String contractStatusDesc;

    @ApiModelProperty("已回款金额")
    private BigDecimal fundedAmount;

    @ApiModelProperty("待回款金额")
    private BigDecimal cashedAmount;

    @ApiModelProperty("已开票金额")
    private BigDecimal invoiceAmount;

    @ApiModelProperty("商机id")
    private Long businessId;

    @ApiModelProperty("商机名称")
    private String businessName;

    @ApiModelProperty("合同类型描述")
    private String contractTypeDesc;

    @ApiModelProperty("合同支付方式描述")
    private String contractPayTypeDesc;

    @ApiModelProperty("客户方签约人名称")
    private String customerSignContactName;

    @ApiModelProperty("我方签约人名称")
    private String ourSideSignUserName;

    @ApiModelProperty("创建人名称")
    private String createUserName;

    @ApiModelProperty("回款计划数量")
    private Integer planCount;

    @ApiModelProperty("回款记录数量")
    private Integer planRecordCount;

    @ApiModelProperty("开票记录数量")
    private Integer invoiceCount;

    @ApiModelProperty("文件地址")
    private List<FileInfo> fileUrls;

    @ApiModelProperty("负责人id")
    private Long assignUserId;

    @ApiModelProperty("负责人姓名")
    private String assignUserName;

    @ApiModelProperty(value = "责任人头像")
    private String assignUserAvatar;

    public CrmContractDetailVo(Contract contract) {
        BeanUtil.copyProperties(contract, this);
    }
}
