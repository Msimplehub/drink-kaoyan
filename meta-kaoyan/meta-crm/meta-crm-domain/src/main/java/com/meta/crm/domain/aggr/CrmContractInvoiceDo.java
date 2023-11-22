package com.meta.crm.domain.aggr;

import com.alibaba.fastjson.JSON;
import com.meta.crm.intf.cmd.invoice.CrmContractInvoiceCreateCmd;
import com.meta.crm.intf.cmd.invoice.CrmContractInvoiceUpdateCmd;
import com.meta.crm.intf.constants.ClueDicTypeConstants;
import com.meta.crm.intf.entity.CrmFileRelate;
import com.meta.crm.intf.enums.TargetType;
import com.meta.framework.common.utils.SecurityUtils;
import com.meta.framework.common.utils.StringUtils;
import com.meta.framework.util.BeanUtil;
import com.meta.platform.area.domain.Areas;
import com.meta.platform.contract.intf.entity.ContractInvoice;
import com.meta.platform.contract.intf.entity.ContractInvoiceReceiver;
import lombok.Data;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

@Data
public class CrmContractInvoiceDo {
    public static ContractInvoice createContractInvoice(CrmContractInvoiceCreateCmd addContractInvoiceCmd) {
        ContractInvoice result = new ContractInvoice();
        BeanUtil.copyProperties(addContractInvoiceCmd, result);
        result.setInvoiceFileIds(JSON.toJSONString(addContractInvoiceCmd.getFileObjs()));
        result.setCreateBy(SecurityUtils.getUserId());
        return result;
    }

    public static ContractInvoiceReceiver createContractInvoiceReceiver(ContractInvoice invoice, CrmContractInvoiceCreateCmd addContractInvoiceCmd) {
        if (addContractInvoiceCmd.getInvoiceReceiver() == null) {
            return null;
        }
        ContractInvoiceReceiver result = new ContractInvoiceReceiver();
        BeanUtil.copyProperties(addContractInvoiceCmd.getInvoiceReceiver(), result);
        result.setInvoiceId(invoice.getId());
        result.setCustomerId(invoice.getCustomerId());
        return result;
    }

    static String handleNull(String original) {
        return original == null ? "" : original;
    }

    public static String compareInvoiceMainInfo(ContractInvoice contractInvoice, CrmContractInvoiceUpdateCmd crmContractInvoiceUpdateCmd,
                                                Map<String, Map<String, String>> enumMap) {
        if (!contractInvoice.equals(crmContractInvoiceUpdateCmd)) {
            StringBuilder stringBuilder = new StringBuilder();

            if (!Objects.equals(contractInvoice.getInvoiceTitle(), crmContractInvoiceUpdateCmd.getInvoiceTitle())) {
                stringBuilder.append("将发票抬头由 ").append(handleNull(contractInvoice.getInvoiceTitle())).append(" 变更为 ").append(handleNull(crmContractInvoiceUpdateCmd.getInvoiceTitle())).append("<br>");
                contractInvoice.setInvoiceTitle(crmContractInvoiceUpdateCmd.getInvoiceTitle());
            } else {
                contractInvoice.setInvoiceTitle(null);
            }

            Map<String, String> titleType = enumMap.getOrDefault(ClueDicTypeConstants.INVOICE_TITLE_TYPE, Collections.emptyMap());

            if (!Objects.equals(contractInvoice.getTitleType(), crmContractInvoiceUpdateCmd.getTitleType())) {
                stringBuilder.append("将抬头类型由 ").append(titleType.getOrDefault(contractInvoice.getTitleType(), "")).append(" 变更为 ").
                        append(titleType.getOrDefault(crmContractInvoiceUpdateCmd.getTitleType(), "")).append("<br>");
                contractInvoice.setTitleType(crmContractInvoiceUpdateCmd.getTitleType());
            } else {
                contractInvoice.setTitleType(null);
            }

            Map<String, String> createType = enumMap.getOrDefault(ClueDicTypeConstants.INVOICE_CREATE_TYPE, Collections.emptyMap());

            if (!Objects.equals(contractInvoice.getInvoiceCreateType(), crmContractInvoiceUpdateCmd.getInvoiceCreateType())) {
                stringBuilder.append("将开票类型由 ").append(createType.getOrDefault(contractInvoice.getInvoiceCreateType(), "")).append(" 变更为 ").
                        append(createType.getOrDefault(crmContractInvoiceUpdateCmd.getInvoiceCreateType(), "")).append("<br>");
                contractInvoice.setInvoiceCreateType(crmContractInvoiceUpdateCmd.getInvoiceCreateType());
            } else {
                contractInvoice.setInvoiceCreateType(null);
            }

            Map<String, String> invoiceType = enumMap.getOrDefault(ClueDicTypeConstants.INVOICE_TYPE, Collections.emptyMap());

            if (!Objects.equals(contractInvoice.getInvoiceType(), crmContractInvoiceUpdateCmd.getInvoiceType())) {
                stringBuilder.append("将发票类型由 ").append(invoiceType.getOrDefault(contractInvoice.getInvoiceType(), "")).append(" 变更为 ").
                        append(invoiceType.getOrDefault(crmContractInvoiceUpdateCmd.getInvoiceType(), "")).append("<br>");
                contractInvoice.setInvoiceType(crmContractInvoiceUpdateCmd.getInvoiceType());
            } else {
                contractInvoice.setInvoiceType(null);
            }

            if (!Objects.equals(contractInvoice.getCompanyTaxNum(), crmContractInvoiceUpdateCmd.getCompanyTaxNum())) {
                stringBuilder.append("将公司税号由 ").append(handleNull(contractInvoice.getCompanyTaxNum())).append(" 变更为 ").
                        append(handleNull(crmContractInvoiceUpdateCmd.getCompanyTaxNum())).append("<br>");
                contractInvoice.setCompanyTaxNum(crmContractInvoiceUpdateCmd.getCompanyTaxNum());
            } else {
                contractInvoice.setCompanyTaxNum(null);
            }

            if (!Objects.equals(contractInvoice.getInvoiceTaxRate(), crmContractInvoiceUpdateCmd.getInvoiceTaxRate())) {
                stringBuilder.append("将开票税率由 ").append(handleNull(contractInvoice.getInvoiceTaxRate())).append(" 变更为 ").
                        append(handleNull(crmContractInvoiceUpdateCmd.getInvoiceTaxRate())).append("<br>");
                contractInvoice.setInvoiceTaxRate(crmContractInvoiceUpdateCmd.getInvoiceTaxRate());
            } else {
                contractInvoice.setInvoiceTaxRate(null);
            }

            if (contractInvoice.getInvoiceAmount().compareTo(crmContractInvoiceUpdateCmd.getInvoiceAmount()) != 0) {
                stringBuilder.append("将开票金额由 ").append(contractInvoice.getInvoiceAmount()).append(" 变更为 ").
                        append(crmContractInvoiceUpdateCmd.getInvoiceAmount()).append("<br>");
                contractInvoice.setInvoiceAmount(crmContractInvoiceUpdateCmd.getInvoiceAmount());
            } else {
                contractInvoice.setInvoiceAmount(null);
            }

            if (!Objects.equals(contractInvoice.getInvoiceDate(), crmContractInvoiceUpdateCmd.getInvoiceDate())) {
                stringBuilder.append("将开票时间由 ").append(handleDate(contractInvoice.getInvoiceDate())).append(" 变更为 ").
                        append(handleDate(crmContractInvoiceUpdateCmd.getInvoiceDate())).append("<br>");
                contractInvoice.setInvoiceDate(crmContractInvoiceUpdateCmd.getInvoiceDate());
            } else {
                contractInvoice.setInvoiceDate(null);
            }

            if (!Objects.equals(contractInvoice.getInvoiceNum(), crmContractInvoiceUpdateCmd.getInvoiceNum())) {
                stringBuilder.append("将发票编号由 ").append(handleNull(contractInvoice.getInvoiceNum())).append(" 变更为 ").
                        append(handleNull(crmContractInvoiceUpdateCmd.getInvoiceNum())).append("<br>");
                contractInvoice.setInvoiceNum(crmContractInvoiceUpdateCmd.getInvoiceNum());
            } else {
                contractInvoice.setInvoiceNum(null);
            }

            if (!Objects.equals(contractInvoice.getRemark(), crmContractInvoiceUpdateCmd.getRemark())) {
                stringBuilder.append("将备注由 ").append(handleNull(contractInvoice.getRemark())).append(" 变更为 ").
                        append(handleNull(crmContractInvoiceUpdateCmd.getRemark())).append("<br>");
                contractInvoice.setRemark(crmContractInvoiceUpdateCmd.getRemark());
            } else {
                contractInvoice.setRemark(null);
            }

            String newFileIds = JSON.toJSONString(crmContractInvoiceUpdateCmd.getFileObjs());
            if (!Objects.equals(contractInvoice.getInvoiceFileIds(), newFileIds)) {
//                stringBuilder.append("将附件由 ").append(handleNull(contractInvoice.getInvoiceFileIds())).append(" 变更为 ").
//                        append(handleNull(newFileIds)).append("<br>");
                stringBuilder.append("更新了发票文件<br>");
                contractInvoice.setInvoiceFileIds(newFileIds);
            } else {
                contractInvoice.setInvoiceFileIds(null);
            }
            contractInvoice.setUpdateBy(SecurityUtils.getUserId());

            return stringBuilder.toString();
        }
        return "";
    }

    static String handleDate(Date date) {
        if (date == null) {
            return "";
        }
        try {
            return DateFormatUtils.format(date, "yyyy-MM-dd");
        } catch (Exception e) {

        }
        return "";
    }

    public static String compareInvoiceReceiverInfo(List<ContractInvoiceReceiver> contractInvoiceReceivers, CrmContractInvoiceUpdateCmd crmContractInvoiceUpdateCmd, List<Areas> areas) {
        StringBuilder stringBuilder = new StringBuilder();
        Map<Long, String> areaMap = areas.stream().collect(Collectors.toMap(Areas::getAreaId, Areas::getAreaName));
        ContractInvoiceReceiver updateReceiver = crmContractInvoiceUpdateCmd.getInvoiceReceiver();
        if (CollectionUtils.isEmpty(contractInvoiceReceivers) && updateReceiver != null) {
            if (!StringUtils.isEmpty(updateReceiver.getReceiverName())) {
                stringBuilder.append("将收票人由 修改为").append(updateReceiver.getReceiverName()).append("<br>");
            }
            if (!StringUtils.isEmpty(updateReceiver.getReceiverMobile())) {
                stringBuilder.append("将收票人手机由 修改为").append(updateReceiver.getReceiverMobile()).append("<br>");
            }
            if (updateReceiver.getReceiverProvince() != null) {
                stringBuilder.append("将收票人省份由 修改为").append(areaMap.getOrDefault(updateReceiver.getReceiverProvince(), "")).append("<br>");
            }
            if (updateReceiver.getReceiverCity() != null) {
                stringBuilder.append("将收票人市区由 修改为").append(areaMap.getOrDefault(updateReceiver.getReceiverCity(), "")).append("<br>");
            }
            if (updateReceiver.getReceiverDistrict() != null) {
                stringBuilder.append("将收票人区由 修改为").append(areaMap.getOrDefault(updateReceiver.getReceiverDistrict(), "")).append("<br>");
            }
            if (!StringUtils.isEmpty(updateReceiver.getReceiverDetailAddress())) {
                stringBuilder.append("将收票人详细地址由 修改为").append(updateReceiver.getReceiverDetailAddress()).append("<br>");
            }
            if (!StringUtils.isEmpty(updateReceiver.getReceiverPostCode())) {
                stringBuilder.append("将收票人邮编由 修改为").append(updateReceiver.getReceiverPostCode()).append("<br>");
            }
            if (!StringUtils.isEmpty(updateReceiver.getReceiverEmail())) {
                stringBuilder.append("将收票人邮箱由 修改为").append(updateReceiver.getReceiverEmail()).append("<br>");
            }
            contractInvoiceReceivers = new ArrayList<>();
            ContractInvoiceReceiver insert = new ContractInvoiceReceiver();
            BeanUtil.copyProperties(updateReceiver, insert);
            insert.setInvoiceId(crmContractInvoiceUpdateCmd.getId());
            insert.setCustomerId(crmContractInvoiceUpdateCmd.getCustomerId());
            insert.setCreateBy(SecurityUtils.getUserId());
            contractInvoiceReceivers.add(insert);
        }

        if (!CollectionUtils.isEmpty(contractInvoiceReceivers) && contractInvoiceReceivers.get(0) != null && updateReceiver != null) {
            ContractInvoiceReceiver receiver = contractInvoiceReceivers.get(0);
            if (!Objects.equals(receiver.getReceiverName(), updateReceiver.getReceiverName())) {
                stringBuilder.append("将收票人由 ").append(handleNull(receiver.getReceiverName())).append("修改为")
                        .append(handleNull(updateReceiver.getReceiverName())).append("<br>");
                receiver.setReceiverName(updateReceiver.getReceiverName());
            } else {
                receiver.setReceiverName(null);
            }

            if (!Objects.equals(receiver.getReceiverMobile(), updateReceiver.getReceiverMobile())) {
                stringBuilder.append("将收票人手机由 ").append(handleNull(receiver.getReceiverMobile())).append("修改为")
                        .append(handleNull(updateReceiver.getReceiverMobile())).append("<br>");
                receiver.setReceiverMobile(updateReceiver.getReceiverMobile());
            } else {
                receiver.setReceiverMobile(null);
            }

            if (!Objects.equals(receiver.getReceiverProvince(), updateReceiver.getReceiverProvince())) {
                stringBuilder.append("将收票人省份由 ").append(areaMap.getOrDefault(receiver.getReceiverProvince(), "")).append("修改为")
                        .append(areaMap.getOrDefault(updateReceiver.getReceiverProvince(), "")).append("<br>");
                receiver.setReceiverProvince(updateReceiver.getReceiverProvince());
            } else {
                receiver.setReceiverProvince(null);
            }

            if (!Objects.equals(receiver.getReceiverCity(), updateReceiver.getReceiverCity())) {
                stringBuilder.append("将收票人市区由 ").append(areaMap.getOrDefault(receiver.getReceiverCity(), "")).append("修改为")
                        .append(areaMap.getOrDefault(updateReceiver.getReceiverCity(), "")).append("<br>");
                receiver.setReceiverCity(updateReceiver.getReceiverCity());
            } else {
                receiver.setReceiverCity(null);
            }

            if (!Objects.equals(receiver.getReceiverDistrict(), updateReceiver.getReceiverDistrict())) {
                stringBuilder.append("将收票人区由 ").append(areaMap.getOrDefault(receiver.getReceiverDistrict(), "")).append("修改为")
                        .append(areaMap.getOrDefault(updateReceiver.getReceiverDistrict(), "")).append("<br>");
                receiver.setReceiverDistrict(updateReceiver.getReceiverDistrict());
            } else {
                receiver.setReceiverDistrict(null);
            }

            if (!Objects.equals(receiver.getReceiverDetailAddress(), updateReceiver.getReceiverDetailAddress())) {
                stringBuilder.append("将收票人详细地址由 ").append(handleNull(receiver.getReceiverDetailAddress())).append("修改为")
                        .append(handleNull(updateReceiver.getReceiverDetailAddress())).append("<br>");
                receiver.setReceiverDetailAddress(updateReceiver.getReceiverDetailAddress());
            } else {
                receiver.setReceiverDetailAddress(null);
            }

            if (!Objects.equals(receiver.getReceiverPostCode(), updateReceiver.getReceiverPostCode())) {
                stringBuilder.append("将收票人邮编由 ").append(handleNull(receiver.getReceiverPostCode())).append("修改为")
                        .append(handleNull(updateReceiver.getReceiverPostCode())).append("<br>");
                receiver.setReceiverPostCode(updateReceiver.getReceiverPostCode());
            } else {
                receiver.setReceiverPostCode(null);
            }

            if (!Objects.equals(receiver.getReceiverEmail(), updateReceiver.getReceiverEmail())) {
                stringBuilder.append("将收票人邮箱由 ").append(handleNull(receiver.getReceiverEmail())).append("修改为")
                        .append(handleNull(updateReceiver.getReceiverEmail())).append("<br>");
                receiver.setReceiverEmail(updateReceiver.getReceiverEmail());
            } else {
                receiver.setReceiverEmail(null);
            }
            receiver.setUpdateBy(SecurityUtils.getUserId());
        }

        return stringBuilder.toString();
    }

    public static Set<Long> getAllAreaCodes(List<ContractInvoiceReceiver> contractInvoiceReceivers, CrmContractInvoiceUpdateCmd crmContractInvoiceUpdateCmd) {
        Set<Long> result = new HashSet<>();
        if (!CollectionUtils.isEmpty(contractInvoiceReceivers) && contractInvoiceReceivers.get(0) != null) {
            ContractInvoiceReceiver receiver = contractInvoiceReceivers.get(0);
            getSingleReceiverAreaCode(result, receiver);
        }
        ContractInvoiceReceiver invoiceReceiver = crmContractInvoiceUpdateCmd.getInvoiceReceiver();

        getSingleReceiverAreaCode(result, invoiceReceiver);
        return result;
    }

    private static void getSingleReceiverAreaCode(Set<Long> result, ContractInvoiceReceiver invoiceReceiver) {
        if (invoiceReceiver == null) {
            return;
        }
        if (invoiceReceiver.getReceiverProvince() != null) {
            result.add(invoiceReceiver.getReceiverProvince());
        }
        if (invoiceReceiver.getReceiverCity() != null) {
            result.add(invoiceReceiver.getReceiverCity());
        }
        if (invoiceReceiver.getReceiverDistrict() != null) {
            result.add(invoiceReceiver.getReceiverDistrict());
        }
    }

    public static CrmFileRelate createFileRelateFromAddCmd(ContractInvoice invoice, CrmContractInvoiceCreateCmd addContractInvoiceCmd) {
        CrmFileRelate result = new CrmFileRelate();
        result.setTargetType(TargetType.CONTRACT_INVOICE.getCode());
        result.setTargetId(invoice.getId());
        result.setFileIds(JSON.toJSONString(addContractInvoiceCmd.getFileObjs()));
        result.setCreateBy(SecurityUtils.getUserId());
        return result;
    }

    public static CrmFileRelate createFileRelateFromUpdateCmd(CrmContractInvoiceUpdateCmd updateCmd) {
        CrmFileRelate result = new CrmFileRelate();
        result.setTargetType(TargetType.CONTRACT_INVOICE.getCode());
        result.setTargetId(updateCmd.getId());
        result.setFileIds(JSON.toJSONString(updateCmd.getFileObjs()));
        result.setCreateBy(SecurityUtils.getUserId());
        return result;
    }
}
