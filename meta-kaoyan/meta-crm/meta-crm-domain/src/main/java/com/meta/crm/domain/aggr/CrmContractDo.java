package com.meta.crm.domain.aggr;

import com.alibaba.fastjson.JSON;
import com.meta.crm.intf.cmd.contract.CrmContractSaveCmd;
import com.meta.crm.intf.cmd.contract.CrmContractUpdateCmd;
import com.meta.crm.intf.compare.CrmContractBusinessChange;
import com.meta.crm.intf.constants.ClueDicTypeConstants;
import com.meta.crm.intf.entity.CrmBusiness;
import com.meta.crm.intf.entity.CrmContractRelate;
import com.meta.crm.intf.entity.CrmFileRelate;
import com.meta.crm.intf.enums.AssignFollowerType;
import com.meta.crm.intf.enums.AssignRole;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.contract.CrmContractListQry;
import com.meta.crm.intf.req.ro.CrmContractRelateRo;
import com.meta.crm.intf.req.ro.CrmContractRo;
import com.meta.framework.common.utils.DateUtils;
import com.meta.framework.common.utils.SecurityUtils;
import com.meta.framework.common.utils.StringUtils;
import com.meta.framework.util.BeanUtil;
import com.meta.platform.contract.intf.entity.Contract;
import com.meta.platform.contract.intf.ro.ContractRo;
import lombok.Data;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.util.CollectionUtils;

import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

@Data
public class CrmContractDo {
    public static Contract createContractFromSaveCmd(CrmContractSaveCmd addContactCmd) {
        Contract result = new Contract();
        BeanUtil.copyProperties(addContactCmd, result);
        result.setCreateBy(SecurityUtils.getUserId());
        result.setContractFileIds(JSON.toJSONString(addContactCmd.getFileObjs()));
        return result;
    }

    public static ContractRo createContractRoFromUpdateCmd(CrmContractUpdateCmd crmContractUpdateCmd) {
        ContractRo result = new ContractRo();
        result.setId(crmContractUpdateCmd.getId());
        return result;
    }

    static String handleNull(String original) {
        return original == null ? "" : original;
    }

    public static String compareContractWithUpdateCmd(Contract contract, CrmContractUpdateCmd crmContractUpdateCmd,
                                                      Map<String, Map<String, String>> enumMap, List<CrmContactDo> crmContactDos, Map<Long, String> userNameMap) {
        StringBuilder stringBuilder = new StringBuilder();
        Map<Long, String> contactNameMap = crmContactDos.stream().collect(Collectors.toMap(CrmContactDo::getId, CrmContactDo::getName));
        if (!contract.equals(crmContractUpdateCmd)) {
            if (!StringUtils.equals(contract.getContractName(), crmContractUpdateCmd.getContractName())) {
                stringBuilder.append("将合同名称由 ").append(handleNull(contract.getContractName())).append(" 变更为 ").append(handleNull(crmContractUpdateCmd.getContractName())).append("<br>");
                contract.setContractName(crmContractUpdateCmd.getContractName());
            } else {
                contract.setContractName(null);
            }

            if (!StringUtils.equals(contract.getContractType(), crmContractUpdateCmd.getContractType())) {
                Map<String, String> typeMap = enumMap.getOrDefault(ClueDicTypeConstants.CONTRACT_TYPE, new HashMap<>());
                stringBuilder.append("将合同类型由 ").append(typeMap.getOrDefault(contract.getContractType(), "")).append(" 变更为 ").
                        append(typeMap.getOrDefault(crmContractUpdateCmd.getContractType(), "")).append("<br>");
                contract.setContractType(crmContractUpdateCmd.getContractType());
            } else {
                contract.setContractType(null);
            }

            if (!StringUtils.equals(contract.getContractStatus(), crmContractUpdateCmd.getContractStatus())) {
                Map<String, String> statusMap = enumMap.getOrDefault(ClueDicTypeConstants.CONTRACT_STATUS, new HashMap<>());
                stringBuilder.append("将合同状态由 ").append(statusMap.getOrDefault(contract.getContractStatus(), "")).append(" 变更为 ").
                        append(statusMap.getOrDefault(crmContractUpdateCmd.getContractStatus(), "")).append("<br>");
                contract.setContractStatus(crmContractUpdateCmd.getContractStatus());
            } else {
                contract.setContractStatus(null);
            }

            if (contract.getContractAmount().compareTo(crmContractUpdateCmd.getContractAmount()) != 0) {
                stringBuilder.append("将合同金额由 ").append(contract.getContractAmount()).append(" 变更为 ").
                        append(crmContractUpdateCmd.getContractAmount()).append("<br>");
                contract.setContractAmount(crmContractUpdateCmd.getContractAmount());
            } else {
                contract.setContractAmount(null);
            }

//            if (!StringUtils.equals(contract.getContractPayType(), crmContractUpdateCmd.getContractPayType())) {
//                Map<String, String> payTypeMap = enumMap.getOrDefault(ClueDicTypeConstants.PAY_TYPE, new HashMap<>());
//                stringBuilder.append("将合同支付方式由 ").append(payTypeMap.getOrDefault(contract.getContractPayType(), "")).append(" 变更为 ").
//                        append(payTypeMap.getOrDefault(crmContractUpdateCmd.getContractPayType(), "")).append("<br>");
//                contract.setContractPayType(crmContractUpdateCmd.getContractPayType());
//            } else {
//                contract.setContractPayType(null);
//            }

            if (!Objects.equals(contract.getContractStartDate(), crmContractUpdateCmd.getContractStartDate())) {
                stringBuilder.append("将合同开始日期由 ").append(handleDate(contract.getContractStartDate())).append(" 变更为 ").
                        append(handleDate(crmContractUpdateCmd.getContractStartDate())).append("<br>");
            }
            contract.setContractStartDate(crmContractUpdateCmd.getContractStartDate());

            if (!Objects.equals(contract.getContractEndDate(), crmContractUpdateCmd.getContractEndDate())) {
                stringBuilder.append("将合同结束日期由 ").append(handleDate(contract.getContractEndDate())).append(" 变更为 ").
                        append(handleDate(crmContractUpdateCmd.getContractEndDate())).append("<br>");
            }
            contract.setContractEndDate(crmContractUpdateCmd.getContractEndDate());

            if (!Objects.equals(contract.getContractNum(), crmContractUpdateCmd.getContractNum())) {
                stringBuilder.append("将合同编号由 ").append(handleNull(contract.getContractNum())).append(" 变更为 ").
                        append(handleNull(crmContractUpdateCmd.getContractNum())).append("<br>");
                contract.setContractNum(crmContractUpdateCmd.getContractNum());
            } else {
                contract.setContractNum(null);
            }

            if (!Objects.equals(contract.getCustomerSignContactId(), crmContractUpdateCmd.getCustomerSignContactId())) {
                stringBuilder.append("将合同客户方签约人由 ").append(contactNameMap.getOrDefault(contract.getCustomerSignContactId(), "")).append(" 变更为 ").
                        append(contactNameMap.getOrDefault(crmContractUpdateCmd.getCustomerSignContactId(), "")).append("<br>");
            }
            contract.setCustomerSignContactId(crmContractUpdateCmd.getCustomerSignContactId());

            if (!Objects.equals(contract.getOurSideSignUserId(), crmContractUpdateCmd.getOurSideSignUserId())) {
                stringBuilder.append("将合同本方签约人由 ").append(userNameMap.getOrDefault(contract.getOurSideSignUserId(), "")).append(" 变更为 ").
                        append(userNameMap.getOrDefault(crmContractUpdateCmd.getOurSideSignUserId(), "")).append("<br>");
            }
            contract.setOurSideSignUserId(crmContractUpdateCmd.getOurSideSignUserId());

            if (!Objects.equals(contract.getContractSignDate(), crmContractUpdateCmd.getContractSignDate())) {
                stringBuilder.append("将合同签约日期由 ").append(handleDate(contract.getContractSignDate())).append(" 变更为 ").
                        append(handleDate(crmContractUpdateCmd.getContractSignDate())).append("<br>");
            }
            contract.setContractSignDate(crmContractUpdateCmd.getContractSignDate());

            String newFileIds = JSON.toJSONString(crmContractUpdateCmd.getFileObjs());
            //TODO 后续格式
            if (!StringUtils.equals(contract.getContractFileIds(), newFileIds)) {
//                stringBuilder.append("将合同文件由 ").append(handleNull(contract.getContractFileIds())).append(" 变更为 ").
//                        append(handleNull(newFileIds)).append("<br>");
                stringBuilder.append("更新了合同文件<br>");
                contract.setContractFileIds(newFileIds);
            } else {
                contract.setContractFileIds(null);
            }

            if (!Objects.equals(contract.getRemark(), crmContractUpdateCmd.getRemark())) {
                stringBuilder.append("将合同备注由 ").append(handleNull(contract.getRemark())).append(" 变更为 ").
                        append(handleNull(crmContractUpdateCmd.getRemark())).append("<br>");
                contract.setRemark(crmContractUpdateCmd.getRemark());
            } else {
                contract.setRemark(null);
            }
            contract.setUpdateBy(SecurityUtils.getUserId());
        }
        return stringBuilder.toString();
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

    public static CrmAssignUserDo createCrmAssignForSaveCmd(Long id, Long assignUserId) {
        CrmAssignUserDo assign = new CrmAssignUserDo();
        assign.setTargetType(TargetType.CONTRACT.getCode());
        assign.setTargetId(id);
        assign.setAssignRole(AssignRole.MAIN.getCode());

        assign.setManagerId(assignUserId);
        assign.setManagerType(AssignFollowerType.PERSON.getCode());
        return assign;
    }

    public static Set<Long> getContactIdsForUpdate(Contract contract, CrmContractUpdateCmd crmContractUpdateCmd) {
        Set<Long> result = new HashSet<>();
        if (contract.getCustomerSignContactId() == null && crmContractUpdateCmd.getCustomerSignContactId() != null) {
            result.add(crmContractUpdateCmd.getCustomerSignContactId());
        }
        if (contract.getCustomerSignContactId() != null && crmContractUpdateCmd.getCustomerSignContactId() == null) {
            result.add(contract.getCustomerSignContactId());
        }
        if (contract.getCustomerSignContactId() != null && crmContractUpdateCmd.getCustomerSignContactId() != null
                && !contract.getCustomerSignContactId().equals(crmContractUpdateCmd.getCustomerSignContactId())) {
            result.add(contract.getCustomerSignContactId());
            result.add(crmContractUpdateCmd.getCustomerSignContactId());
        }
        return result;
    }

    public static Set<Long> getUserIdsForUpdate(Contract contract, CrmContractUpdateCmd crmContractUpdateCmd) {
        Set<Long> result = new HashSet<>();
        if (contract.getOurSideSignUserId() == null && crmContractUpdateCmd.getOurSideSignUserId() != null) {
            result.add(crmContractUpdateCmd.getOurSideSignUserId());
        }
        if (contract.getOurSideSignUserId() != null && crmContractUpdateCmd.getOurSideSignUserId() == null) {
            result.add(contract.getOurSideSignUserId());
        }
        if (contract.getOurSideSignUserId() != null && crmContractUpdateCmd.getOurSideSignUserId() != null
                && !contract.getOurSideSignUserId().equals(crmContractUpdateCmd.getOurSideSignUserId())) {
            result.add(contract.getOurSideSignUserId());
            result.add(crmContractUpdateCmd.getOurSideSignUserId());
        }
        return result;
    }

    public static CrmContractRelate createContractRelate(Long contractId, Long businessId) {
        CrmContractRelate result = new CrmContractRelate();
        result.setContractId(contractId);
        result.setTargetType(TargetType.BUSINESS.getCode());
        result.setTargetId(businessId);
        result.setCreateBy(SecurityUtils.getUserId());
        return result;
    }

    public static CrmContractRelateRo createContractRelateRo(Long contractId) {
        CrmContractRelateRo result = new CrmContractRelateRo();
        result.setContractId(contractId);
        result.setTargetType(TargetType.BUSINESS.getCode());
        return result;
    }

    public static CrmContractBusinessChange compareRelateBusiness(List<CrmContractRelate> crmContractRelates, CrmContractUpdateCmd updateCmd) {
        CrmContractBusinessChange result = new CrmContractBusinessChange();
        Long contractId = updateCmd.getId();
        Long businessId = updateCmd.getBusinessId();
        if (CollectionUtils.isEmpty(crmContractRelates) && businessId != null) {
            result.setToBusinessId(businessId);
            CrmContractRelate newRelate = new CrmContractRelate();
            newRelate.setContractId(contractId);
            newRelate.setTargetType(TargetType.BUSINESS.getCode());
            newRelate.setTargetId(businessId);
            newRelate.setCreateBy(SecurityUtils.getUserId());
            crmContractRelates.add(newRelate);
        }
        if (!CollectionUtils.isEmpty(crmContractRelates) && crmContractRelates.get(0) != null &&
                !Objects.equals(crmContractRelates.get(0).getTargetId(), businessId)) {
            result.setFromBusinessId(crmContractRelates.get(0).getTargetId());
            result.setToBusinessId(businessId);
            crmContractRelates.get(0).setTargetId(businessId);
        }
        if (CollectionUtils.isEmpty(crmContractRelates) && businessId == null) {
            result = null;
        }
        return result;
    }

    public static String createRelateBusinessChangeLog(CrmContractBusinessChange crmContractBusinessChange, List<CrmBusiness> crmBusinesses) {
        Map<Long, String> nameMap = crmBusinesses.stream().collect(Collectors.toMap(CrmBusiness::getId, CrmBusiness::getBusinessName));
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("将合同关联商机由 ").append(nameMap.getOrDefault(crmContractBusinessChange.getFromBusinessId(), "")).append(" 变更为 ").
                append(nameMap.getOrDefault(crmContractBusinessChange.getToBusinessId(), "")).append("<br>");
        return stringBuilder.toString();
    }

    public static CrmContractRo createQueryContractRo(CrmContractListQry crmContractListQry) {
        CrmContractRo result = new CrmContractRo();
        BeanUtil.copyProperties(crmContractListQry, result);
        if (crmContractListQry.getCreateTimeEnd() != null) {
            // 到次日凌晨
            result.setCreateTimeEnd(DateUtils.addSeconds(crmContractListQry.getCreateTimeEnd(), 86399));
        }

        if (crmContractListQry.getSignTimeEnd() != null) {
            // 到次日凌晨
            result.setSignTimeEnd(DateUtils.addSeconds(crmContractListQry.getSignTimeEnd(), 86399));
        }
        return result;
    }

    public static CrmFileRelate createFileRelateFromSaveCmd(Contract contract, CrmContractSaveCmd addContractCmd) {
        CrmFileRelate result = new CrmFileRelate();
        result.setTargetType(TargetType.CONTRACT.getCode());
        result.setTargetId(contract.getId());
        result.setFileIds(JSON.toJSONString(addContractCmd.getFileObjs()));
        result.setCreateBy(SecurityUtils.getUserId());
        return result;
    }

    public static CrmFileRelate createFileRelateFromUpdateCmd(CrmContractUpdateCmd crmContractUpdateCmd) {
        CrmFileRelate result = new CrmFileRelate();
        result.setTargetType(TargetType.CONTRACT.getCode());
        result.setTargetId(crmContractUpdateCmd.getId());
        result.setFileIds(JSON.toJSONString(crmContractUpdateCmd.getFileObjs()));
        result.setCreateBy(SecurityUtils.getUserId());
        return result;
    }
}
