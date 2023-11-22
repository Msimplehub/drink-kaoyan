package com.meta.crm.core.factory.repository;

import com.meta.crm.core.repository.impl.base.TargetRepositoryImpl;
import com.meta.crm.domain.tunnel.db.base.TargetRepository;
import com.meta.crm.intf.enums.TargetType;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 实体获取仓库工厂
 * -- 此工厂生产可以用来查询各类实体的仓储服务类
 */
public class TargetRepositoryFactory {

    private static Map<TargetType, TargetRepository> holder = new ConcurrentHashMap<>();

    /**
     * 生产用于查询跟进目标实体的仓储类
     * @return
     */
    public static TargetRepository getTargetRepository(TargetType targetType){
        return holder.get(targetType);
    }

    /**
     * 生产用于查询跟进目标实体的仓储类
     * @return
     */
    public static TargetRepository register(TargetType targetType, TargetRepository targetRepository){
        return holder.put(targetType, targetRepository);
    }

}
