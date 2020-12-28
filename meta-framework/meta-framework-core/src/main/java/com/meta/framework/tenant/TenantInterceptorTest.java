package com.meta.framework.tenant;

import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.Statement;
import net.sf.jsqlparser.statement.insert.Insert;
import net.sf.jsqlparser.statement.select.Select;

/**
 * TenantInterceptorTest
 *
 * @author lidongzhang
 */
public class TenantInterceptorTest {

    public static void main(String[] args) throws Exception {
//        testSimpleSelect();
//        testSelect();
//        testSubSelect();
//        testLeftJoin1();
//        testLeftJoin2();
//        testLeftJoin3();
//        testLeftJoin4();
        testLeftJoin5();
//        testSelectColAlias();
//        testSelectSubTmp();
//        testSelecterr();
        testInsert();
        testInsert2();
    }

    private static void testLeftJoin1() throws JSQLParserException {
        Statement parse = CCJSqlParserUtil.parse("select u.user_id, tu.dept_id, u.user_name, u.nick_name, u.email, u.avatar, u.phonenumber, u.password, u.sex, u.status, u.del_flag, u.login_ip, u.login_date, u.create_by, u.create_time, u.remark,\n" +
                "        d.dept_id, d.parent_id, d.dept_name, d.order_num, d.leader, d.status as dept_status,\n" +
                "        r.role_id, r.role_name, r.role_key, r.role_sort, r.data_scope, r.status as role_status\n" +
                "        from tenant_user u\n" +
                "        join tenant_user tu on tu.user_id = u.user_id and tu.del_flag = 0 and tu.tenant_id = 1\n" +
                "\t\t    left join sys_dept d on tu.dept_id = d.dept_id and tu.tenant_id = d.tenant_id\n" +
                "\t\t    left join sys_user_role ur on u.user_id = ur.user_id and ur.tenant_id = tu.tenant_id\n" +
                "\t\t    left join sys_role r on r.role_id = ur.role_id and r.tenant_id = ur.tenant_id" +
                " where u.del_flag = '0' and u.tenant_id = 1");
        TenantInterceptor tenantInterceptor = new TenantInterceptor();
        tenantInterceptor.setTenantLineHandler(new NoTenantIdHandler());
        tenantInterceptor.processSelectBody("testLeftJoin1", ((Select) parse).getSelectBody());
    }

    private static void testLeftJoin2() throws JSQLParserException {
        Statement parse = CCJSqlParserUtil.parse("SELECT\n" +
                "        cb.id as businessId,\n" +
                "        cb.business_name as businessName,\n" +
                "        cc.id as customerId,\n" +
                "        cc.customer_name as customerName,\n" +
                "        cb.current_stage_code as currentStageCode,\n" +
                "        cb.estimate_deal_amount as estimateDealAmount,\n" +
                "        cb.estimate_deal_date as estimateDealDate,\n" +
                "        cb.real_deal_date as realDealDate,\n" +
                "        ca.manager_id AS userId,\n" +
                "        cb.create_by AS createBy,\n" +
                "        cb.create_time as createTime\n" +
                "        FROM\n" +
                "        crm_business cb\n" +
                "        LEFT JOIN crm_customer cc ON cb.customer_id = cc.id\n" +
                "        LEFT JOIN crm_assign ca ON cb.id = ca.target_id\n" +
                "        AND ca.target_type = 'business'\n" +
                "        AND ca.manager_type = 0\n" +
                "        AND ca.assign_role = 1\n" +
                "        AND ca.tenant_id=1 and cb.tenant_id=1 and cc.tenant_id=1");
        TenantInterceptor tenantInterceptor = new TenantInterceptor();
        tenantInterceptor.setTenantLineHandler(new NoTenantIdHandler());
        tenantInterceptor.processSelectBody("testSelectLeftJoin", ((Select) parse).getSelectBody());
    }

    private static void testLeftJoin3() throws JSQLParserException {
        Statement parse = CCJSqlParserUtil.parse("SELECT\n" +
                "            cts.*\n" +
                "        FROM\n" +
                "            crm_template ct\n" +
                "            LEFT JOIN crm_template_stage cts ON ct.id = cts.template_id\n" +
                "        WHERE\n" +
                "            ct.del_flag = 0\n" +
                "            AND cts.del_flag = 0\n" +
                "            AND ct.`status` = 1\n" +
                "            AND ct.tenant_id =1\n" +
                "            AND cts.tenant_id = 2");
        TenantInterceptor tenantInterceptor = new TenantInterceptor();
        tenantInterceptor.setTenantLineHandler(new NoTenantIdHandler());
        tenantInterceptor.processSelectBody("testLeftJoin3", ((Select) parse).getSelectBody());
    }
    private static void testLeftJoin4() throws JSQLParserException {
        Statement parse = CCJSqlParserUtil.parse("SELECT DISTINCT m.menu_id,\n" +
                "\t\t m.parent_id,\n" +
                "\t\t m.menu_name,\n" +
                "\t\t m.path,\n" +
                "\t\t m.component,\n" +
                "\t\t m.visible,\n" +
                "\t\t m.status,\n" +
                "\t\t ifnull(m.perms,\n" +
                "\t\t '') AS perms, m.is_frame, m.is_cache, m.menu_type, m.icon, m.order_num, m.create_time\n" +
                "FROM sys_menu m\n" +
                "LEFT JOIN sys_role_menu rm\n" +
                "\tON m.menu_id = rm.menu_id\n" +
                "LEFT JOIN sys_user_role ur\n" +
                "\tON rm.role_id = ur.role_id\n" +
                "LEFT JOIN sys_role ro\n" +
                "\tON ur.role_id = ro.role_id\n" +
                "LEFT JOIN sys_user u\n" +
                "\tON ur.user_id = u.user_id\n" +
                "WHERE u.user_id = ?\n" +
                "\t\tAND m.menu_type IN ('M', 'C')\n" +
                "\t\tAND m.status = 0\n" +
                "\t\tAND ro.status = 0\n" +
                "\t\tAND rm.tenant_id = ?\n" +
                "ORDER BY  m.parent_id, m.order_num");
        TenantInterceptor tenantInterceptor = new TenantInterceptor();
        tenantInterceptor.setTenantLineHandler(new NoTenantIdHandler());
        tenantInterceptor.processSelectBody("testLeftJoin4", ((Select) parse).getSelectBody());
    }

    private static void testLeftJoin5() throws JSQLParserException {
        Statement parse = CCJSqlParserUtil.parse("select distinct m.menu_id, m.parent_id, m.menu_name, m.path, m.component, m.visible, m.status, ifnull(m.perms,'') as perms, m.is_frame, m.is_cache, m.menu_type, m.icon, m.order_num, m.create_time\n" +
                "\t\tfrom sys_menu m\n" +
                "\t\t\t left join sys_role_menu rm on m.menu_id = rm.menu_id\n" +
                "\t\t\t left join sys_user_role ur on rm.role_id = ur.role_id\n" +
                "\t\t\t left join sys_role ro on ur.role_id = ro.role_id\n" +
                "\t\t\t left join sys_user u on ur.user_id = u.user_id\n" +
                "\t\twhere u.user_id = ? and m.menu_type in ('M', 'C') and m.status = 0  AND ro.status = 0\n" +
                "\t\tAND rm.tenant_id = ?\n" +
                "\t\torder by m.parent_id, m.order_num");
        TenantInterceptor tenantInterceptor = new TenantInterceptor();
        tenantInterceptor.setTenantLineHandler(new NoTenantIdHandler());
        tenantInterceptor.processSelectBody("testLeftJoin5", ((Select) parse).getSelectBody());
    }

    private static void testSelectColAlias() throws JSQLParserException {
        Statement parse = CCJSqlParserUtil.parse("SELECT d.dept_id,\n" +
                "\t\t d.parent_id,\n" +
                "\t\t d.ancestors,\n" +
                "\t\t d.dept_name,\n" +
                "\t\t d.order_num,\n" +
                "\t\t d.leader,\n" +
                "\t\t d.phone,\n" +
                "\t\t d.email,\n" +
                "\t\t d.status,\n" +
                "\t\t d.del_flag,\n" +
                "\t\t d.create_by,\n" +
                "\t\t d.create_time\n" +
                "FROM sys_dept d\n" +
                "WHERE d.del_flag = '0'\n" +
                "\t\tAND tenant_id = ?\n" +
                "ORDER BY  d.parent_id, d.order_num");
        TenantInterceptor tenantInterceptor = new TenantInterceptor();
        tenantInterceptor.setTenantLineHandler(new NoTenantIdHandler());
        tenantInterceptor.processSelectBody("testSelectColAlias", ((Select) parse).getSelectBody());
    }
    private static void testSelectSubTmp() throws JSQLParserException {
        Statement parse = CCJSqlParserUtil.parse("SELECT cf.*\n" +
                "FROM \n" +
                "    (SELECT target_id,\n" +
                "\t\t max(id) AS id\n" +
                "    FROM crm_follow\n" +
                "    WHERE target_type = ?\n" +
                "    \t\tAND del_flag = 0\n" +
                "    \t\tAND tenant_id = ?\n" +
                "    GROUP BY  target_id) tmp\n" +
                "LEFT JOIN crm_follow cf\n" +
                "\tON cf.id = tmp.id\n" +
                "WHERE cf.del_flag = 0\n" +
                "\t\tAND cf.tenant_id = ?\n" +
                "\t\tAND cf.target_id IN (?, ?, ?)");
        TenantInterceptor tenantInterceptor = new TenantInterceptor();
        tenantInterceptor.setTenantLineHandler(new NoTenantIdHandler());
        tenantInterceptor.processSelectBody("testSelectSubTmp", ((Select) parse).getSelectBody());
    }

    private static void testSimpleSelect() throws JSQLParserException {
        Statement parse = CCJSqlParserUtil.parse("select * from user");
        TenantInterceptor tenantInterceptor = new TenantInterceptor();
        tenantInterceptor.setTenantLineHandler(new NoTenantIdHandler());
        tenantInterceptor.processSelectBody("testSimpleSelect", ((Select) parse).getSelectBody());
    }

    private static void testSelect() throws JSQLParserException {
        Statement parse = CCJSqlParserUtil.parse("select * from user where age=2 or name in (1,2) " +
                "or gender=3 or bir in (select bir from ub where a=3)" +
                "and exists(select n from user2 where user.name4=user2.n)");
        TenantInterceptor tenantInterceptor = new TenantInterceptor();
        tenantInterceptor.setTenantLineHandler(new NoTenantIdHandler());
        tenantInterceptor.processSelectBody("testSelect", ((Select) parse).getSelectBody());
    }

    private static void testSubSelect() throws JSQLParserException {
        Statement parse = CCJSqlParserUtil.parse("select * from user where id in (select id from role where role=1)");
        TenantInterceptor tenantInterceptor = new TenantInterceptor();
        tenantInterceptor.setTenantLineHandler(new NoTenantIdHandler());
        tenantInterceptor.processSelectBody("testSelect", ((Select) parse).getSelectBody());
    }

    private static void testInsert() throws JSQLParserException {
        Statement parse = CCJSqlParserUtil.parse("insert into user(a,tenant_id) values(1,2)");
        TenantInterceptor tenantInterceptor = new TenantInterceptor();
        tenantInterceptor.setTenantLineHandler(new NoTenantIdHandler());
        tenantInterceptor.processInsert("testInsert", ((Insert) parse));
    }

    private static void testInsert2() throws JSQLParserException {
        Statement parse = CCJSqlParserUtil.parse("INSERT INTO crm_follow ( target_type, target_id, follow_type, " +
                "follow_sub_type, content, tenant_id, create_by, update_by ) " +
                "VALUE ( 1, 2, 3, 4, 5, 6, 7, 8 )");
        TenantInterceptor tenantInterceptor = new TenantInterceptor();
        tenantInterceptor.setTenantLineHandler(new NoTenantIdHandler());
        tenantInterceptor.processInsert("testInsert2", ((Insert) parse));
    }

}
