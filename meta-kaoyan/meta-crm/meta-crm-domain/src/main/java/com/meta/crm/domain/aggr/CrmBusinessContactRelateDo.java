package com.meta.crm.domain.aggr;

import com.alibaba.fastjson.JSONObject;
import com.meta.framework.common.utils.SecurityUtils;
import com.meta.crm.intf.cmd.business.BusinessChangeContactCmd;
import com.meta.crm.intf.compare.CrmBusinessContactChange;
import com.meta.crm.intf.entity.CrmBusinessContactRelate;
import com.meta.crm.intf.req.ro.CrmContactRo;
import lombok.Data;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Data
public class CrmBusinessContactRelateDo extends CrmBusinessContactRelate {

    public static CrmContactRo createCrmContactRo(List<CrmBusinessContactRelate> crmBusinessContactRelateList) {
        CrmContactRo ro = new CrmContactRo();
        ro.setContactIds(crmBusinessContactRelateList.stream().map(CrmBusinessContactRelate::getContactId).collect(Collectors.toSet()));
        ro.setDelFlag(0);
        return ro;
    }

    public CrmBusinessContactChange updateContactId(CrmBusinessContactRelate toUpdate, BusinessChangeContactCmd req) {
        CrmBusinessContactChange crmBusinessContactChange = new CrmBusinessContactChange();
        if (toUpdate != null) {
            if (!toUpdate.getContactId().equals(req.getContactId())) {
                crmBusinessContactChange = CrmBusinessContactChange.builder().
                        type(toUpdate.getType()).fromContactId(toUpdate.getContactId()).toContactId(req.getContactId()).build();
                toUpdate.setContactId(req.getContactId());
            } else {
                return null;
            }
        } else {
            crmBusinessContactChange = CrmBusinessContactChange.builder().
                    type(req.getType()).fromContactId(null).toContactId(req.getContactId()).build();
        }
        setUpdateBy(SecurityUtils.getUserId());
        return crmBusinessContactChange;
    }

    public CrmContactRo getQueryChangeContactRo(CrmBusinessContactChange crmBusinessContactChange) {
        CrmContactRo result = new CrmContactRo();
        result.setContactIds(new HashSet<>());
        if (crmBusinessContactChange.getFromContactId() != null) {
            result.getContactIds().add(crmBusinessContactChange.getFromContactId());
        }
        if (crmBusinessContactChange.getToContactId() != null) {
            result.getContactIds().add(crmBusinessContactChange.getToContactId());
        }
        return result;
    }

    public String createChangeContactLog(CrmBusinessContactChange crmBusinessContactChange, List<CrmContactDo> crmContactDos) {
        Map<Long, String> contactMap = crmContactDos.stream().collect(Collectors.toMap(CrmContactDo::getId, CrmContactDo::getName));
        JSONObject contentMap = new JSONObject();
        contentMap.put("type", crmBusinessContactChange.getType());
        Long fromContactId = crmBusinessContactChange.getFromContactId();
        if (fromContactId != null) {
            contentMap.put("beforeContact", new JSONObject());
            JSONObject beforeContact = (JSONObject) contentMap.get("beforeContact");
            beforeContact.put("contactId", fromContactId.toString());
            beforeContact.put("contactName", contactMap.getOrDefault(fromContactId, ""));
        }
        Long toContactId = crmBusinessContactChange.getToContactId();
        if (toContactId != null) {
            contentMap.put("afterContact", new JSONObject());
            JSONObject afterContact = (JSONObject) contentMap.get("afterContact");
            afterContact.put("contactId", toContactId.toString());
            afterContact.put("contactName", contactMap.getOrDefault(toContactId, ""));
        }
        return contentMap.toJSONString();
    }
}
