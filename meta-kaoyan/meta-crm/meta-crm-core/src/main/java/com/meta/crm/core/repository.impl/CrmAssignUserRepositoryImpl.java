package com.meta.crm.core.repository.impl;

import com.meta.framework.common.utils.SecurityUtils;
import com.meta.crm.core.mapper.CrmAssignMapper;
import com.meta.crm.domain.tunnel.db.CrmAssignUserRepository;
import com.meta.crm.intf.entity.CrmAssignUser;
import com.meta.crm.domain.aggr.CrmAssignUserDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.ro.CrmAssignRo;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * @Title: CrmAssignRepositoryImpl
 * @Author: M.simple
 * @Remark: The modified content
 * @CreateDate: 2020-11-12 17:43:25
 * @Version: v2.0
 */
@Service
public class CrmAssignUserRepositoryImpl implements CrmAssignUserRepository {

    @Resource
    private CrmAssignMapper crmAssignMapper;

    @Override
    public void saveCrmAssignUser(CrmAssignUserDo crmAssignUserDo) {
        if (crmAssignUserDo.getId() == null) {
            crmAssignUserDo.setCreateBy(SecurityUtils.getUserId());
            crmAssignUserDo.setUpdateBy(SecurityUtils.getUserId());
            crmAssignMapper.insertCrmAssign(crmAssignUserDo);
        } else {
            crmAssignMapper.updateCrmAssignByPk(crmAssignUserDo);
        }
    }

    @Override
    public void batchSaveAssignUser(List<CrmAssignUserDo> crmAssignUserDo) {

        if (CollectionUtils.isEmpty(crmAssignUserDo)) {
            return;
        }

        for (CrmAssignUserDo assignUserDo : crmAssignUserDo) {
            saveCrmAssignUser(assignUserDo);
        }
    }

    @Override
    public List<CrmAssignUserDo> listByTargetIds(List<Long> targetIds, TargetType targetType) {

        CrmAssignRo crmAssignRo = new CrmAssignRo();
        crmAssignRo.setTargetIds(targetIds);
        crmAssignRo.setTargetType(targetType.getCode());
        List<CrmAssignUser> crmAssignUsers = crmAssignMapper.listByTargetIds(crmAssignRo);

        return CrmAssignUserDo.of(crmAssignUsers);
    }

    @Override
    public Map<Long, CrmAssignUserDo> mapByTargetIds(Set<Long> targetIds, TargetType targetType) {

        CrmAssignRo crmAssignRo = new CrmAssignRo();
        crmAssignRo.setTargetIds(new ArrayList<>(targetIds));
        crmAssignRo.setTargetType(targetType.getCode());
        List<CrmAssignUser> crmAssignUsers = crmAssignMapper.listByTargetIds(crmAssignRo);

        List<CrmAssignUserDo> res = CrmAssignUserDo.of(crmAssignUsers);

        Map<Long, CrmAssignUserDo> doMap = new HashMap<>();
        for (CrmAssignUserDo assignUserDo : res) {
            doMap.put(assignUserDo.getTargetId(), assignUserDo);
        }

        return doMap;
    }

    @Override
    public <BusinessObj> List<CrmAssignUserDo> listByTargets(List<BusinessObj> targets,
                                                             Function<BusinessObj, Long> getTargetId,
                                                             TargetType targetType) {
        if (CollectionUtils.isEmpty(targets)) {
            return new ArrayList<>();
        }

        List<Long> targetIds = targets.stream().map(getTargetId).collect(Collectors.toList());
        return listByTargetIds(targetIds, targetType);
    }

    @Override
    public CrmAssignUserDo getByTargetId(Long targetId, TargetType targetType) {

        List<CrmAssignUserDo> list = listByTargetIds(Collections.singletonList(targetId), targetType);
        if (CollectionUtils.isEmpty(list)) {
            return null;
        }
        return list.get(0);
    }

    @Override
    public List<CrmAssignUser> list(CrmAssignRo assignRo) {
        return crmAssignMapper.listCrmAssign(assignRo);
    }
}
