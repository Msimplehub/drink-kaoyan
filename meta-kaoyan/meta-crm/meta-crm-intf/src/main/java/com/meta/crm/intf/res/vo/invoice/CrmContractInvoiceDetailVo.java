package com.meta.crm.intf.res.vo.invoice;

import com.meta.platform.contract.intf.entity.ContractInvoice;
import com.meta.platform.file.model.FileInfo;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

@Data
@ApiModel("发票详情返回")
public class CrmContractInvoiceDetailVo extends ContractInvoice {

    @ApiModelProperty("客户姓名")
    private String customerName;

    @ApiModelProperty("合同名称")
    private String contractName;

    @ApiModelProperty("抬头类型描述")
    private String titleTypeDesc;

    @ApiModelProperty("开票类型描述")
    private String invoiceCreateTypeDesc;

    @ApiModelProperty("发票类型描述")
    private String invoiceTypeDesc;

    @ApiModelProperty("文件地址")
    private List<FileInfo> fileUrls;

    @ApiModelProperty("创建人姓名")
    private String createUserName;

    @ApiModelProperty("邮寄信息")
    private ContractInvoiceReceiverVo invoiceReceiver;
}
