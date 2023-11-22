package com.meta.crm.core.repository.impl;

import com.meta.framework.common.utils.SecurityUtils;
import com.meta.crm.core.mapper.CrmFollowMapper;
import com.meta.crm.domain.tunnel.db.CrmFollowRepository;
import com.meta.crm.intf.common.TargetObj;
import com.meta.crm.intf.entity.CrmFollow;
import com.meta.crm.domain.aggr.CrmFollowDo;
import com.meta.crm.intf.domain.TargetDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.follow.BatchQueryLatestFollowRo;
import com.meta.crm.intf.req.follow.ListFollowByTargetListRo;
import com.meta.crm.intf.req.ro.CrmFollowRo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @Title: CrmFollowRepositoryImpl
 * @Author: M.simple
 * @Remark: The modified content
 * @CreateDate: 2020-11-12 17:43:26
 * @Version: v2.0
 */
@Service
public class CrmFollowRepositoryImpl implements CrmFollowRepository {

    @Autowired
    private CrmFollowMapper crmFollowMapper;

    /**
     * insert crmFollow info
     *
     * @param crmFollow:
     * @return void
     * @method insertCrmFollow
     * @author M.simple
     * @date 2020-11-12 17:43:26
     */
    @Override
    public void insertCrmFollow(CrmFollowDo crmFollow) {
        crmFollow.setCreateBy(SecurityUtils.getUserId());
        crmFollow.setUpdateBy(SecurityUtils.getUserId());
        crmFollowMapper.insertCrmFollow(crmFollow);
    }

    /**
     * batch insert crmFollow info
     *
     * @param crmFollows:
     * @return void
     * @method insertCrmFollow
     * @author M.simple
     * @date 2020-11-12 17:43:26
     */
    @Override
    public void batchInsertCrmFollow(List<CrmFollow> crmFollows) {
        crmFollowMapper.batchInsertCrmFollow(crmFollows);
    }

    /**
     * update crmFollow info
     *
     * @param crmFollow:
     * @return int
     * @method updateCrmFollow
     * @author M.simple
     * @date 2020-11-12 17:43:26
     */
    @Override
    public int updateCrmFollow(CrmFollow crmFollow) {
        return crmFollowMapper.updateCrmFollow(crmFollow);
    }

    /**
     * update crmFollow info by Pk
     *
     * @param crmFollow:
     * @return int
     * @method updateCrmFollowByPk
     * @author M.simple
     * @date 2020-11-12 17:43:26
     */
    @Override
    public int updateCrmFollowByPk(CrmFollow crmFollow) {
        return crmFollowMapper.updateCrmFollowByPk(crmFollow);
    }

    /**
     * list crmFollow info
     *
     * @param crmFollow:
     * @return List<CrmFollow>
     * @method listCrmFollow
     * @author M.simple
     * @date 2020-11-12 17:43:26
     */
    @Override
    public List<CrmFollowDo> listCrmFollow(CrmFollowRo crmFollow) {
        List<CrmFollow> follows = crmFollowMapper.listCrmFollow(crmFollow);
        return CrmFollowDo.of(follows);
    }

    @Override
    public List<CrmFollowDo> listByTargets(ListFollowByTargetListRo targetDoRo) {
        List<TargetDo> targetDos = targetDoRo.getTargetDos();
        if (CollectionUtils.isEmpty(targetDos)) {
            return new ArrayList<>();
        }

        List<TargetObj> targetObjs = targetDos.stream().map(targetDo ->
                new TargetObj(targetDo.getTargetId(), targetDo.getTargetType().getCode())
        ).collect(Collectors.toList());

        return CrmFollowDo.of(crmFollowMapper.listByTargets(targetObjs));
    }

    @Override
    public List<CrmFollowDo> batchQueryLatestFollowUp(BatchQueryLatestFollowRo crmFollowRo) {
        return CrmFollowDo.of(crmFollowMapper.batchQueryLatestFollowUp(crmFollowRo));
    }

    @Override
    public Map<Long, CrmFollowDo> mapLatestFollowUp(BatchQueryLatestFollowRo crmFollowRo) {

        List<CrmFollowDo> followDos = batchQueryLatestFollowUp(crmFollowRo);

        Map<Long, CrmFollowDo> followDoMap = new HashMap<>();
        for (CrmFollowDo followDo : followDos) {
            followDoMap.put(followDo.getTargetId(), followDo);
        }

        return followDoMap;
    }

    @Override
    public CrmFollowDo queryLatestFollow(Long targetId, TargetType targetType) {
        BatchQueryLatestFollowRo req = new BatchQueryLatestFollowRo();
        req.setTargetIds(Collections.singletonList(targetId));
        req.setTargetType(targetType.getCode());

        List<CrmFollowDo> resList = batchQueryLatestFollowUp(req);
        if (CollectionUtils.isEmpty(resList)) {
            return null;
        }

        return resList.get(0);
    }
}
