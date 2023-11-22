package com.meta.crm.service.app.opLog;

import com.meta.framework.common.utils.DateUtils;
import com.meta.framework.common.utils.StringUtils;
import com.meta.crm.intf.constants.ClueDicTypeConstants;
import com.meta.crm.intf.entity.CrmClue;
import com.meta.crm.domain.aggr.CrmContactDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.log.ClueConvertLog;
import com.meta.act.app.service.ISysDictDataService;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.Date;
import java.util.Map;

@Component
public class ContactOpLogContentBuilder {

    @Resource
    private ISysDictDataService sysDictDataService;

    public String buildCreateContent(CrmContactDo newDo){

        return "新建了联系人";
    }

    public String buildUpdateContent(CrmContactDo oldDo, CrmContactDo newDo){

        /*
         * 设置字典信息
         */
        // 查询字典
        Map<String, Map<String, String>> enumMap = sysDictDataService.
                queryDicNamesWithType(Arrays.asList(ClueDicTypeConstants.SEX));

        StringBuilder builder = new StringBuilder();

        if (!oldDo.getName().equals(newDo.getName())){
            builder.append(buildSingleUpdateContent(oldDo.getName(), newDo.getName(), "姓名",","));
        }
        if (!StringUtils.equals(oldDo.getApartment(), newDo.getApartment())){
            builder.append(buildSingleUpdateContent(oldDo.getApartment(), newDo.getApartment(), "部门",","));
        }
        if (!StringUtils.equals(oldDo.getEmail(), newDo.getEmail())){
            builder.append(buildSingleUpdateContent(oldDo.getEmail(), newDo.getEmail(), "邮箱",","));
        }
        if (!StringUtils.equals(oldDo.getPosition(), newDo.getPosition())){
            builder.append(buildSingleUpdateContent(oldDo.getPosition(), newDo.getPosition(), "职务",","));
        }
        if (!StringUtils.equals(oldDo.getMobile(), newDo.getMobile())){
            builder.append(buildSingleUpdateContent(oldDo.getMobile(), newDo.getMobile(), "手机号",","));
        }
        if (!StringUtils.equals(oldDo.getSex(), newDo.getSex())){
            builder.append(buildSingleUpdateContent(
                    enumMap.get(ClueDicTypeConstants.SEX).get(oldDo.getSex()),
                    enumMap.get(ClueDicTypeConstants.SEX).get(newDo.getSex()),
                    "性别",","));
        }
        if (!StringUtils.equals(oldDo.getWechat(), newDo.getWechat())){
            builder.append(buildSingleUpdateContent(oldDo.getWechat(), newDo.getWechat(), "微信",","));
        }
        if (!StringUtils.equals(getBirthdayStr(oldDo.getBirthday()), getBirthdayStr(newDo.getBirthday()))){
            builder.append(buildSingleUpdateContent(getBirthdayStr(oldDo.getBirthday()),
                    getBirthdayStr(newDo.getBirthday()), "生日",","));
        }
        if (!StringUtils.equals(getIntStr(oldDo.getStandScore()), getIntStr(newDo.getStandScore()))){
            builder.append(buildSingleUpdateContent(getIntStr(oldDo.getStandScore())
                    , getIntStr(newDo.getStandScore()), "立场分",","));
        }
        if (!StringUtils.equals(oldDo.getRemark(), newDo.getRemark())){
            builder.append(buildSingleUpdateContent(oldDo.getRemark(), newDo.getRemark(), "备注",","));
        }

        if (builder.length() == 0) {
            builder.append("更新了联系人,");
        }

        builder.deleteCharAt(builder.length() - 1);
        return builder.toString();
    }

    public String buildClueTransCustomerContent(CrmContactDo oldDo, CrmClue crmClue){
        ClueConvertLog log = new ClueConvertLog();
        log.setLog("将销售线索转换为商机，自动创建联系人,转换前线索: #targetName#");
        log.setTargetType(TargetType.CLUE.getCode());
        log.setTargetId(crmClue.getId().toString());
        log.setTargetName(crmClue.getInformantName());
        return log.generateLog();
    }

    private static String getBirthdayStr(Date birthday){
        if (birthday == null){
            return null;
        }
        return DateUtils.dateTime(birthday);
    }

    private static String getIntStr(Integer value){
        if (value == null){
            return null;
        }
        return value.toString();
    }

    private static String buildSingleUpdateContent(String oldStr, String newStr, String fieldName, String suffix){

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
        builder.append("将联系人").append(fieldName).append(" 由 ").append(oldStr)
                .append(" 变更为 ").append(newStr).append(suffix);
        return builder.toString();
    }
}
