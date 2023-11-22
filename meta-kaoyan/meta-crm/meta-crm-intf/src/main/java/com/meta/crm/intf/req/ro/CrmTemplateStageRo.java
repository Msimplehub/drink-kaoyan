package com.meta.crm.intf.req.ro;

import com.meta.crm.intf.entity.CrmTemplateStage;
import lombok.Data;

import java.util.Set;


/**
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:25
 */
@Data
public class CrmTemplateStageRo extends CrmTemplateStage {
    Set<String> stageCodes;
}
