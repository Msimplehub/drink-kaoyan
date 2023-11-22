package com.meta.crm.service.app.opLog;

import com.meta.crm.domain.aggr.CrmContractPlanFundDo;
import com.meta.framework.common.utils.DateUtils;
import com.meta.framework.common.utils.StringUtils;
import org.springframework.stereotype.Component;

@Component
public class ContractPlanFundOpLogContentBuilder {

    public String buildUpdateContent(CrmContractPlanFundDo oldDo, CrmContractPlanFundDo newDo){

        StringBuilder builder = new StringBuilder();

        // 计划回款金额
        if (oldDo.getPlanFundAmount().compareTo(newDo.getPlanFundAmount()) != 0){
            builder.append(buildSingleUpdateContent(
                    oldDo.getPlanFundAmount().toString(),
                    newDo.getPlanFundAmount().toString(),
                    "计划回款"));
        }

        // 回款时间
        if (oldDo.getPlanFundDate() == null) {
            if (newDo.getPlanFundDate() != null){
                builder.append(buildSingleUpdateContent(
                        null,
                        DateUtils.dateTime(newDo.getPlanFundDate()),
                        "计划回款时间"));
            }
        }
        else if (newDo.getPlanFundDate() == null){
            builder.append(buildSingleUpdateContent(
                    DateUtils.dateTime(oldDo.getPlanFundDate()),
                    null,
                    "计划回款时间"));
        }
        else if (oldDo.getPlanFundDate().getTime() != newDo.getPlanFundDate().getTime()){
            builder.append(buildSingleUpdateContent(
                    DateUtils.dateTime(oldDo.getPlanFundDate()),
                    DateUtils.dateTime(newDo.getPlanFundDate()),
                    "计划回款时间"));
        }


        if (builder.length() == 0){
            builder.append("更新了计划,");
        }

        builder.deleteCharAt(builder.length() - 1);
        return builder.toString();
    }

    public String buildCreateContent(CrmContractPlanFundDo newDo){

        return "新建了回款计划";
    }

    private String buildSingleUpdateContent(String oldStr, String newStr, String fieldName){

        if (StringUtils.isEmpty(oldStr)){
            if (StringUtils.isEmpty(newStr)){
                return "";
            }
            oldStr = "";
        }
        if (StringUtils.isEmpty(newStr)){
            newStr = "";
        }

        StringBuilder builder = new StringBuilder();
        builder.append("将").append(fieldName).append(" 由 ").append(oldStr)
                .append(" 变更为 ").append(newStr).append(",");
        return builder.toString();
    }
}
