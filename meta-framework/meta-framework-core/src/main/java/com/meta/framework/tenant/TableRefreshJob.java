package com.meta.framework.tenant;

import com.alibaba.druid.util.DruidDataSourceUtils;
import com.meta.framework.tenant.mapper.SchemaMapper;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.sql.DataSource;
import java.util.Set;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * TableRefreshJob
 *
 * @author lidongzhang
 */
@Component
@Slf4j
public class TableRefreshJob {
    @Resource
    private SchemaMapper schemaMapper;

    @Resource
    private NoTenantIdHandler noTenantIdHandler;

    @Resource
    @Qualifier("masterDataSource")
    private DataSource dataSource;

    private volatile boolean running = false;

    @PostConstruct
    public void start() {
        if (running) {
            return;
        }

        running = true;

        // jdbc:mysql://localhost:3306/x-crm?useUnicode=true&characterEncoding=utf8
        String jdbcUrl = DruidDataSourceUtils.getUrl(dataSource);
        String dbName = getDbName(jdbcUrl);

        ScheduledExecutorService executor = Executors.newScheduledThreadPool(1);
        executor.scheduleAtFixedRate(() -> this.refreshTables(dbName), 0, 5, TimeUnit.MINUTES);
    }

    private String getDbName(String jdbcUrl) {
        return StringUtils.substringAfterLast(
                StringUtils.substringBefore(jdbcUrl, "?"), "/");
    }

    private void refreshTables(String dbName) {
        Set<String> tableNames = schemaMapper.queryNoTenantIdTableNames(dbName);
        if (CollectionUtils.isNotEmpty(tableNames)) {
            noTenantIdHandler.addIgnoreTables(tableNames);
        }
        log.debug("ignore tables：{}", noTenantIdHandler.getIgnoreTables());
    }
}
