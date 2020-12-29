package com.meta.framework.tenant.mapper;

import org.springframework.stereotype.Repository;

import java.util.Set;

/**
 * SchemaMapper
 *
 * @author lidongzhang
 */
@Repository
public interface SchemaMapper {
    /**
     * 查询x-crm库，没有tenant_id字段的表名列表
     *
     * @param dbName dbName
     * @return
     */
    Set<String> queryNoTenantIdTableNames(String dbName);
}
