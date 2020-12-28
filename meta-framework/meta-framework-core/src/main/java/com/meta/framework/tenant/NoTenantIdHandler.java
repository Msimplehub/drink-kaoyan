package com.meta.framework.tenant;

import com.baomidou.mybatisplus.extension.plugins.handler.TenantLineHandler;
import com.google.common.collect.Sets;
import net.sf.jsqlparser.expression.Expression;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.Collections;
import java.util.Set;

/**
 * NoTenantIdHandler
 *
 * @author lidongzhang
 */
@Component
public class NoTenantIdHandler implements TenantLineHandler {
    private static final Set<String> IGNORE_TABLES =
            Collections.synchronizedSet(
                    Sets.newHashSet("tables", "columns"));

    @Value("${tenant.ignore-tables}")
    private String ignoreTables;

    @Override
    public Expression getTenantId() {
        return null;
    }

    @Override
    public boolean ignoreTable(String tableName) {
        return IGNORE_TABLES.contains(tableName);
    }

    public void addIgnoreTables(Set<String> tableNames) {
        IGNORE_TABLES.addAll(tableNames);
    }

    public Set<String> getIgnoreTables() {
        return IGNORE_TABLES;
    }

    @PostConstruct
    private void init() {
        if (StringUtils.isNoneEmpty(ignoreTables)) {
            Set<String> appIgnoreTables = Sets.newHashSet(ignoreTables.split(","));
            this.addIgnoreTables(appIgnoreTables);
        }
    }
}
