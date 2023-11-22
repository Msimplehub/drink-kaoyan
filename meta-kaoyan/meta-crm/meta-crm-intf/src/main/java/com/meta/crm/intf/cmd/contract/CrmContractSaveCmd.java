package com.meta.crm.intf.cmd.contract;

import com.meta.crm.intf.cmd.follow.AddFollowCmd;
import com.meta.platform.contract.intf.entity.Contract;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.List;

@Data
@ApiModel("新增合同入参")
public class CrmContractSaveCmd extends Contract {

    @NotNull
    @ApiModelProperty("合同名")
    private String contractName;

    @NotNull
    @ApiModelProperty("客户id")
    private Long customerId;

    @ApiModelProperty("商机id")
    private Long businessId;

    @NotNull
    @ApiModelProperty("合同金额")
    private BigDecimal contractAmount;

    @NotNull
    @ApiModelProperty("分配负责人")
    private Long assignUserId;

    @NotNull
    @ApiModelProperty("合同类型")
    private String contractType;

    @NotNull
    @ApiModelProperty("合同状态")
    private String contractStatus;

    @ApiModelProperty("附件列表")
    List<AddFollowCmd.FileObj> fileObjs;
}
