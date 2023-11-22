package com.meta.crm.domain.tunnel.db.base;

import com.meta.crm.intf.domain.TargetDo;

import java.util.List;

public interface TargetRepository {

    /**
     * 查询需要展示到跟进列表的实体
     * @return
     */
    List<TargetDo> queryShowFollowTargets(Long targetId);

    /**
     * 查询需要展示到跟进列表的实体
     * @return
     */
    TargetDo queryTargetByTargets(Long targetId);

}
