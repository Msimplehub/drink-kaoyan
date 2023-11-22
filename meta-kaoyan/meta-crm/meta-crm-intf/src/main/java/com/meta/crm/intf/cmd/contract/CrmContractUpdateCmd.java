package com.meta.crm.intf.cmd.contract;

import com.meta.crm.intf.cmd.follow.AddFollowCmd;
import com.meta.framework.common.utils.DateUtils;
import com.meta.platform.contract.intf.entity.Contract;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.util.CollectionUtils;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Data
@ApiModel("更新合同入参")
public class CrmContractUpdateCmd extends Contract {

	@NotNull
	@ApiModelProperty("合同id")
	private Long id;

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
	@ApiModelProperty("合同类型")
	private String contractType;

	@NotNull
	@ApiModelProperty("合同状态")
	private String contractStatus;

	@ApiModelProperty("附件列表")
	List<AddFollowCmd.FileObj> fileObjs;

	public void initFieldDefaultValue() {
		if (getContractPayType() == null) {
			this.setContractPayType("");
		}
		if (getContractNum() == null) {
			this.setContractNum("");
		}
		if (CollectionUtils.isEmpty(fileObjs)) {
			this.setContractFileIds("");
		}
		if (getRemark() == null) {
			this.setRemark("");
		}
	}

	public static void main(String[] args) {
		System.out.println(new Date(0));
		Date date = DateUtils.parseDate(new Date(0));
		System.out.println(date);
//        DateFormatUtils.format()
	}
}
