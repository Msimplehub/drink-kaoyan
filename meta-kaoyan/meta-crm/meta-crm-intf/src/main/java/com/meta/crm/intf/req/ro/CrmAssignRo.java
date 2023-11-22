package com.meta.crm.intf.req.ro;

import com.meta.crm.intf.entity.CrmAssignUser;
import lombok.Data;

import java.util.List;


/**
 *
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:25
 */
@Data
public class CrmAssignRo extends CrmAssignUser {
    List<Long> targetIds;
}
