package com.meta.crm.service.app.opLog;

import com.meta.crm.domain.aggr.CrmAssignUserDo;
import com.meta.crm.intf.enums.TargetType;
import org.springframework.stereotype.Component;

@Component
public class AssignOpLogContentBuilder {

    public String buildUpdateContent(CrmAssignUserDo oldDo, CrmAssignUserDo newDo){

        String model = "将%s负责人，由%s 分配给 %s";

        model = String.format(model, TargetType.getDescByCode(oldDo.getTargetType()),oldDo.getManagerName(),
                newDo.getManagerName());

        return model;
    }

    public String buildCreateContent(CrmAssignUserDo newDo){

        String model = "将%s 分配给 %s";

        model = String.format(model, TargetType.getDescByCode(newDo.getTargetType()),
                newDo.getManagerName());

        return model;
    }
}
