package com.meta.framework.tenant;

import com.baomidou.mybatisplus.core.toolkit.ClassUtils;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.core.toolkit.StringPool;
import com.baomidou.mybatisplus.extension.toolkit.PropertyMapper;
import com.google.common.collect.Sets;
import com.meta.framework.util.TenantUtils;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import net.sf.jsqlparser.expression.BinaryExpression;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.NotExpression;
import net.sf.jsqlparser.expression.Parenthesis;
import net.sf.jsqlparser.expression.operators.conditional.AndExpression;
import net.sf.jsqlparser.expression.operators.conditional.OrExpression;
import net.sf.jsqlparser.expression.operators.relational.EqualsTo;
import net.sf.jsqlparser.expression.operators.relational.ExistsExpression;
import net.sf.jsqlparser.expression.operators.relational.InExpression;
import net.sf.jsqlparser.expression.operators.relational.ItemsList;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.schema.Column;
import net.sf.jsqlparser.schema.Table;
import net.sf.jsqlparser.statement.Statement;
import net.sf.jsqlparser.statement.delete.Delete;
import net.sf.jsqlparser.statement.insert.Insert;
import net.sf.jsqlparser.statement.select.FromItem;
import net.sf.jsqlparser.statement.select.Join;
import net.sf.jsqlparser.statement.select.LateralSubSelect;
import net.sf.jsqlparser.statement.select.PlainSelect;
import net.sf.jsqlparser.statement.select.Select;
import net.sf.jsqlparser.statement.select.SelectBody;
import net.sf.jsqlparser.statement.select.SetOperationList;
import net.sf.jsqlparser.statement.select.SubJoin;
import net.sf.jsqlparser.statement.select.SubSelect;
import net.sf.jsqlparser.statement.select.ValuesList;
import net.sf.jsqlparser.statement.select.WithItem;
import net.sf.jsqlparser.statement.update.Update;
import org.apache.ibatis.cache.CacheKey;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.slf4j.MDC;
import org.springframework.util.StopWatch;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;
import java.util.Set;

/**
 * 拦截没传租户ID的sql并告警
 *
 * @author lidongzhang
 */
@Intercepts({@Signature(
        type = Executor.class,
        method = "update",
        args = {MappedStatement.class, Object.class}
), @Signature(
        type = Executor.class,
        method = "query",
        args = {MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class}
), @Signature(
        type = Executor.class,
        method = "query",
        args = {MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class, CacheKey.class, BoundSql.class}
)})
@Data
@Slf4j
public class TenantInterceptor implements Interceptor {
    @Resource
    private NoTenantIdHandler tenantLineHandler;

    @Resource
    private TenantAlarmService tenantAlarmService;

    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        if (TenantUtils.isTenantSkip(invocation) || isPageSkip(invocation)) {
            return invocation.proceed();
        }

        StopWatch stopWatch = new StopWatch();
        try {
            if (invocation.getTarget() instanceof Executor) {
                Object[] args = invocation.getArgs();
                MappedStatement ms = (MappedStatement) args[0];
                // 缓存加速，是否包含租户ID
//                if (!tenantAlarmService.hasTenantId(ms.getId())) {
                Object parameterObject = args[1];
                BoundSql boundSql = ms.getBoundSql(parameterObject);
                Statement statement = CCJSqlParserUtil.parse(boundSql.getSql());

                log.info("租户ID检查开始, sql:{}", boundSql.getSql());
                stopWatch.start("租户ID检查耗时");

                if (statement instanceof Insert) {
                    this.processInsert(ms.getId(), (Insert) statement);
                } else if (statement instanceof Select) {
                    this.processSelect(ms.getId(), (Select) statement);
                } else if (statement instanceof Update) {
                    this.processUpdate(ms.getId(), (Update) statement);
                } else if (statement instanceof Delete) {
                    this.processDelete(ms.getId(), (Delete) statement);
                }
                // 更新缓存状态
//                    tenantAlarmService.setStatus(ms.getId());
//                }
                stopWatch.stop();
                log.info(stopWatch.getLastTaskName() + stopWatch.getTotalTimeMillis());
            }
        } catch (Exception e) {
            log.info("[租户ID缺失告警]拦截器异常", e);
        } finally {
            return invocation.proceed();
        }

    }

    private boolean isPageSkip(Invocation invocation) {
        return invocation.getArgs()[0] instanceof MappedStatement
                && ((MappedStatement) invocation.getArgs()[0]).getId().endsWith("_COUNT");
    }

    private void processSelect(String id, Select select) {
        processSelectBody(id, select.getSelectBody());
        List<WithItem> withItemsList = select.getWithItemsList();
        if (!CollectionUtils.isEmpty(withItemsList)) {
            withItemsList.forEach(e -> this.processSelectBody(id, e));
        }
    }

    public void processSelectBody(String id, SelectBody selectBody) {
        if (selectBody == null) {
            return;
        }
        if (selectBody instanceof PlainSelect) {
            // tableAlias -> columns
            Map<String, Set<String>> tableColumns = new HashMap<>();
            // alias -> tableName
            Map<String, String> nameMapping = getTableNameMapping(selectBody);
            processPlainSelect(tableColumns, id, (PlainSelect) selectBody);
            tableColumns = mergeTableName(tableColumns, nameMapping);
            process(id, tableColumns, nameMapping, selectBody.toString());
        } else if (selectBody instanceof WithItem) {
            WithItem withItem = (WithItem) selectBody;
            processSelectBody(id, withItem.getSelectBody());
        } else {
            SetOperationList operationList = (SetOperationList) selectBody;
            if (operationList.getSelects() != null && operationList.getSelects().size() > 0) {
                operationList.getSelects().forEach(e -> this.processSelectBody(id, e));
            }
        }
    }

    private Map<String, Set<String>> mergeTableName(Map<String, Set<String>> tableColumns, Map<String, String> nameMapping) {
        Map<String, Set<String>> newTableColumns = new HashMap<>();
        for (Map.Entry<String, String> entry : nameMapping.entrySet()) {
            Set<String> cols = new HashSet<>();
            Optional.ofNullable(tableColumns.get(entry.getKey())).ifPresent(cols::addAll);
            Optional.ofNullable(tableColumns.get(entry.getValue())).ifPresent(cols::addAll);
            newTableColumns.put(entry.getKey(), cols);
        }
        return newTableColumns;
    }

    private Map<String, String> getTableNameMapping(SelectBody selectBody) {
        // alias -> tableName
        Map<String, String> nameMapping = new HashMap<>();
        PlainSelect selectBody1 = (PlainSelect) selectBody;
        if (selectBody1.getFromItem() instanceof Table) {
            Table fromItem = (Table) selectBody1.getFromItem();
            nameMapping.put(fromItem.getAlias() == null ? fromItem.getName() : fromItem.getAlias().getName(), fromItem.getName());
        } // sub select
//        else if (selectBody1.getFromItem() instanceof SubSelect) {
//            SubSelect subSle = (SubSelect) selectBody1.getFromItem();
//            if (subSle.getAlias() != null) {
//                nameMapping.put(subSle.getAlias().getName(), subSle.getAlias().getName());
//            }
//        }

        List<Join> joins = selectBody1.getJoins();
        if (joins != null && joins.size() > 0) {
            joins.forEach(j -> {
                if (j.getRightItem() instanceof Table) {
                    Table rightItem = (Table) j.getRightItem();
                    nameMapping.put(rightItem.getAlias() == null ? rightItem.getName() : rightItem.getAlias().getName(), rightItem.getName());
                }
            });
        }
        return nameMapping;
    }

    public void processInsert(String id, Insert insert) {
        if (tenantLineHandler.ignoreTable(insert.getTable().getName())) {
            // 过滤退出执行
            return;
        }
        List<Column> columns = insert.getColumns();
        if (CollectionUtils.isEmpty(columns)) {
            // 针对不给列名的insert 不处理
            return;
        }
        String tenantIdColumn = tenantLineHandler.getTenantIdColumn();
        if (columns.stream().map(Column::getColumnName).anyMatch(i -> i.equals(tenantIdColumn))) {
            // 针对已给出租户列的insert 不处理
            return;
        }

        log.info("[租户ID缺失告警]加入告警队列, id:{}, 表名:{}", id, insert.getTable().getName());
        process(id);

//        columns.add(new Column(tenantLineHandler.getTenantIdColumn()));
//        Select select = insert.getSelect();
//        if (select != null) {
//            this.processInsertSelect(select.getSelectBody());
//        } else if (insert.getItemsList() != null) {
//            // fixed github pull/295
//            ItemsList itemsList = insert.getItemsList();
//            if (itemsList instanceof MultiExpressionList) {
//                ((MultiExpressionList) itemsList).getExprList().forEach(el -> el.getExpressions().add(tenantLineHandler.getTenantId()));
//            } else {
//                ((ExpressionList) itemsList).getExpressions().add(tenantLineHandler.getTenantId());
//            }
//        } else {
//            throw ExceptionUtils.mpe("Failed to process multiple-table update, please exclude the tableName or statementId");
//        }
    }

    /**
     * update 语句处理
     */
    private void processUpdate(String id, Update update) {
        String tableName = update.getTable().getName();
        if (tenantLineHandler.ignoreTable(tableName)) {
            // 过滤退出执行
            return;
        }
//        update.setWhere(this.andExpression(table, update.getWhere()));
        Map<String, Set<String>> tableColumns = processWhere(tableName, update.getWhere());
        process(id, tableColumns, Collections.singletonMap(update.getTable().getAlias().getName(), tableName), update.toString());
    }

    /**
     * delete 语句处理
     */
    private void processDelete(String id, Delete delete) {
        String tableName = delete.getTable().getName();
        if (tenantLineHandler.ignoreTable(tableName)) {
            // 过滤退出执行
            return;
        }
//        delete.setWhere(this.andExpression(delete.getTable(), delete.getWhere()));
        Map<String, Set<String>> tableColumns = processWhere(tableName, delete.getWhere());

        process(id, tableColumns, Collections.singletonMap(delete.getTable().getAlias().getName(), tableName), delete.toString());
    }

    /**
     * delete update 语句 where 处理
     */
    private BinaryExpression andExpression(Table table, Expression where) {
        //获得where条件表达式
        EqualsTo equalsTo = new EqualsTo();
        equalsTo.setLeftExpression(this.getAliasColumn(table));
        equalsTo.setRightExpression(tenantLineHandler.getTenantId());
        if (null != where) {
            if (where instanceof OrExpression) {
                return new AndExpression(equalsTo, new Parenthesis(where));
            } else {
                return new AndExpression(equalsTo, where);
            }
        }
        return equalsTo;
    }


    /**
     * 处理 insert into select
     * <p>
     * 进入这里表示需要 insert 的表启用了多租户,则 select 的表都启动了
     *
     * @param selectBody SelectBody
     */
//    protected void processInsertSelect(SelectBody selectBody) {
//        PlainSelect plainSelect = (PlainSelect) selectBody;
//        FromItem fromItem = plainSelect.getFromItem();
//        if (fromItem instanceof Table) {
//            Table fromTable = (Table) fromItem;
//            plainSelect.setWhere(builderExpression(plainSelect.getWhere(), fromTable));
//            appendSelectItem(plainSelect.getSelectItems());
//        } else if (fromItem instanceof SubSelect) {
//            SubSelect subSelect = (SubSelect) fromItem;
//            appendSelectItem(plainSelect.getSelectItems());
//            processInsertSelect(subSelect.getSelectBody());
//        }
//    }

    /**
     * 追加 SelectItem
     *
     * @param selectItems SelectItem
     */
//    protected void appendSelectItem(List<SelectItem> selectItems) {
//        if (CollectionUtils.isEmpty(selectItems)) {
//            return;
//        }
//        if (selectItems.size() == 1) {
//            SelectItem item = selectItems.get(0);
//            if (item instanceof AllColumns || item instanceof AllTableColumns) {
//                return;
//            }
//        }
//        selectItems.add(new SelectExpressionItem(new Column(tenantLineHandler.getTenantIdColumn())));
//    }

    /**
     * 处理 PlainSelect
     */
    protected void processPlainSelect(Map<String, Set<String>> tableColumns, String id, PlainSelect plainSelect) {
        FromItem fromItem = plainSelect.getFromItem();
        Expression where = plainSelect.getWhere();
        processWhereSubSelect(id, where);

        if (fromItem instanceof Table) {
            Table fromTable = (Table) fromItem;
//            if (!tenantLineHandler.ignoreTable(fromTable.getName())) {
            //#1186 github
//                plainSelect.setWhere(builderExpression(where, fromTable));
//                processWhere(id, fromTable.getName(), where);

            Map<String, Set<String>> leftNames = processWhere(fromTable.getName(), where);
            putMap(tableColumns, leftNames);
//            }
        } else {
            processFromItem(id, fromItem);

            // sub select where
            Map<String, Set<String>> leftNames = processWhere(fromItem.getAlias().getName(), where);
            putMap(tableColumns, leftNames);
        }
        List<Join> joins = plainSelect.getJoins();
        if (joins != null && joins.size() > 0) {
            joins.forEach(j -> {
                if (j.getRightItem() instanceof Table) {
                    putMap(tableColumns, processJoin(id, j));
                }
                processFromItem(id, j.getRightItem());
            });
        }
    }

    public static void putMap(Map<String, Set<String>> to, Map<String, Set<String>> from) {
        for (Map.Entry<String, Set<String>> entry : from.entrySet()) {
            if (to.containsKey(entry.getKey())) {
                to.get(entry.getKey()).addAll(entry.getValue());
            } else {
                to.put(entry.getKey(), entry.getValue());
            }
        }
    }

    private static void flatWhere(String fromTable, Expression where, Map<String, Set<String>> leftNames) {
        if (where == null) {
            return;
        }

        if (where instanceof EqualsTo) {
            EqualsTo et = (EqualsTo) where;
            if (et.getLeftExpression() instanceof Column) {
                Column col = (Column) et.getLeftExpression();
                String tableName = col.getTable() == null ? fromTable : col.getTable().getName();
                if (leftNames.containsKey(tableName)) {
                    leftNames.get(tableName).add(col.getColumnName());
                } else {
                    leftNames.put(tableName, Sets.newHashSet(col.getColumnName()));
                }
            }
            if (et.getRightExpression() instanceof Column) {
                Column col = (Column) et.getRightExpression();
                String tableName = col.getTable() == null ? fromTable : col.getTable().getName();
                if (leftNames.containsKey(tableName)) {
                    leftNames.get(tableName).add(col.getColumnName());
                } else {
                    leftNames.put(tableName, Sets.newHashSet(col.getColumnName()));
                }
            }
        } else if (where instanceof Column) {
            Column col = (Column) where;
//            leftNames.add(col.getColumnName());

            String tableName = col.getTable() == null ? fromTable : col.getTable().getName();
            if (leftNames.containsKey(tableName)) {
                leftNames.get(tableName).add(col.getColumnName());
            } else {
                leftNames.put(tableName, Sets.newHashSet(col.getColumnName()));
            }
        } else if (where instanceof BinaryExpression) {
            BinaryExpression expression = (BinaryExpression) where;
            flatWhere(fromTable, expression.getLeftExpression(), leftNames);
            flatWhere(fromTable, expression.getRightExpression(), leftNames);
        } else if (where instanceof InExpression) {
            InExpression or = (InExpression) where;
            flatWhere(fromTable, or.getLeftExpression(), leftNames);
            flatWhere(fromTable, or.getRightExpression(), leftNames);
        } else {
            // 可能是exists查询，可忽略
            log.info("[租户ID缺失告警]未处理的表达式类型{}", where);
        }
    }

    private void process(String id) {
        TenantAlarmDto msg = new TenantAlarmDto().setAddTime(new Date()).setId(id).setTraceId(MDC.get("traceId"));
        tenantAlarmService.put(msg);
    }

    private void process(String id, Map<String, Set<String>> tableColumns, Map<String, String> nameMapping, String sql) {
        boolean notice = false;
        for (Map.Entry<String, Set<String>> entry : tableColumns.entrySet()) {
            String tableName = nameMapping.get(entry.getKey());
            if (!tenantLineHandler.ignoreTable(tableName)
                    && !entry.getValue().contains(tenantLineHandler.getTenantIdColumn())) {
                log.info("[租户ID缺失告警]加入告警队列, id:{}, 别名：{}, 表名:{}, 当前字段:{}, sql:{}", id, entry.getKey(), tableName, entry.getValue(), sql);
                notice = true;
            }
        }
        if (notice) {
            process(id);
        }
    }

    private Map<String, Set<String>> processWhere(String tableName, Expression where) {
        Map<String, Set<String>> leftNames = new HashMap<>();
        flatWhere(tableName, where, leftNames);
//        log.info("leftNames={}", leftNames);
//        if (!leftNames.containsk(tenantLineHandler.getTenantIdColumn())) {
//            log.info("[租户ID缺失告警]加入告警队列, id:{}, 表名:{}, where:{}", id, tableName, where);
//            process(id);
//        }
        return leftNames;
    }

    /**
     * 处理where条件内的子查询
     * <p>
     * 支持如下:
     * 1. in
     * 2. =
     * 3. >
     * 4. <
     * 5. >=
     * 6. <=
     * 7. <>
     * 8. EXISTS
     * 9. NOT EXISTS
     * <p>
     * 前提条件:
     * 1. 子查询必须放在小括号中
     * 2. 子查询一般放在比较操作符的右边
     *
     * @param where where 条件
     */
    protected void processWhereSubSelect(String id, Expression where) {
        if (where == null) {
            return;
        }
        if (where instanceof FromItem) {
            processFromItem(id, (FromItem) where);
            return;
        }
        if (where.toString().indexOf("SELECT") > 0) {
            // 有子查询
            if (where instanceof BinaryExpression) {
                // 比较符号 , and , or , 等等
                BinaryExpression expression = (BinaryExpression) where;
                processWhereSubSelect(id, expression.getLeftExpression());
                processWhereSubSelect(id, expression.getRightExpression());
            } else if (where instanceof InExpression) {
                // in
                InExpression expression = (InExpression) where;
                ItemsList itemsList = expression.getRightItemsList();
                if (itemsList instanceof SubSelect) {
                    processSelectBody(id, ((SubSelect) itemsList).getSelectBody());
                }
            } else if (where instanceof ExistsExpression) {
                // exists
                ExistsExpression expression = (ExistsExpression) where;
                processWhereSubSelect(id, expression.getRightExpression());
            } else if (where instanceof NotExpression) {
                // not exists
                NotExpression expression = (NotExpression) where;
                processWhereSubSelect(id, expression.getExpression());
            } else if (where instanceof Parenthesis) {
                Parenthesis expression = (Parenthesis) where;
                processWhereSubSelect(id, expression.getExpression());
            }
        }
    }

    /**
     * 处理子查询等
     */
    protected void processFromItem(String id, FromItem fromItem) {
        if (fromItem instanceof SubJoin) {
            SubJoin subJoin = (SubJoin) fromItem;
            if (subJoin.getJoinList() != null) {
                subJoin.getJoinList().forEach(o -> this.processJoin(id, o));
            }
            if (subJoin.getLeft() != null) {
                processFromItem(id, subJoin.getLeft());
            }
        } else if (fromItem instanceof SubSelect) {
            SubSelect subSelect = (SubSelect) fromItem;
            if (subSelect.getSelectBody() != null) {
                processSelectBody(id, subSelect.getSelectBody());
            }
        } else if (fromItem instanceof ValuesList) {
            log.debug("Perform a subquery, if you do not give us feedback");
        } else if (fromItem instanceof LateralSubSelect) {
            LateralSubSelect lateralSubSelect = (LateralSubSelect) fromItem;
            if (lateralSubSelect.getSubSelect() != null) {
                SubSelect subSelect = lateralSubSelect.getSubSelect();
                if (subSelect.getSelectBody() != null) {
                    processSelectBody(id, subSelect.getSelectBody());
                }
            }
        }
    }

    /**
     * 处理联接语句
     */
    protected Map<String, Set<String>> processJoin(String id, Join join) {
        Map<String, Set<String>> leftNames = new HashMap<>();
        if (join.getRightItem() instanceof Table) {
            Table fromTable = (Table) join.getRightItem();
//            if (tenantLineHandler.ignoreTable(fromTable.getName())) {
//                // 过滤退出执行
//                return;
//            }
//            join.setOnExpression(builderExpression(join.getOnExpression(), fromTable));
//            processWhere(id, fromTable.getName(), join.getOnExpression());
            flatWhere(fromTable.getName(), join.getOnExpression(), leftNames);


        }
        return leftNames;
    }

    /**
     * 处理条件
     */
    protected Expression builderExpression(Expression currentExpression, Table table) {
        EqualsTo equalsTo = new EqualsTo();
        equalsTo.setLeftExpression(this.getAliasColumn(table));
        equalsTo.setRightExpression(tenantLineHandler.getTenantId());
        if (currentExpression == null) {
            return equalsTo;
        }
        if (currentExpression instanceof OrExpression) {
            return new AndExpression(new Parenthesis(currentExpression), equalsTo);
        } else {
            return new AndExpression(currentExpression, equalsTo);
        }
    }

    /**
     * 租户字段别名设置
     * <p>tenantId 或 tableAlias.tenantId</p>
     *
     * @param table 表对象
     * @return 字段
     */
    protected Column getAliasColumn(Table table) {
        StringBuilder column = new StringBuilder();
        if (table.getAlias() != null) {
            column.append(table.getAlias().getName()).append(StringPool.DOT);
        }
        column.append(tenantLineHandler.getTenantIdColumn());
        return new Column(column.toString());
    }

    @Override
    public void setProperties(Properties properties) {
        PropertyMapper.newInstance(properties)
                .whenNotBlack("tenantLineHandler", ClassUtils::newInstance, this::setTenantLineHandler);
    }

}
