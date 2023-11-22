package com.meta.crm.core.repository.impl.base;

import com.meta.crm.core.factory.repository.TargetRepositoryFactory;
import com.meta.crm.domain.tunnel.db.base.TargetRepository;
import com.meta.crm.intf.domain.TargetDo;
import com.meta.crm.intf.enums.TargetType;
import org.springframework.beans.factory.InitializingBean;

import java.util.Collections;
import java.util.List;

public abstract class TargetRepositoryImpl implements InitializingBean, TargetRepository {

    /**
     * 查询需要展示到详情页跟进列表的实体
     * @return
     */
    public List<TargetDo> queryShowFollowTargets(Long targetId){
        return Collections.singletonList(this.queryTargetByTargets(targetId));
    };

    /**
     * 查询实体信息
     * @return
     */
    public abstract TargetDo queryTargetByTargets(Long targetId);

    /**
     * 本仓库类所支持的实体类型
     * @return
     */
    public abstract TargetType getTargetType();

    @Override
    public void afterPropertiesSet() throws Exception {
        TargetRepositoryFactory.register(this.getTargetType(), this);
    }
}
