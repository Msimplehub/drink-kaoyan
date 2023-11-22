package com.meta.crm.service.app.opLog;

import com.meta.framework.common.utils.StringUtils;
import com.meta.crm.intf.constants.ClueDicTypeConstants;
import com.meta.crm.intf.entity.CrmClue;
import com.meta.crm.domain.aggr.CrmCustomerDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.log.ClueConvertLog;
import com.meta.platform.area.domain.Areas;
import com.meta.platform.area.req.ro.AreasRo;
import com.meta.platform.area.service.AreasQryService;
import com.meta.act.app.service.ISysDictDataService;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

@Component
public class CustomerOpLogContentBuilder {

    @Resource
    private ISysDictDataService sysDictDataService;

    @Resource
    private AreasQryService areasQryService;

    public String buildCreateContent(CrmCustomerDo newDo){
        return "新建了客户";
    }

    public String buildUpdateContent(CrmCustomerDo oldDo, CrmCustomerDo newDo){

        StringBuilder builder = new StringBuilder();

        /*
         * 设置字典信息
         */
        // 查询字典
        Map<String, Map<String, String>> enumMap = sysDictDataService.
                queryDicNamesWithType(Arrays.asList(ClueDicTypeConstants.PROFESSION,
                        ClueDicTypeConstants.CUSTOMER_SOURCE, ClueDicTypeConstants.CUSTOMER_LEVER));

        if (!StringUtils.equals(oldDo.getCustomerName(), newDo.getCustomerName())){
            builder.append(buildSingleUpdateContent(oldDo.getCustomerName(), newDo.getCustomerName(), "名称"));
        }
        if (!StringUtils.equals(oldDo.getCustomerLevel(), newDo.getCustomerLevel())) {
            builder.append(buildSingleUpdateContent(
                    enumMap.get(ClueDicTypeConstants.CUSTOMER_LEVER).get(oldDo.getCustomerLevel()),
                    enumMap.get(ClueDicTypeConstants.CUSTOMER_LEVER).get(newDo.getCustomerLevel()),
                    "级别"));
        }
        if (!StringUtils.equals(oldDo.getAddress(), newDo.getAddress())){
            builder.append(buildSingleUpdateContent(oldDo.getAddress(), newDo.getAddress(), "地址"));
        }
        if (!StringUtils.equals(oldDo.getProfession(), newDo.getProfession())){
            builder.append(buildSingleUpdateContent(
                    enumMap.get(ClueDicTypeConstants.PROFESSION).get(oldDo.getProfession()),
                    enumMap.get(ClueDicTypeConstants.PROFESSION).get(newDo.getProfession()), "行业"));
        }
        if (!StringUtils.equals(oldDo.getCompanyId(), newDo.getCompanyId())){
            builder.append(buildSingleUpdateContent(oldDo.getCompanyId(), newDo.getCompanyId(), "公司标识"));
        }
        if (!StringUtils.equals(oldDo.getRemark(), newDo.getRemark())){
            builder.append(buildSingleUpdateContent(oldDo.getRemark(), newDo.getRemark(), "备注"));
        }
        if (!StringUtils.equals(oldDo.getSource(), newDo.getSource())){
            builder.append(buildSingleUpdateContent(
                    enumMap.get(ClueDicTypeConstants.CUSTOMER_SOURCE).get(oldDo.getSource()),
                    enumMap.get(ClueDicTypeConstants.CUSTOMER_SOURCE).get(newDo.getSource()),
                    "来源"));
        }
        if (!StringUtils.equals(oldDo.getUrl(), newDo.getUrl())){
            builder.append(buildSingleUpdateContent(oldDo.getUrl(), newDo.getUrl(), "网址"));
        }
        if (!StringUtils.equals(getObjStr(oldDo.getEmployeeNo()), getObjStr(newDo.getEmployeeNo()))){
            builder.append(buildSingleUpdateContent(getObjStr(oldDo.getEmployeeNo()), getObjStr(newDo.getEmployeeNo()),
                    "客户数量"));
        }

        if (!StringUtils.equals(getObjStr(oldDo.getProvinceCode()), getObjStr(newDo.getProvinceCode()))
                || !StringUtils.equals(getObjStr(oldDo.getCityCode()), getObjStr(newDo.getCityCode()))
                || !StringUtils.equals(getObjStr(oldDo.getRegionCode()), getObjStr(newDo.getRegionCode()))
        ){
            List<Long> areaIds = Arrays.asList(oldDo.getProvinceCode(), oldDo.getCityCode(), oldDo.getRegionCode(),
                    newDo.getProvinceCode(), newDo.getCityCode(), newDo.getRegionCode()).stream().filter(Objects::nonNull)
                    .collect(Collectors.toList());
            AreasRo areasRo = AreasRo.builder().areaIdList(areaIds).build();
            List<Areas> areas = areasQryService.listAreas(areasRo);
            Map<Long, String> areasNameMap = new HashMap<>();
            for (Areas area : areas) {
                if (area != null){
                    areasNameMap.put(area.getAreaId(), area.getAreaName());
                }
            }

            builder.append(buildSingleUpdateContent(
                    buildAreaStr(oldDo.getProvinceCode(), oldDo.getCityCode(), oldDo.getRegionCode(), areasNameMap),
                    buildAreaStr(newDo.getProvinceCode(), newDo.getCityCode(), newDo.getRegionCode(), areasNameMap),
                    "地区"));
        }

        if (builder.length() == 0){
            builder.append("更新了客户,");
        }

        builder.deleteCharAt(builder.length() - 1);
        return builder.toString();
    }

    public String buildClueTransCustomerContent(CrmCustomerDo newDo, CrmClue crmClue){

        ClueConvertLog log = new ClueConvertLog();
        log.setLog("将销售线索转换为商机，自动创建客户,转换前线索: #targetName#");
        log.setTargetType(TargetType.CLUE.getCode());
        log.setTargetId(crmClue.getId().toString());
        log.setTargetName(crmClue.getInformantName());
        return log.generateLog();
    }

    private String getObjStr(Object value){
        if (value == null){
            return null;
        }
        return value.toString();
    }

    private String buildAreaStr(Long provincCode, Long cityCode, Long regionCode, Map<Long, String> areasNameMap){

        StringBuilder builder = new StringBuilder();
        if (provincCode != null){
            builder.append(areasNameMap.get(provincCode)).append("/");
        }
        if (cityCode != null){
            builder.append(areasNameMap.get(cityCode)).append("/");
        }
        if (regionCode != null){
            builder.append(areasNameMap.get(regionCode));
        }

        return builder.toString();
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
        builder.append("将客户").append(fieldName).append(" 由 ").append(oldStr)
                .append(" 变更为 ").append(newStr).append(",");
        return builder.toString();
    }
}
