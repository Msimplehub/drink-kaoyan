package com.meta.crm.domain.tunnel.db;

import com.meta.crm.intf.entity.CrmAssignUser;
import com.meta.crm.domain.aggr.CrmAssignUserDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.ro.CrmAssignRo;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;

public interface CrmAssignUserRepository {

    void saveCrmAssignUser(CrmAssignUserDo crmAssignUserDo);

    List<CrmAssignUser> list(CrmAssignRo assignRo);

    Map<Long, CrmAssignUserDo> mapByTargetIds(Set<Long> targetIds, TargetType targetType);

    <BusinessObj> List<CrmAssignUserDo> listByTargets(List<BusinessObj> targets,
                                                      Function<BusinessObj, Long> getTargetId,
                                                      TargetType targetType);

    List<CrmAssignUserDo> listByTargetIds(List<Long> targetIds, TargetType targetType);

    CrmAssignUserDo getByTargetId(Long targetId, TargetType targetType);

    void batchSaveAssignUser(List<CrmAssignUserDo> crmAssignUserDo);
}
