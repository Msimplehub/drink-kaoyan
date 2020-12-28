/*
 Navicat Premium Data Transfer

 Source Server         : 10.40.11.103
 Source Server Type    : MySQL
 Source Server Version : 50719
 Source Host           : 10.40.11.103:3306
 Source Schema         : x-crm-2

 Target Server Type    : MySQL
 Target Server Version : 50719
 File Encoding         : 65001

 Date: 30/11/2020 13:28:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for crm_assign
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COMMENT='参数配置表';

-- ----------------------------
drop table if exists sys_job;
create table sys_job (
  job_id              bigint(20)    not null auto_increment    comment '任务ID',
  job_name            varchar(64)   default ''                 comment '任务名称',
  job_group           varchar(64)   default 'DEFAULT'          comment '任务组名',
  invoke_target       varchar(500)  not null                   comment '调用目标字符串',
  cron_expression     varchar(255)  default ''                 comment 'cron执行表达式',
  misfire_policy      varchar(20)   default '3'                comment '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  concurrent          char(1)       default '1'                comment '是否并发执行（0允许 1禁止）',
  status              char(1)       default '0'                comment '状态（0正常 1暂停）',
  create_by           varchar(64)   default ''                 comment '创建者',
  create_time         datetime                                 comment '创建时间',
  update_by           varchar(64)   default ''                 comment '更新者',
  update_time         datetime                                 comment '更新时间',
  remark              varchar(500)  default ''                 comment '备注信息',
  primary key (job_id, job_name, job_group)
) engine=innodb auto_increment=100 comment = '定时任务调度表';

insert into sys_job values(1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams',        '0/10 * * * * ?', '3', '1', '1', '1', sysdate(), '', null, '');
insert into sys_job values(2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')',  '0/15 * * * * ?', '3', '1', '1', '1', sysdate(), '', null, '');
insert into sys_job values(3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)',  '0/20 * * * * ?', '3', '1', '1', '1', sysdate(), '', null, '');


-- ----------------------------
-- 16、定时任务调度日志表
-- ----------------------------
drop table if exists sys_job_log;
create table sys_job_log (
  job_log_id          bigint(20)     not null auto_increment    comment '任务日志ID',
  job_name            varchar(64)    not null                   comment '任务名称',
  job_group           varchar(64)    not null                   comment '任务组名',
  invoke_target       varchar(500)   not null                   comment '调用目标字符串',
  job_message         varchar(500)                              comment '日志信息',
  status              char(1)        default '0'                comment '执行状态（0正常 1失败）',
  exception_info      varchar(2000)  default ''                 comment '异常信息',
  create_time         datetime                                  comment '创建时间',
  primary key (job_log_id)
) engine=innodb comment = '定时任务调度日志表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN;
INSERT INTO `sys_config` VALUES (101, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 1, '0', '1', '2020-11-17 14:13:05', '', NULL, '初始化密码 123456');
COMMIT;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` bigint(20) DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE,
  KEY `idx_dept_id` (`dept_id`) USING BTREE COMMENT '部门ID索引'
) ENGINE=InnoDB AUTO_INCREMENT=288 DEFAULT CHARSET=utf8mb4 COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` VALUES (287, 0, '287', '艾佳生活', 0, NULL, NULL, NULL, '0', 1, '0', -1, '2020-11-30 11:56:29', 0, '2020-11-30 11:56:29');
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8mb4 COMMENT='字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', '1', '2020-11-12 10:10:15', '109', '2020-11-24 16:05:57', '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', '1', '2020-11-12 10:10:15', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', '1', '2020-11-12 10:10:15', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', '1', '2020-11-12 10:10:15', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', '1', '2020-11-12 10:10:15', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', '1', '2020-11-12 10:10:15', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', '1', '2020-11-12 10:10:15', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', '1', '2020-11-12 10:10:15', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', '1', '2020-11-12 10:10:15', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', '1', '2020-11-12 10:10:16', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 0, '跟进中', 'follow_up', 'clue_status', NULL, NULL, 'N', '0', '1', '2020-11-17 13:19:54', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (101, 1, '已关闭', 'closed', 'clue_status', NULL, NULL, 'N', '0', '1', '2020-11-17 13:20:08', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (102, 2, '已转换', 'converted', 'clue_status', NULL, NULL, 'N', '0', '1', '2020-11-17 13:20:19', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (103, 0, '广告', 'ad', 'clue_source', NULL, NULL, 'N', '0', '1', '2020-11-17 13:22:26', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (104, 1, '搜索引擎', 'search', 'clue_source', NULL, NULL, 'N', '0', '1', '2020-11-17 13:22:37', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (105, 2, '客户介绍', 'man_introduce', 'clue_source', NULL, NULL, 'N', '0', '1', '2020-11-17 13:22:53', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (106, 3, '预约上门', 'make_an_appointment', 'clue_source', NULL, NULL, 'N', '0', '1', '2020-11-17 13:23:11', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (107, 4, '陌拜', 'mobai', 'clue_source', NULL, NULL, 'N', '0', '1', '2020-11-17 13:23:24', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (108, 5, '电话咨询', 'tel', 'clue_source', NULL, NULL, 'N', '0', '1', '2020-11-17 13:23:35', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (109, 6, '邮件咨询', 'mail', 'clue_source', NULL, NULL, 'N', '0', '1', '2020-11-17 13:23:56', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (110, 7, '线上注册', 'online_reg', 'clue_source', NULL, NULL, 'N', '0', '1', '2020-11-17 13:24:09', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (111, 8, '线上询价', 'online_inquiry', 'clue_source', NULL, NULL, 'N', '0', '1', '2020-11-17 13:24:22', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (112, 9, '其它', 'other', 'clue_source', NULL, NULL, 'N', '0', '1', '2020-11-17 13:24:34', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (113, 0, 'A(重点客户)', 'a', 'crm_customer_level', NULL, NULL, 'N', '0', '1', '2020-11-19 07:48:52', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (114, 1, 'B(普通客户)', 'b', 'crm_customer_level', NULL, NULL, 'N', '0', '1', '2020-11-19 07:49:08', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (115, 0, '电话', 'phone', 'follow_type', NULL, NULL, 'N', '0', '1', '2020-11-19 07:58:14', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (116, 1, '微信', 'wechat', 'follow_type', NULL, NULL, 'N', '0', '1', '2020-11-19 07:58:36', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (117, 2, '拜访', 'visit', 'follow_type', NULL, NULL, 'N', '0', '1', '2020-11-19 07:58:45', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (118, 1, '价格原因', 'price', 'lose_reason', NULL, NULL, 'N', '0', '1', '2020-11-19 08:39:12', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (119, 2, '客户关系原因', 'customer', 'lose_reason', NULL, NULL, 'N', '0', '105', '2020-11-19 08:41:27', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (120, 3, '产品原因', 'product', 'lose_reason', NULL, NULL, 'N', '0', '105', '2020-11-19 08:41:42', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (121, 4, '其他', 'other', 'lose_reason', NULL, NULL, 'N', '0', '105', '2020-11-19 08:41:55', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (122, 0, '线索', 'clue', 'business_type', NULL, NULL, 'N', '0', '100', '2020-11-20 15:29:10', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (123, 1, '商机', 'business', 'business_type', NULL, NULL, 'N', '0', '100', '2020-11-20 15:29:28', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (124, 2, '客户', 'customer', 'business_type', NULL, NULL, 'N', '0', '100', '2020-11-20 15:29:40', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (125, 3, '联系人', 'contact', 'business_type', NULL, NULL, 'N', '0', '100', '2020-11-20 15:29:53', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (126, 0, '接通成功', 'phone_success', 'follow_sub_type_phone', NULL, NULL, 'N', '0', '100', '2020-11-20 15:31:03', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (127, 1, '无法接通', 'phone_no_resp', 'follow_sub_type_phone', NULL, NULL, 'N', '0', '100', '2020-11-20 15:31:21', '100', '2020-11-20 15:31:32', NULL);
INSERT INTO `sys_dict_data` VALUES (128, 2, '空号/错号', 'phone_wrong_number', 'follow_sub_type_phone', NULL, NULL, 'N', '0', '100', '2020-11-20 15:31:55', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (129, 3, '号码停机', 'phone_stop_service', 'follow_sub_type_phone', NULL, NULL, 'N', '0', '100', '2020-11-20 15:32:13', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (130, 0, '有回复', 'wechat_has_resp', 'follow_sub_type_wechat', NULL, NULL, 'N', '0', '100', '2020-11-20 15:33:21', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (131, 1, '持续不回复', 'wechat_no_resp', 'follow_sub_type_wechat', NULL, NULL, 'N', '0', '100', '2020-11-20 15:33:34', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (132, 0, '金融', 'finance', 'profession', NULL, NULL, 'N', '0', '100', '2020-11-21 17:10:58', '100', '2020-11-21 17:11:09', NULL);
INSERT INTO `sys_dict_data` VALUES (133, 2, 'C(非优先客户)', 'c', 'crm_customer_level', NULL, NULL, 'N', '0', '100', '2020-11-21 19:36:46', '100', '2020-11-24 11:04:15', NULL);
INSERT INTO `sys_dict_data` VALUES (134, 1, '电信', 'telecom', 'profession', NULL, NULL, 'N', '0', '100', '2020-11-23 14:56:36', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (135, 2, '教育', 'edu', 'profession', NULL, NULL, 'N', '0', '100', '2020-11-23 14:56:49', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (136, 3, '高科技', 'high_tec', 'profession', NULL, NULL, 'N', '0', '100', '2020-11-23 14:57:04', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (137, 4, '政府', 'gov', 'profession', NULL, NULL, 'N', '0', '100', '2020-11-23 14:57:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (138, 5, '制造业', 'manufacturing', 'profession', NULL, NULL, 'N', '0', '100', '2020-11-23 14:58:05', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (139, 6, '服务', 'service', 'profession', NULL, NULL, 'N', '0', '100', '2020-11-23 14:58:21', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (140, 7, '能源', 'energy', 'profession', NULL, NULL, 'N', '0', '100', '2020-11-23 14:58:31', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (141, 8, '零售', 'retail', 'profession', NULL, NULL, 'N', '0', '100', '2020-11-23 14:58:53', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (142, 9, '媒体', 'media', 'profession', NULL, NULL, 'N', '0', '100', '2020-11-23 14:59:08', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (143, 10, '娱乐', 'entertainment', 'profession', NULL, NULL, 'N', '0', '100', '2020-11-23 14:59:41', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (144, 11, '咨询', 'consult', 'profession', NULL, NULL, 'N', '0', '100', '2020-11-23 15:00:34', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (145, 12, '非盈利事业', 'nonprofit', 'profession', NULL, NULL, 'N', '0', '100', '2020-11-23 15:01:19', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (146, 13, '公共事业', 'public', 'profession', NULL, NULL, 'N', '0', '100', '2020-11-23 15:01:33', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (147, 14, '其他', 'other', 'profession', NULL, NULL, 'N', '0', '100', '2020-11-23 15:01:41', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (148, 10, '查询', '10', 'sys_oper_type', NULL, NULL, 'N', '0', '1', '2020-11-24 14:47:47', '1', '2020-11-24 14:54:06', '查询操作');
INSERT INTO `sys_dict_data` VALUES (149, 11, '上传', '11', 'sys_oper_type', NULL, NULL, 'N', '0', '1', '2020-11-24 14:48:28', '', NULL, '上传文件');
INSERT INTO `sys_dict_data` VALUES (233, 1, 'test', 'test', '测试1234567', NULL, NULL, 'N', '0', '1', '2020-11-25 18:48:09', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE KEY `dict_type` (`dict_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4 COMMENT='字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', '1', '2020-11-12 10:10:15', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', '1', '2020-11-12 10:10:15', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', '1', '2020-11-12 10:10:15', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', '1', '2020-11-12 10:10:15', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', '1', '2020-11-12 10:10:15', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', '1', '2020-11-12 10:10:15', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', '1', '2020-11-12 10:10:15', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', '1', '2020-11-12 10:10:15', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', '1', '2020-11-12 10:10:15', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', '1', '2020-11-12 10:10:15', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '线索状态', 'clue_status', '0', '1', '2020-11-17 13:17:43', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (101, '线索来源/客户来源', 'clue_source', '0', '1', '2020-11-17 13:22:10', '1', '2020-11-19 07:55:37', NULL);
INSERT INTO `sys_dict_type` VALUES (102, '客户级别', 'crm_customer_level', '0', '1', '2020-11-18 15:54:57', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (104, '跟进记录类型', 'follow_type', '0', '1', '2020-11-19 07:56:54', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (105, '输单理由', 'lose_reason', '0', '1', '2020-11-19 08:37:00', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (106, '业务类型', 'business_type', '0', '100', '2020-11-20 15:28:53', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (107, '跟进子类型-电话', 'follow_sub_type_phone', '0', '100', '2020-11-20 15:30:28', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (108, '跟进子类型-微信', 'follow_sub_type_wechat', '0', '100', '2020-11-20 15:32:54', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (109, '行业', 'profession', '0', '100', '2020-11-21 17:10:29', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (112, '测试1234567', '测试1234567', '0', '1', '2020-11-25 18:45:26', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `login_by` bigint(20) DEFAULT NULL COMMENT '登录UID',
  `ipaddr` varchar(50) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(1024) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户ID',
  PRIMARY KEY (`info_id`) USING BTREE,
  KEY `idx_loginBy` (`login_by`) USING BTREE COMMENT 'UID索引'
) ENGINE=InnoDB AUTO_INCREMENT=816 DEFAULT CHARSET=utf8mb4 COMMENT='系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `is_frame` int(1) DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `tenant_visible` char(1) DEFAULT NULL COMMENT '租户可见',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2014 DEFAULT CHARSET=utf8mb4 COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 11, 'system', NULL, 1, 0, 'M', '0', '0', '1', '', 'system', '1', '2020-11-12 10:10:14', '1', '2020-11-17 20:27:55', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 12, 'monitor', NULL, 1, 0, 'M', '0', '0', '0', '', 'monitor', '1', '2020-11-12 10:10:14', '100', '2020-11-30 10:09:54', '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 13, 'tool', NULL, 1, 0, 'M', '1', '1', '0', '', 'tool', '1', '2020-11-12 10:10:14', '122', '2020-11-25 19:20:04', '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', 1, 0, 'C', '0', '0', '1', 'system:user:list', 'user', '1', '2020-11-12 10:10:14', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', 1, 0, 'C', '0', '0', '1', 'system:role:list', 'peoples', '1', '2020-11-12 10:10:14', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', 1, 0, 'C', '0', '0', '0', 'system:menu:list', 'tree-table', '1', '2020-11-12 10:10:14', '122', '2020-11-25 19:21:25', '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', 1, 0, 'C', '0', '0', '1', 'system:dept:list', 'tree', '1', '2020-11-12 10:10:14', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', 1, 0, 'C', '0', '0', '1', 'system:post:list', 'post', '1', '2020-11-12 10:10:14', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', 1, 0, 'C', '0', '0', '0', 'system:dict:list', 'dict', '1', '2020-11-12 10:10:14', '122', '2020-11-25 19:21:29', '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', 1, 0, 'C', '0', '0', '0', 'system:config:list', 'edit', '1', '2020-11-12 10:10:14', '122', '2020-11-25 19:21:33', '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', 1, 0, 'C', '0', '0', '0', 'system:notice:list', 'message', '1', '2020-11-12 10:10:14', '122', '2020-11-25 19:21:37', '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', 'system/log/index', 1, 0, 'M', '0', '0', '0', '', 'log', '1', '2020-11-12 10:10:14', '122', '2020-11-25 19:21:42', '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', 1, 0, 'C', '0', '0', '0', 'monitor:online:list', 'online', '1', '2020-11-12 10:10:14', '122', '2020-11-25 19:21:01', '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', 1, 0, 'C', '0', '0', '0', 'monitor:job:list', 'job', '1', '2020-11-12 10:10:14', '122', '2020-11-25 19:21:06', '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', 1, 0, 'C', '0', '0', '0', 'monitor:druid:list', 'druid', '1', '2020-11-12 10:10:14', '122', '2020-11-25 19:21:10', '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', 1, 0, 'C', '0', '0', '0', 'monitor:server:list', 'server', '1', '2020-11-12 10:10:14', '122', '2020-11-25 19:21:13', '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '表单构建', 3, 1, 'build', 'tool/build/index', 1, 0, 'C', '0', '0', '0', 'tool:build:list', 'build', '1', '2020-11-12 10:10:14', '122', '2020-11-25 19:20:13', '表单构建菜单');
INSERT INTO `sys_menu` VALUES (114, '代码生成', 3, 2, 'gen', 'tool/gen/index', 1, 0, 'C', '0', '0', '0', 'tool:gen:list', 'code', '1', '2020-11-12 10:10:14', '122', '2020-11-25 19:20:17', '代码生成菜单');
INSERT INTO `sys_menu` VALUES (115, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', 1, 0, 'C', '0', '0', '0', 'tool:swagger:list', 'swagger', '1', '2020-11-12 10:10:14', '122', '2020-11-25 19:20:21', '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', 1, 0, 'C', '0', '0', '0', 'monitor:operlog:list', 'form', '1', '2020-11-12 10:10:14', '1', '2020-11-25 20:29:40', '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', 1, 0, 'C', '0', '0', '0', 'monitor:logininfor:list', 'logininfor', '1', '2020-11-12 10:10:14', '1', '2020-11-25 20:29:44', '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', 1, 0, 'F', '0', '0', '1', 'system:user:query', '#', '1', '2020-11-12 10:10:14', '1', '2020-11-25 20:25:49', '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', 1, 0, 'F', '0', '0', '1', 'system:user:add', '#', '1', '2020-11-12 10:10:14', '1', '2020-11-25 20:25:52', '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', 1, 0, 'F', '0', '0', '1', 'system:user:edit', '#', '1', '2020-11-12 10:10:14', '1', '2020-11-25 20:25:56', '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', 1, 0, 'F', '0', '0', '1', 'system:user:remove', '#', '1', '2020-11-12 10:10:14', '1', '2020-11-25 20:26:00', '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', 1, 0, 'F', '0', '0', '1', 'system:user:export', '#', '1', '2020-11-12 10:10:14', '1', '2020-11-25 20:26:04', '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', 1, 0, 'F', '0', '0', '1', 'system:user:import', '#', '1', '2020-11-12 10:10:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', 1, 0, 'F', '0', '0', '1', 'system:user:resetPwd', '#', '1', '2020-11-12 10:10:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', 1, 0, 'F', '0', '0', '1', 'system:role:query', '#', '1', '2020-11-12 10:10:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', 1, 0, 'F', '0', '0', '1', 'system:role:add', '#', '1', '2020-11-12 10:10:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', 1, 0, 'F', '0', '0', '1', 'system:role:edit', '#', '1', '2020-11-12 10:10:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', 1, 0, 'F', '0', '0', '1', 'system:role:remove', '#', '1', '2020-11-12 10:10:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', 1, 0, 'F', '0', '0', '1', 'system:role:export', '#', '1', '2020-11-12 10:10:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', 1, 0, 'F', '0', '0', '0', 'system:menu:query', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:26:16', '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', 1, 0, 'F', '0', '0', '0', 'system:menu:add', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:26:20', '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', 1, 0, 'F', '0', '0', '0', 'system:menu:edit', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:26:25', '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', 1, 0, 'F', '0', '0', '0', 'system:menu:remove', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:26:29', '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', 1, 0, 'F', '0', '0', '1', 'system:dept:query', '#', '1', '2020-11-12 10:10:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', 1, 0, 'F', '0', '0', '1', 'system:dept:add', '#', '1', '2020-11-12 10:10:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', 1, 0, 'F', '0', '0', '1', 'system:dept:edit', '#', '1', '2020-11-12 10:10:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', 1, 0, 'F', '0', '0', '1', 'system:dept:remove', '#', '1', '2020-11-12 10:10:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', 1, 0, 'F', '0', '0', '1', 'system:post:query', '#', '1', '2020-11-12 10:10:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', 1, 0, 'F', '0', '0', '1', 'system:post:add', '#', '1', '2020-11-12 10:10:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', 1, 0, 'F', '0', '0', '1', 'system:post:edit', '#', '1', '2020-11-12 10:10:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', 1, 0, 'F', '0', '0', '1', 'system:post:remove', '#', '1', '2020-11-12 10:10:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', 1, 0, 'F', '0', '0', '1', 'system:post:export', '#', '1', '2020-11-12 10:10:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典查询', 105, 1, '#', '', 1, 0, 'F', '0', '0', '0', 'system:dict:query', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:26:36', '');
INSERT INTO `sys_menu` VALUES (1027, '字典新增', 105, 2, '#', '', 1, 0, 'F', '0', '0', '0', 'system:dict:add', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:26:40', '');
INSERT INTO `sys_menu` VALUES (1028, '字典修改', 105, 3, '#', '', 1, 0, 'F', '0', '0', '0', 'system:dict:edit', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:26:44', '');
INSERT INTO `sys_menu` VALUES (1029, '字典删除', 105, 4, '#', '', 1, 0, 'F', '0', '0', '0', 'system:dict:remove', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:26:47', '');
INSERT INTO `sys_menu` VALUES (1030, '字典导出', 105, 5, '#', '', 1, 0, 'F', '0', '0', '0', 'system:dict:export', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:26:50', '');
INSERT INTO `sys_menu` VALUES (1031, '参数查询', 106, 1, '#', '', 1, 0, 'F', '0', '0', '0', 'system:config:query', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:26:56', '');
INSERT INTO `sys_menu` VALUES (1032, '参数新增', 106, 2, '#', '', 1, 0, 'F', '0', '0', '0', 'system:config:add', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:30:07', '');
INSERT INTO `sys_menu` VALUES (1033, '参数修改', 106, 3, '#', '', 1, 0, 'F', '0', '0', '0', 'system:config:edit', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:26:59', '');
INSERT INTO `sys_menu` VALUES (1034, '参数删除', 106, 4, '#', '', 1, 0, 'F', '0', '0', '0', 'system:config:remove', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:27:03', '');
INSERT INTO `sys_menu` VALUES (1035, '参数导出', 106, 5, '#', '', 1, 0, 'F', '0', '0', '0', 'system:config:export', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:27:06', '');
INSERT INTO `sys_menu` VALUES (1036, '公告查询', 107, 1, '#', '', 1, 0, 'F', '0', '0', '0', 'system:notice:query', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:27:12', '');
INSERT INTO `sys_menu` VALUES (1037, '公告新增', 107, 2, '#', '', 1, 0, 'F', '0', '0', '0', 'system:notice:add', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:27:15', '');
INSERT INTO `sys_menu` VALUES (1038, '公告修改', 107, 3, '#', '', 1, 0, 'F', '0', '0', '0', 'system:notice:edit', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:27:18', '');
INSERT INTO `sys_menu` VALUES (1039, '公告删除', 107, 4, '#', '', 1, 0, 'F', '0', '0', '0', 'system:notice:remove', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:27:21', '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', 1, 0, 'F', '0', '0', '0', 'monitor:operlog:query', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:27:27', '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', 1, 0, 'F', '0', '0', '0', 'monitor:operlog:remove', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:27:30', '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', 1, 0, 'F', '0', '0', '0', 'monitor:operlog:export', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:27:33', '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', 1, 0, 'F', '0', '0', '0', 'monitor:logininfor:query', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:27:37', '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', 1, 0, 'F', '0', '0', '0', 'monitor:logininfor:remove', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:27:40', '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', 1, 0, 'F', '0', '0', '0', 'monitor:logininfor:export', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:27:43', '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', 1, 0, 'F', '0', '0', '0', 'monitor:online:query', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:27:50', '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', 1, 0, 'F', '0', '0', '0', 'monitor:online:batchLogout', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:27:53', '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', 1, 0, 'F', '0', '0', '0', 'monitor:online:forceLogout', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:27:55', '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', 1, 0, 'F', '0', '0', '0', 'monitor:job:query', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:28:00', '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', 1, 0, 'F', '0', '0', '0', 'monitor:job:add', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:28:06', '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', 1, 0, 'F', '0', '0', '0', 'monitor:job:edit', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:28:03', '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', 1, 0, 'F', '0', '0', '0', 'monitor:job:remove', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:30:21', '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', 1, 0, 'F', '0', '0', '0', 'monitor:job:changeStatus', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:28:10', '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 7, '#', '', 1, 0, 'F', '0', '0', '0', 'monitor:job:export', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:28:16', '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 114, 1, '#', '', 1, 0, 'F', '0', '0', '0', 'tool:gen:query', '#', '1', '2020-11-12 10:10:15', '122', '2020-11-25 19:20:29', '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 114, 2, '#', '', 1, 0, 'F', '0', '0', '0', 'tool:gen:edit', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:28:30', '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 114, 3, '#', '', 1, 0, 'F', '0', '0', '0', 'tool:gen:remove', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:28:33', '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 114, 2, '#', '', 1, 0, 'F', '0', '0', '0', 'tool:gen:import', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:28:26', '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 114, 4, '#', '', 1, 0, 'F', '0', '0', '0', 'tool:gen:preview', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:28:36', '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 114, 5, '#', '', 1, 0, 'F', '0', '0', '0', 'tool:gen:code', '#', '1', '2020-11-12 10:10:15', '1', '2020-11-25 20:28:39', '');
INSERT INTO `sys_menu` VALUES (2000, '线索管理', 0, 2, 'clue/manage', 'crm/clue/manage', 1, 0, 'C', '0', '0', '1', 'crm:clue:manage', 'list', '1', '2020-11-17 10:49:36', '1', '2020-11-25 16:44:05', '');
INSERT INTO `sys_menu` VALUES (2001, '线索详情', 0, 2, 'clue/detail/:id(\\d+)', 'crm/clue/detail', 1, 0, 'C', '1', '0', '1', 'crm:clue:detail', 'list', '1', '2020-11-17 10:53:21', '1', '2020-11-25 17:31:55', '');
INSERT INTO `sys_menu` VALUES (2002, '客户管理', 0, 3, 'customer/manage', 'crm/customer/manage', 1, 0, 'C', '0', '0', '1', 'crm:customer:manage', 'user', '1', '2020-11-17 20:27:04', '1', '2020-11-17 20:27:18', '');
INSERT INTO `sys_menu` VALUES (2003, '客户详情', 0, 3, 'customer/detail/:id(\\d+)', 'crm/customer/detail', 1, 0, 'C', '1', '0', '1', 'crm:customer:detail', 'user', '1', '2020-11-17 20:28:45', '100', '2020-11-20 01:48:14', '');
INSERT INTO `sys_menu` VALUES (2004, '联系人管理', 0, 4, 'contact/manage', 'crm/contact/manage', 1, 0, 'C', '0', '0', '1', 'crm:contact:manage', 'peoples', '100', '2020-11-18 21:44:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '商机管理', 0, 5, 'business/manage', 'crm/business/manage', 1, 0, 'C', '0', '0', '1', 'crm:business:manage', 'money', '1', '2020-11-18 21:46:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '联系人详情', 0, 4, 'contact/detail/:id(\\d+)', 'crm/contact/detail', 1, 0, 'C', '1', '0', '1', 'crm:contact:detail', 'peoples', '1', '2020-11-18 21:47:07', '100', '2020-11-19 00:49:27', '');
INSERT INTO `sys_menu` VALUES (2007, '商机详情', 0, 5, 'business/detail/:id(\\d+)', 'crm/business/detail', 1, 0, 'C', '1', '0', '1', 'crm:business:detail', 'money', '1', '2020-11-18 21:47:37', '100', '2020-11-19 00:49:20', '');
INSERT INTO `sys_menu` VALUES (2008, '跟进记录', 0, 6, 'follow/manage', 'crm/follow/manage', 1, 0, 'C', '0', '0', '1', 'crm:follow:manage', 'edit', '1', '2020-11-21 19:18:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '租户管理', 1, 0, 'tenant', 'system/tenant/index', 1, 0, 'C', '0', '0', '0', 'system:tenant:list', 'cascader', '100', '2020-11-24 16:00:10', '122', '2020-11-25 19:21:19', '');
COMMIT;

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE,
  KEY `idx_notice_id` (`notice_id`) USING BTREE COMMENT '通知ID索引'
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COMMENT='通知公告表';

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(50) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `json_result` text COMMENT '返回参数',
  `status` int(1) DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户ID',
  PRIMARY KEY (`oper_id`) USING BTREE,
  KEY `idx_oper_id` (`oper_id`) USING BTREE COMMENT '日志ID索引'
) ENGINE=InnoDB AUTO_INCREMENT=5335 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE,
  KEY `idx_pos_id` (`post_id`) USING BTREE COMMENT '岗位ID索引'
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COMMENT='岗位信息表';

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE,
  KEY `idx_role_id` (`role_id`) USING BTREE COMMENT '角色ID索引'
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8mb4 COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` VALUES (183, '超级管理员', 'admin', 0, '1', 0, 0, '0', 1, '0', '', '2020-11-30 11:56:29', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`role_id`,`dept_id`) USING BTREE,
  KEY `idx_role_id` (`role_id`) USING BTREE COMMENT '角色ID索引',
  KEY `idx_dept_id` (`dept_id`) USING BTREE COMMENT '部门ID索引',
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE COMMENT '租户ID索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_dept` VALUES (183, 287, 1);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE,
  KEY `idx_role_id` (`role_id`) USING BTREE COMMENT '角色ID索引',
  KEY `idx_menu_id` (`menu_id`) USING BTREE COMMENT '菜单ID索引',
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE COMMENT '租户ID索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` VALUES (183, 1, 1);
INSERT INTO `sys_role_menu` VALUES (183, 2, 1);
INSERT INTO `sys_role_menu` VALUES (183, 3, 1);
INSERT INTO `sys_role_menu` VALUES (183, 100, 1);
INSERT INTO `sys_role_menu` VALUES (183, 101, 1);
INSERT INTO `sys_role_menu` VALUES (183, 102, 1);
INSERT INTO `sys_role_menu` VALUES (183, 103, 1);
INSERT INTO `sys_role_menu` VALUES (183, 104, 1);
INSERT INTO `sys_role_menu` VALUES (183, 105, 1);
INSERT INTO `sys_role_menu` VALUES (183, 106, 1);
INSERT INTO `sys_role_menu` VALUES (183, 107, 1);
INSERT INTO `sys_role_menu` VALUES (183, 108, 1);
INSERT INTO `sys_role_menu` VALUES (183, 109, 1);
INSERT INTO `sys_role_menu` VALUES (183, 110, 1);
INSERT INTO `sys_role_menu` VALUES (183, 111, 1);
INSERT INTO `sys_role_menu` VALUES (183, 112, 1);
INSERT INTO `sys_role_menu` VALUES (183, 113, 1);
INSERT INTO `sys_role_menu` VALUES (183, 114, 1);
INSERT INTO `sys_role_menu` VALUES (183, 115, 1);
INSERT INTO `sys_role_menu` VALUES (183, 500, 1);
INSERT INTO `sys_role_menu` VALUES (183, 501, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1001, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1002, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1003, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1004, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1005, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1006, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1007, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1008, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1009, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1010, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1011, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1012, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1013, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1014, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1015, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1016, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1017, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1018, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1019, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1020, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1021, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1022, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1023, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1024, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1025, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1026, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1027, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1028, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1029, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1030, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1031, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1032, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1033, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1034, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1035, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1036, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1037, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1038, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1039, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1040, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1041, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1042, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1043, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1044, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1045, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1046, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1047, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1048, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1049, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1050, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1051, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1052, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1053, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1054, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1055, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1056, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1057, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1058, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1059, 1);
INSERT INTO `sys_role_menu` VALUES (183, 1060, 1);
INSERT INTO `sys_role_menu` VALUES (183, 2000, 1);
INSERT INTO `sys_role_menu` VALUES (183, 2001, 1);
INSERT INTO `sys_role_menu` VALUES (183, 2002, 1);
INSERT INTO `sys_role_menu` VALUES (183, 2003, 1);
INSERT INTO `sys_role_menu` VALUES (183, 2004, 1);
INSERT INTO `sys_role_menu` VALUES (183, 2005, 1);
INSERT INTO `sys_role_menu` VALUES (183, 2006, 1);
INSERT INTO `sys_role_menu` VALUES (183, 2007, 1);
INSERT INTO `sys_role_menu` VALUES (183, 2008, 1);
INSERT INTO `sys_role_menu` VALUES (183, 2011, 1);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_ids` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) DEFAULT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(50) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE COMMENT '用户ID索引',
  KEY `idx_phone` (`phonenumber`) USING BTREE COMMENT '手机号索引'
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES (1, NULL, '18888888888', 'admin', '00', '', '18888888888', '0', '', '$2a$10$HR5NGyB1qyzx9cyXtKvGlOHYtN1JRhxZ2OGmLgxhkZPCswKR5eMx.', '0', '0', '', NULL, '-1', '2020-11-30 11:56:29', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`user_id`,`post_id`,`tenant_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE COMMENT '用户ID索引',
  KEY `idx_post_id` (`post_id`) USING BTREE COMMENT '岗位ID索引',
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE COMMENT '租户ID索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户与岗位关联表';

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE COMMENT '用户ID索引',
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE COMMENT '租户ID索引',
  KEY `idx_role_id` (`role_id`) USING BTREE COMMENT '角色ID索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_role` VALUES (1, 183, 1);
COMMIT;

-- ----------------------------
-- Table structure for t_areas
-- ----------------------------
DROP TABLE IF EXISTS `t_areas`;
CREATE TABLE `t_areas` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `area_id` bigint(11) NOT NULL,
  `area_code` bigint(11) DEFAULT NULL,
  `area_name` varchar(50) NOT NULL,
  `level` int(11) DEFAULT NULL,
  `parent_id` int(11) unsigned DEFAULT NULL,
  `parent_name` varchar(50) DEFAULT NULL COMMENT '父域名称',
  `root_id` bigint(20) DEFAULT NULL COMMENT '根域id',
  `root_name` varchar(50) DEFAULT NULL COMMENT '根域名称',
  `area_status` tinyint(1) NOT NULL DEFAULT '0',
  `zipcode` varchar(6) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_area_id` (`area_id`) USING BTREE,
  KEY `idx_parent_id` (`parent_id`) USING BTREE,
  KEY `idx_area_name` (`area_name`) USING BTREE,
  KEY `idx_area_code` (`area_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=44964 DEFAULT CHARSET=utf8mb4 COMMENT='地区信息';

-- ----------------------------
-- Records of t_areas
-- ----------------------------
BEGIN;
INSERT INTO `t_areas` VALUES (218, 218, NULL, '省直辖县级行政单位', 2, 18, '湖北', NULL, NULL, 30, '0', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (269, 269, NULL, '省直辖县级行政单位', 2, 22, '海南', NULL, NULL, 30, '0', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (376, 376, NULL, '省直辖县级行政单位', 2, 32, '新疆', NULL, NULL, 30, '0', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (379, 379, NULL, '崇文区', 3, 36, '北京市', 2, '北京', 30, '100000', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (380, 380, NULL, '宣武区', 3, 36, '北京市', 2, '北京', 30, '100000', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (401, 401, NULL, '塘沽区', 3, 37, '天津市', 3, '天津', 30, '300450', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (402, 402, NULL, '汉沽区', 3, 37, '天津市', 3, '天津', 30, '300480', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (403, 403, NULL, '大港区', 3, 37, '天津市', 3, '天津', 30, '300270', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (413, 413, NULL, '保税区', 3, 37, '天津市', 3, '天津', 30, '300308', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (414, 414, NULL, '经济技术开发区', 3, 37, '天津市', 3, '天津', 30, '300457', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (415, 415, NULL, '高新区', 3, 37, '天津市', 3, '天津', 30, '300384', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (418, 418, 130502, '桥东区', 3, 38, '石家庄市', 4, '河北', 30, '050011', '2020-06-09 20:03:17', '2020-08-06 23:50:28', 0);
INSERT INTO `t_areas` VALUES (440, 440, NULL, '高新技术开发区', 3, 38, '石家庄市', 4, '河北', 30, '050035', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (447, 447, NULL, '滦县', 3, 39, '唐山市', 4, '河北', 30, '063700', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (455, 455, NULL, '高新区', 3, 39, '唐山市', 4, '河北', 30, '063020', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (456, 456, NULL, '汉沽管理区', 3, 39, '唐山市', 4, '河北', 30, '301501', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (457, 457, NULL, '海港区', 3, 39, '唐山市', 4, '河北', 30, '063600', '2020-06-09 20:03:17', '2020-08-06 23:47:11', 0);
INSERT INTO `t_areas` VALUES (458, 458, NULL, '芦台开发区', 3, 39, '唐山市', 4, '河北', 30, '301501', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (459, 459, NULL, '南堡开发区', 3, 39, '唐山市', 4, '河北', 30, '063305', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (460, 460, 130209, '曹妃甸区', 3, 39, '唐山市', 4, '河北省', 30, '063200', '2020-06-09 20:03:17', '2020-08-11 01:57:14', 0);
INSERT INTO `t_areas` VALUES (468, 468, NULL, '经济技术开发区', 3, 40, '秦皇岛市', 4, '河北', 30, '066004', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (473, 473, NULL, '邯郸县', 3, 41, '邯郸市', 4, '河北', 30, '056100', '2020-06-09 20:03:17', '2020-08-06 23:49:32', 0);
INSERT INTO `t_areas` VALUES (488, 488, NULL, '经济开发区', 3, 41, '邯郸市', 4, '河北', 30, '056002', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (491, 491, 130521, '邢台县', 3, 42, '邢台市', 4, '河北', 30, '054001', '2020-06-09 20:03:17', '2020-08-03 23:17:04', 0);
INSERT INTO `t_areas` VALUES (496, 496, NULL, '任县', 3, 42, '邢台市', 4, '河北', 30, '055150', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (508, 508, NULL, '新市区', 3, 43, '保定市', 4, '河北', 30, '071052', '2020-06-09 20:03:17', '2020-08-07 00:47:04', 0);
INSERT INTO `t_areas` VALUES (509, 509, NULL, '南市区', 3, 43, '保定市', 4, '河北', 30, '071000', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (510, 510, NULL, '北市区', 3, 43, '保定市', 4, '河北', 30, '071000', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (537, 537, NULL, '宣化县', 3, 44, '张家口市', 4, '河北', 30, '075100', '2020-06-09 20:03:17', '2020-08-06 23:51:44', 0);
INSERT INTO `t_areas` VALUES (587, 587, NULL, '开发区', 3, 47, '廊坊市', 4, '河北', 30, '065001', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (609, 609, NULL, '城区', 3, 50, '大同市', 5, '山西', 30, '037008', '2020-06-09 20:03:17', '2020-08-06 23:58:55', 0);
INSERT INTO `t_areas` VALUES (610, 610, NULL, '矿区', 3, 50, '大同市', 5, '山西', 30, '037001', '2020-06-09 20:03:17', '2020-08-07 00:00:30', 0);
INSERT INTO `t_areas` VALUES (611, 611, NULL, '南郊区', 3, 50, '大同市', 5, '山西', 30, '037001', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (619, 619, NULL, '大同县', 3, 50, '大同市', 5, '山西', 30, '037300', '2020-06-09 20:03:17', '2020-08-07 00:32:35', 0);
INSERT INTO `t_areas` VALUES (625, 625, NULL, '城区', 3, 52, '长治市', 5, '山西', 30, '046011', '2020-06-09 20:03:17', '2020-08-06 23:59:13', 0);
INSERT INTO `t_areas` VALUES (626, 626, NULL, '郊区', 3, 52, '长治市', 5, '山西', 30, '046011', '2020-06-09 20:03:17', '2020-08-07 00:39:30', 0);
INSERT INTO `t_areas` VALUES (627, 627, NULL, '长治县', 3, 52, '长治市', 5, '山西', 30, '047100', '2020-06-09 20:03:17', '2020-08-07 00:00:51', 0);
INSERT INTO `t_areas` VALUES (751, 751, NULL, '新城区', 3, 63, '赤峰市', 6, '内蒙古', 30, '025350', '2020-06-09 20:03:17', '2020-08-07 00:46:58', 0);
INSERT INTO `t_areas` VALUES (826, 826, NULL, '东陵区', 3, 72, '沈阳市', 7, '辽宁', 30, '110015', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (833, 833, NULL, '经济技术开发区', 3, 72, '沈阳市', 7, '辽宁', 30, '110141', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (835, 835, NULL, '新城经济技术开发区', 3, 72, '沈阳市', 7, '辽宁', 30, '110121', '2020-06-09 20:03:17', '2020-08-07 00:26:09', 0);
INSERT INTO `t_areas` VALUES (844, 844, NULL, '普兰县', 3, 73, '大连市', 7, '辽宁', 30, '116200', '2020-06-09 20:03:17', '2020-08-07 00:46:56', 0);
INSERT INTO `t_areas` VALUES (846, 846, NULL, '开发区', 3, 73, '大连市', 7, '辽宁', 30, '116600', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (847, 847, NULL, '保税区', 3, 73, '大连市', 7, '辽宁', 30, '116600', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (880, 880, NULL, '北宁市', 3, 78, '锦州市', 7, '辽宁', 30, '121300', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (881, 881, NULL, '松山新区', 3, 78, '锦州市', 7, '辽宁', 30, '121219', '2020-06-09 20:03:17', '2020-08-07 00:26:48', 0);
INSERT INTO `t_areas` VALUES (882, 882, NULL, '经济技术开发区', 3, 78, '锦州市', 7, '辽宁', 30, '121007', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (937, 937, NULL, '净月经济开发区', 3, 86, '长春市', 8, '吉林', 30, '130117', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (938, 938, NULL, '高新技术产业开发区', 3, 86, '长春市', 8, '吉林', 30, '130015', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (965, 965, NULL, '八道江区', 3, 91, '白山市', 8, '吉林', 30, '134300', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (993, 993, NULL, '动力区', 3, 95, '哈尔滨市', 9, '黑龙江', 30, '150040', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1058, 1058, NULL, '伊春区', 3, 101, '伊春市', 9, '黑龙江', 30, '153000', '2020-06-09 20:03:17', '2020-08-07 00:35:06', 0);
INSERT INTO `t_areas` VALUES (1061, 1061, NULL, '西林县', 3, 101, '伊春市', 9, '黑龙江', 30, '153025', '2020-06-09 20:03:17', '2020-08-07 00:46:17', 0);
INSERT INTO `t_areas` VALUES (1062, 1062, NULL, '翠峦区', 3, 101, '伊春市', 9, '黑龙江', 30, '153013', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1063, 1063, NULL, '新青区', 3, 101, '伊春市', 9, '黑龙江', 30, '153036', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1064, 1064, NULL, '美溪区', 3, 101, '伊春市', 9, '黑龙江', 30, '153021', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1065, 1065, NULL, '金山屯区', 3, 101, '伊春市', 9, '黑龙江', 30, '153026', '2020-06-09 20:03:17', '2020-08-07 00:35:53', 0);
INSERT INTO `t_areas` VALUES (1066, 1066, NULL, '五营区', 3, 101, '伊春市', 9, '黑龙江', 30, '153033', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1067, 1067, NULL, '乌马河区', 3, 101, '伊春市', 9, '黑龙江', 30, '153011', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1069, 1069, NULL, '带岭区', 3, 101, '伊春市', 9, '黑龙江', 30, '153106', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1070, 1070, NULL, '乌伊岭区', 3, 101, '伊春市', 9, '黑龙江', 30, '153038', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1071, 1071, NULL, '红星区', 3, 101, '伊春市', 9, '黑龙江', 30, '153035', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1072, 1072, NULL, '上甘岭区', 3, 101, '伊春市', 9, '黑龙江', 30, '153032', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1119, 1119, NULL, '松岭区', 3, 107, '大兴安岭地区', 9, '黑龙江', 30, '165012', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1120, 1120, NULL, '新林区', 3, 107, '大兴安岭地区', 9, '黑龙江', 30, '165023', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1121, 1121, NULL, '呼中区', 3, 107, '大兴安岭地区', 9, '黑龙江', 30, '165036', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1123, 1123, NULL, '卢湾区', 3, 108, '上海市', 10, '上海', 30, '200020', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1128, 1128, NULL, '闸北区', 3, 108, '上海市', 10, '上海', 30, '200070', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1138, 1138, NULL, '南汇区', 3, 108, '上海市', 10, '上海', 30, '201300', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1142, 1142, NULL, '白下区', 3, 109, '南京市', 11, '江苏', 30, '210000', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1146, 1146, NULL, '下关区', 3, 109, '南京市', 11, '江苏', 30, '210000', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1154, 1154, NULL, '崇安区', 3, 110, '无锡市', 11, '江苏', 30, '214002', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1155, 1155, NULL, '南长区', 3, 110, '无锡市', 11, '江苏', 30, '214021', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1156, 1156, NULL, '北塘区', 3, 110, '无锡市', 11, '江苏', 30, '214044', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1162, 1162, NULL, '新区', 3, 110, '无锡市', 11, '江苏', 30, '214028', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1165, 1165, NULL, '九里区', 3, 111, '徐州市', 11, '江苏', 30, '221140', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1176, 1176, NULL, '戚墅堰区', 3, 112, '常州市', 11, '江苏', 30, '213011', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1181, 1181, NULL, '沧浪区', 3, 113, '苏州市', 11, '江苏', 30, '215006', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1182, 1182, NULL, '平江县', 3, 113, '苏州市', 11, '江苏', 30, '215005', '2020-06-09 20:03:17', '2020-08-07 00:44:50', 0);
INSERT INTO `t_areas` VALUES (1183, 1183, NULL, '金阊区', 3, 113, '苏州市', 11, '江苏', 30, '215008', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1192, 1192, NULL, '工业园区', 4, 2063, '仙桃市', 18, '湖北省', 30, '215028', '2020-06-09 20:03:17', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (1193, 1193, NULL, '高新区', 3, 113, '苏州市', 11, '江苏', 30, '215011', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1202, 1202, NULL, '经济技术开发区', 3, 114, '南通市', 11, '江苏', 30, '226009', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1204, 1204, NULL, '新浦区', 3, 115, '连云港市', 11, '江苏', 30, '222003', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1210, 1210, NULL, '清河区', 3, 116, '淮安市', 11, '江苏', 30, '223001', '2020-06-09 20:03:17', '2020-08-07 00:29:44', 0);
INSERT INTO `t_areas` VALUES (1211, 1211, NULL, '楚州区', 3, 116, '淮安市', 11, '江苏', 30, '223200', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1213, 1213, NULL, '清浦区', 3, 116, '淮安市', 11, '江苏', 30, '223002', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1233, 1233, NULL, '维扬区', 3, 118, '扬州市', 11, '江苏', 30, '225002', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1234, 1234, NULL, '经济开发区', 3, 118, '扬州市', 11, '江苏', 30, '225101', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1241, 1241, NULL, '新区', 3, 119, '镇江市', 11, '江苏', 30, '212132', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1267, 1267, NULL, '江东区', 3, 123, '宁波市', 12, '浙江', 30, '315040', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1277, 1277, NULL, '国家高新区', 3, 123, '宁波市', 12, '浙江', 30, '315040', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1302, 1302, NULL, '绍兴县', 3, 127, '绍兴市', 12, '浙江', 30, '312000', '2020-06-09 20:03:17', '2020-08-07 00:37:20', 0);
INSERT INTO `t_areas` VALUES (1351, 1351, NULL, '经济技术开发区', 3, 133, '合肥市', 13, '安徽', 30, '230601', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1352, 1352, NULL, '新站试验区', 3, 133, '合肥市', 13, '安徽', 30, '230011', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1353, 1353, NULL, '政务文化新区', 3, 133, '合肥市', 13, '安徽', 30, '230066', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1354, 1354, NULL, '高新技术产业开发区', 3, 133, '合肥市', 13, '安徽', 30, '230088', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1377, 1377, NULL, '金家庄区', 3, 137, '马鞍山市', 13, '安徽', 30, '243021', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1379, 1379, NULL, '经济技术开发区', 3, 137, '马鞍山市', 13, '安徽', 30, '243041', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1385, 1385, NULL, '狮子山区', 3, 139, '铜陵市', 13, '安徽', 30, '244000', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1387, 1387, NULL, '铜陵县', 3, 139, '铜陵市', 13, '安徽', 30, '244100', '2020-06-09 20:03:17', '2020-08-07 00:37:39', 0);
INSERT INTO `t_areas` VALUES (1422, 1422, NULL, '经济开发区', 3, 143, '阜阳市', 13, '安徽', 30, '236112', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1428, 1428, NULL, '居巢区', 3, 145, '巢湖市', 13, '安徽', 30, '238000', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1474, 1474, NULL, '鼓浪屿区', 3, 151, '厦门市', 14, '福建', 30, '361002', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1475, 1475, NULL, '象屿保税区', 3, 151, '厦门市', 14, '福建', 30, '361006', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1476, 1476, NULL, '火炬高新区', 3, 151, '厦门市', 14, '福建', 30, '361006', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1506, 1506, NULL, '经济技术开发区', 3, 154, '泉州市', 14, '福建', 30, '362005', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1547, 1547, NULL, '湾里区', 3, 159, '南昌市', 15, '江西', 30, '330004', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1553, 1553, NULL, '经济技术开发区', 3, 159, '南昌市', 15, '江西', 30, '330013', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1555, 1555, NULL, '高新技术产业开发区', 3, 159, '南昌市', 15, '江西', 30, '330029', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1556, 1556, NULL, '桑海经济技术开发区', 3, 159, '南昌市', 15, '江西', 30, '330115', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1557, 1557, NULL, '英雄经济开发区', 3, 159, '南昌市', 15, '江西', 30, '330200', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1569, 1569, NULL, '九江县', 3, 162, '九江市', 15, '江西', 30, '332100', '2020-06-09 20:03:17', '2020-08-07 00:40:02', 0);
INSERT INTO `t_areas` VALUES (1574, 1574, NULL, '星子县', 3, 162, '九江市', 15, '江西', 30, '332800', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1638, 1638, NULL, '上饶县', 3, 169, '上饶市', 15, '江西', 30, '334100', '2020-06-09 20:03:17', '2020-08-07 00:41:15', 0);
INSERT INTO `t_areas` VALUES (1659, 1659, NULL, '高新区', 3, 170, '济南市', 16, '山东', 30, '250101', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1660, 1660, NULL, '经济开发区', 3, 170, '济南市', 16, '山东', 30, '250300', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1663, 1663, NULL, '四方台区', 3, 171, '青岛市', 16, '山东', 30, '266031', '2020-06-09 20:03:17', '2020-08-07 00:31:38', 0);
INSERT INTO `t_areas` VALUES (1671, 1671, NULL, '胶南市', 3, 171, '青岛市', 16, '山东', 30, '266400', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1681, 1681, NULL, '高新区', 3, 172, '淄博市', 16, '山东', 30, '255086', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1697, 1697, NULL, '长岛县', 3, 175, '烟台市', 16, '山东', 30, '265800', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1705, 1705, NULL, '开发区', 3, 175, '烟台市', 16, '山东', 30, '264006', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1718, 1718, NULL, '经济开发区', 3, 176, '潍坊市', 16, '山东', 30, '261061', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1719, 1719, NULL, '滨海经济开发区', 3, 176, '潍坊市', 16, '山东', 30, '262737', '2020-06-09 20:03:17', '2020-08-07 00:36:56', 0);
INSERT INTO `t_areas` VALUES (1720, 1720, NULL, '高新技术开发区', 3, 176, '潍坊市', 16, '山东', 30, '261061', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1721, 1721, NULL, '出口加工区', 3, 176, '潍坊市', 16, '山东', 30, '261205', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1722, 1722, NULL, '市中区', 3, 177, '济宁市', 16, '山东', 30, '272133', '2020-06-09 20:03:17', '2020-08-07 00:42:10', 0);
INSERT INTO `t_areas` VALUES (1744, 1744, NULL, '经济技术开发区', 3, 179, '威海市', 16, '山东', 30, '264205', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1745, 1745, NULL, '高新技术开发区', 3, 179, '威海市', 16, '山东', 30, '264209', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1750, 1750, NULL, '莱城区', 3, 181, '莱芜市', 16, '山东', 30, '271100', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1758, 1758, NULL, '苍山县', 3, 182, '临沂市', 16, '山东', 30, '277700', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1765, 1765, NULL, '陵县', 3, 183, '德州市', 16, '山东', 30, '253500', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1810, 1810, NULL, '高新技术开发区', 3, 187, '郑州市', 17, '河南', 30, '450000', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1812, 1812, NULL, '经济技术开发区', 3, 187, '郑州市', 17, '河南', 30, '450000', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1813, 1813, NULL, '郑东新区', 3, 187, '郑州市', 17, '河南', 30, '450000', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1814, 1814, NULL, '出口加工区', 3, 187, '郑州市', 17, '河南', 30, '450000', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1821, 1821, NULL, '开封县', 3, 188, '开封市', 17, '河南', 30, '475100', '2020-06-09 20:03:17', '2020-08-07 00:42:47', 0);
INSERT INTO `t_areas` VALUES (1823, 1823, NULL, '金明区', 3, 188, '开封市', 17, '河南', 30, '475003', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1840, 1840, NULL, '高新技术开发区', 3, 189, '洛阳市', 17, '河南', 30, '471003', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1841, 1841, NULL, '经济技术开发区', 3, 189, '洛阳市', 17, '河南', 30, '471023', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1888, 1888, NULL, '济源县', 3, 195, '济源市', 17, '河南', 30, '454650', '2020-06-09 20:03:17', '2020-09-24 19:39:04', 0);
INSERT INTO `t_areas` VALUES (1896, 1896, NULL, '许昌县', 3, 197, '许昌市', 17, '河南', 30, '461100', '2020-06-09 20:03:17', '2020-08-07 00:43:16', 0);
INSERT INTO `t_areas` VALUES (1908, 1908, NULL, '陕县', 3, 199, '三门峡市', 17, '河南', 30, '472100', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (1985, 1985, NULL, '郧县', 3, 207, '十堰市', 18, '湖北', 30, '442500', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2004, 2004, NULL, '经济技术开发区', 3, 208, '宜昌市', 18, '湖北', 30, '443003', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2007, 2007, NULL, '襄阳区', 3, 209, '襄阳市', 18, '湖北', 30, '441100', '2020-06-09 20:03:17', '2020-08-07 00:44:17', 0);
INSERT INTO `t_areas` VALUES (2080, 2080, NULL, '株洲县', 3, 220, '株洲市', 19, '湖南', 30, '412100', '2020-06-09 20:03:17', '2020-08-07 00:44:43', 0);
INSERT INTO `t_areas` VALUES (2193, 2193, NULL, '白云区', 3, 233, '广州市', 20, '广东', 30, '510080', '2020-06-09 20:03:17', '2020-08-07 00:45:52', 0);
INSERT INTO `t_areas` VALUES (2200, 2200, NULL, '萝岗区', 3, 233, '广州市', 20, '广东', 30, '510100', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2218, 2218, NULL, '坪山区', 3, 235, '深圳市', 20, '广东', 30, '518118', '2020-06-09 20:03:17', '2020-08-07 00:45:58', 0);
INSERT INTO `t_areas` VALUES (2250, 2250, NULL, '开发区', 3, 240, '湛江市', 20, '广东', 30, '524022', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2252, 2252, NULL, '茂港区', 3, 241, '茂名市', 20, '广东', 30, '525027', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2265, 2265, NULL, '高新技术产业开发区', 3, 242, '肇庆市', 20, '广东', 30, '526238', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2271, 2271, NULL, '大亚湾区', 3, 243, '惠州市', 20, '广东', 30, '516080', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2272, 2272, NULL, '仲恺高新区', 3, 243, '惠州市', 20, '广东', 30, '516080', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2311, 2311, NULL, '东山区', 3, 250, '揭阳市', 20, '广东', 30, '522031', '2020-06-09 20:03:17', '2020-08-07 00:31:08', 0);
INSERT INTO `t_areas` VALUES (2312, 2312, NULL, '普侨区', 3, 250, '揭阳市', 20, '广东', 30, '515339', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2313, 2313, NULL, '大南山侨区', 3, 250, '揭阳市', 20, '广东', 30, '515237', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2319, 2319, NULL, '南城县', 3, 252, '东莞市', 20, '广东', 30, '523000', '2020-06-09 20:03:17', '2020-08-07 00:40:26', 0);
INSERT INTO `t_areas` VALUES (2320, 2320, NULL, '石龙区', 3, 252, '东莞市', 20, '广东', 30, '523021', '2020-06-09 20:03:17', '2020-08-07 00:42:57', 0);
INSERT INTO `t_areas` VALUES (2322, 2322, NULL, '虎门镇', 4, 252, '东莞市', 20, '广东省', 20, '523061', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2323, 2323, NULL, '横沥镇', 4, 252, '东莞市', 20, '广东省', 20, '523032', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2324, 2324, NULL, '寮步镇', 4, 252, '东莞市', 20, '广东省', 20, '523058', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2325, 2325, NULL, '黄江镇', 4, 252, '东莞市', 20, '广东省', 20, '523054', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2326, 2326, NULL, '清溪镇', 4, 252, '东莞市', 20, '广东省', 20, '523046', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2327, 2327, NULL, '莞城区', 3, 252, '东莞市', 20, '广东', 30, '523000', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2328, 2328, NULL, '万江区', 3, 252, '东莞市', 20, '广东', 30, '523050', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2329, 2329, NULL, '东城区', 3, 252, '东莞市', 20, '广东', 30, '523000', '2020-06-09 20:03:17', '2020-08-06 23:41:23', 0);
INSERT INTO `t_areas` VALUES (2330, 2330, NULL, '石碣镇', 4, 252, '东莞市', 20, '广东省', 20, '523024', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2331, 2331, NULL, '茶山镇', 4, 252, '东莞市', 20, '广东省', 20, '523029', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2332, 2332, NULL, '石排镇', 4, 252, '东莞市', 20, '广东省', 20, '523025', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2333, 2333, NULL, '企石镇', 4, 252, '东莞市', 20, '广东省', 20, '523027', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2334, 2334, NULL, '桥头镇', 4, 252, '东莞市', 20, '广东省', 20, '523038', '2020-06-09 20:03:17', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (2335, 2335, NULL, '谢岗镇', 4, 252, '东莞市', 20, '广东省', 20, '523044', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2336, 2336, NULL, '东坑镇', 4, 252, '东莞市', 20, '广东省', 20, '523034', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2337, 2337, NULL, '常平镇', 4, 252, '东莞市', 20, '广东省', 20, '523036', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2338, 2338, NULL, '大朗镇', 4, 252, '东莞市', 20, '广东省', 20, '523056', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2339, 2339, NULL, '塘厦镇', 4, 252, '东莞市', 20, '广东省', 20, '523710', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2340, 2340, NULL, '凤岗镇', 4, 252, '东莞市', 20, '广东省', 20, '523048', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2341, 2341, NULL, '厚街镇', 4, 252, '东莞市', 20, '广东省', 20, '523071', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2342, 2342, NULL, '沙田镇', 4, 252, '东莞市', 20, '广东省', 20, '523073', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2343, 2343, NULL, '道滘镇', 4, 252, '东莞市', 20, '广东省', 20, '523170', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2344, 2344, NULL, '洪梅镇', 4, 252, '东莞市', 20, '广东省', 20, '523083', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2345, 2345, NULL, '麻涌镇', 4, 252, '东莞市', 20, '广东省', 20, '523078', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2346, 2346, NULL, '中堂镇', 4, 252, '东莞市', 20, '广东省', 20, '523075', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2347, 2347, NULL, '高埗镇', 4, 252, '东莞市', 20, '广东省', 20, '523270', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2348, 2348, NULL, '樟木头镇', 4, 252, '东莞市', 20, '广东省', 20, '523041', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2349, 2349, NULL, '大岭山镇', 4, 252, '东莞市', 20, '广东省', 20, '523074', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2350, 2350, NULL, '望牛墩镇', 4, 252, '东莞市', 20, '广东省', 20, '523077', '2020-06-09 20:03:17', '2020-08-11 05:55:32', 0);
INSERT INTO `t_areas` VALUES (2351, 2351, NULL, '中山市', 3, 253, '中山市', 20, '广东', 30, '528403', '2020-06-09 20:03:17', '2020-08-07 00:46:10', 0);
INSERT INTO `t_areas` VALUES (2392, 2392, NULL, '蝶山区', 3, 257, '梧州市', 21, '广西', 30, '543002', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2410, 2410, NULL, '钦州市', 3, 260, '钦州市', 21, '广西', 30, '535008', '2020-06-09 20:03:17', '2020-08-07 00:46:15', 0);
INSERT INTO `t_areas` VALUES (2455, 2455, NULL, '江洲区', 3, 267, '崇左市', 21, '广西', 30, '532200', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2482, 2482, NULL, '西、南、中沙群岛办事处', 3, 269, '省直辖县级行政单位', 22, '海南', 30, '573100', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2483, 2483, NULL, '河西区', 3, 270, '三亚市', 22, '海南', 30, '572000', '2020-06-09 20:03:17', '2020-08-06 23:41:42', 0);
INSERT INTO `t_areas` VALUES (2484, 2484, NULL, '河东区', 3, 270, '三亚市', 22, '海南', 30, '572000', '2020-06-09 20:03:17', '2020-08-07 00:42:30', 0);
INSERT INTO `t_areas` VALUES (2485, 2485, NULL, '田独镇', 3, 270, '三亚市', 22, '海南', 20, '572011', '2020-06-09 20:03:17', '2020-08-11 01:07:34', 0);
INSERT INTO `t_areas` VALUES (2486, 2486, NULL, '凤凰县', 3, 270, '三亚市', 22, '海南', 30, '572023', '2020-06-09 20:03:17', '2020-08-07 00:45:30', 0);
INSERT INTO `t_areas` VALUES (2487, 2487, NULL, '三亚市', 3, 270, '三亚市', 22, '海南', 30, '572000', '2020-06-09 20:03:17', '2020-08-07 00:46:25', 0);
INSERT INTO `t_areas` VALUES (2488, 2488, NULL, '崖城镇', 3, 270, '三亚市', 22, '海南', 20, '572025', '2020-06-09 20:03:17', '2020-08-11 01:07:34', 0);
INSERT INTO `t_areas` VALUES (2490, 2490, NULL, '育才乡', 3, 270, '三亚市', 22, '海南', 30, '572032', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2501, 2501, NULL, '万盛区', 3, 271, '重庆市', 23, '重庆', 30, '400800', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2502, 2502, NULL, '双桥区', 3, 271, '重庆市', 23, '重庆', 30, '400900', '2020-06-09 20:03:17', '2020-08-06 23:58:40', 0);
INSERT INTO `t_areas` VALUES (2519, 2519, NULL, '开县', 3, 271, '重庆市', 23, '重庆', 30, '405400', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2528, 2528, NULL, '高新区', 3, 271, '重庆市', 23, '重庆', 30, '400039', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2544, 2544, NULL, '郫县', 3, 272, '成都市', 24, '四川', 30, '611700', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2552, 2552, NULL, '高新区', 3, 272, '成都市', 24, '四川', 30, '610041', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2553, 2553, NULL, '高新西区', 3, 272, '成都市', 24, '四川', 30, '611731', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2582, 2582, NULL, '安县', 3, 277, '绵阳市', 24, '四川', 30, '622650', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2587, 2587, NULL, '农科区', 3, 277, '绵阳市', 24, '四川', 30, '621023', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2588, 2588, NULL, '经济技术开发区', 3, 277, '绵阳市', 24, '四川', 30, '621000', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2589, 2589, NULL, '高新区', 3, 277, '绵阳市', 24, '四川', 30, '621000', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2590, 2590, NULL, '仙海区', 3, 277, '绵阳市', 24, '四川', 30, '621007', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2592, 2592, NULL, '元坝区', 3, 278, '广元市', 24, '四川', 30, '628017', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2635, 2635, NULL, '宜宾市', 3, 284, '宜宾市', 24, '四川', 30, '644600', '2020-06-09 20:03:17', '2020-08-07 00:46:31', 0);
INSERT INTO `t_areas` VALUES (2650, 2650, NULL, '达县', 3, 286, '达州市', 24, '四川', 30, '635000', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2725, 2725, NULL, '小河区', 3, 293, '贵阳市', 25, '贵州', 30, '550009', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2730, 2730, NULL, '金阳县', 3, 293, '贵阳市', 25, '贵州', 30, '550081', '2020-06-09 20:03:17', '2020-08-07 00:46:33', 0);
INSERT INTO `t_areas` VALUES (2734, 2734, NULL, '盘县', 3, 294, '六盘水市', 25, '贵州', 30, '561601', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2737, 2737, NULL, '遵义市', 3, 295, '遵义市', 25, '贵州', 30, '563100', '2020-06-09 20:03:17', '2020-08-07 00:46:37', 0);
INSERT INTO `t_areas` VALUES (2755, 2755, NULL, '铜仁市', 3, 297, '铜仁地区', 25, '贵州', 30, '554300', '2020-06-09 20:03:17', '2020-08-07 00:46:42', 0);
INSERT INTO `t_areas` VALUES (2764, 2764, NULL, '万山区', 3, 297, '铜仁地区', 25, '贵州', 30, '554200', '2020-06-09 20:03:17', '2020-08-07 00:46:44', 0);
INSERT INTO `t_areas` VALUES (2773, 2773, NULL, '毕节市', 3, 299, '毕节地区', 25, '贵州', 30, '551700', '2020-06-09 20:03:17', '2020-08-07 00:46:40', 0);
INSERT INTO `t_areas` VALUES (2927, 2927, NULL, '潞西市', 3, 315, '德宏傣族景颇族自治州', 26, '云南', 30, '678400', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (2946, 2946, NULL, '昌都市', 3, 319, '昌都地区', 27, '西藏', 30, '854000', '2020-06-09 20:03:17', '2020-08-07 00:46:48', 0);
INSERT INTO `t_areas` VALUES (2969, 2969, NULL, '日喀则市', 3, 321, '日喀则地区', 27, '西藏', 30, '857000', '2020-06-09 20:03:17', '2020-08-07 00:46:46', 0);
INSERT INTO `t_areas` VALUES (2987, 2987, NULL, '那曲市', 3, 322, '那曲地区', 27, '西藏', 30, '852000', '2020-06-09 20:03:17', '2020-08-07 00:46:52', 0);
INSERT INTO `t_areas` VALUES (3004, 3004, NULL, '林芝市', 3, 324, '林芝地区', 27, '西藏', 30, '850400', '2020-06-09 20:03:17', '2020-08-07 00:46:51', 0);
INSERT INTO `t_areas` VALUES (3019, 3019, NULL, '长安区', 3, 325, '西安市', 28, '陕西', 30, '710100', '2020-06-09 20:03:17', '2020-08-07 00:47:00', 0);
INSERT INTO `t_areas` VALUES (3022, 3022, NULL, '户县', 3, 325, '西安市', 28, '陕西', 30, '710300', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (3024, 3024, NULL, '高新区', 3, 325, '西安市', 28, '陕西', 30, '710075', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (3029, 3029, NULL, '新区', 3, 326, '铜川市', 28, '陕西', 30, '727100', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (3051, 3051, NULL, '彬县', 3, 328, '咸阳市', 28, '陕西', 30, '713500', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (3057, 3057, NULL, '华县', 3, 329, '渭南市', 28, '陕西', 30, '714100', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (3073, 3073, NULL, '吴旗县', 3, 330, '延安市', 28, '陕西', 30, '717600', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (3091, 3091, NULL, '经济开发区', 3, 331, '汉中市', 28, '陕西', 30, '723000', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (3129, 3129, NULL, '嘉峪关市', 3, 336, '嘉峪关市', 29, '甘肃', 30, '678000', '2020-06-09 20:03:17', '2020-08-07 00:47:02', 0);
INSERT INTO `t_areas` VALUES (3163, 3163, NULL, '安西县', 3, 343, '酒泉市', 29, '甘肃', 30, '736100', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (3251, 3251, NULL, '大柴旦行委', 3, 356, '海西蒙古族藏族自治州', 30, '青海', 30, '817300', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (3286, 3286, NULL, '吐鲁番市', 3, 364, '吐鲁番地区', 32, '新疆', 30, '838000', '2020-06-09 20:03:17', '2020-08-07 00:47:07', 0);
INSERT INTO `t_areas` VALUES (3289, 3289, NULL, '哈密市', 3, 365, '哈密地区', 32, '新疆', 30, '839000', '2020-06-09 20:03:17', '2020-08-07 00:47:13', 0);
INSERT INTO `t_areas` VALUES (3294, 3294, NULL, '米泉市', 3, 366, '昌吉回族自治州', 32, '新疆', 30, '831400', '2020-06-09 20:03:17', '2020-08-03 22:31:44', 0);
INSERT INTO `t_areas` VALUES (3387, 3387, 210112, '浑南新区', 3, 72, '沈阳市', 7, '辽宁', 30, '110000', '2020-06-09 20:03:17', '2020-08-07 00:28:49', 0);
INSERT INTO `t_areas` VALUES (3396, 3396, NULL, '铜官区', 3, 139, '铜陵市', 13, '安徽', 30, '244000', '2020-06-09 20:03:17', '2020-08-07 00:38:59', 0);
INSERT INTO `t_areas` VALUES (3410, 3410, NULL, '光明区', 3, 235, '深圳市', 30, '广东', 30, '518107', '2020-06-09 20:03:17', '2020-08-07 00:46:03', 0);
INSERT INTO `t_areas` VALUES (3416, 3416, NULL, '海棠区', 3, 270, '三亚市', 22, '海南', 30, '572013', '2020-06-09 20:03:17', '2020-08-07 00:46:26', 0);
INSERT INTO `t_areas` VALUES (36359, 12, 330000, '浙江省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36361, 8, 220000, '吉林省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36363, 16, 370000, '山东省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36365, 21, 450000, '广西壮族自治区', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36367, 93, 220800, '白城市', 2, 8, '吉林省', NULL, NULL, 20, '0', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36369, 130, 330900, '舟山市', 2, 12, '浙江省', NULL, NULL, 20, '0', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36371, 184, 371500, '聊城市', 2, 16, '山东省', NULL, NULL, 20, '0', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36373, 263, 451000, '百色市', 2, 21, '广西壮族自治区', NULL, NULL, 20, '0', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36375, 1324, 330921, '岱山县', 3, 130, '舟山市', 12, '浙江省', 20, '316200', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36377, 979, 220881, '洮南市', 3, 93, '白城市', 8, '吉林省', 20, '137100', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36379, 2430, 451028, '乐业县', 3, 263, '百色市', 21, '广西壮族自治区', 20, '533200', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36381, 1780, 371525, '冠县', 3, 184, '聊城市', 16, '山东省', 20, '252500', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36383, 1325, 330922, '嵊泗县', 3, 130, '舟山市', 12, '浙江省', 20, '202450', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36385, 980, 220882, '大安市', 3, 93, '白城市', 8, '吉林省', 20, '131300', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36387, 2433, 451031, '隆林各族自治县', 3, 263, '百色市', 21, '广西壮族自治区', 20, '533400', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36389, 1777, 371522, '莘县', 3, 184, '聊城市', 16, '山东省', 20, '252400', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36391, 1323, 330903, '普陀区', 3, 130, '舟山市', 12, '浙江省', 20, '200333', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36393, 2432, 451030, '西林县', 3, 263, '百色市', 21, '广西壮族自治区', 20, '153025', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36395, 1322, 330902, '定海区', 3, 130, '舟山市', 12, '浙江省', 20, '316000', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36397, 1778, 371503, '茌平区', 3, 184, '聊城市', 16, '山东省', 20, '252100', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36399, 978, 220822, '通榆县', 3, 93, '白城市', 8, '吉林省', 20, '137200', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36401, 2429, 451027, '凌云县', 3, 263, '百色市', 21, '广西壮族自治区', 20, '533100', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36403, 125, 330400, '嘉兴市', 2, 12, '浙江省', NULL, NULL, 20, '0', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36405, 976, 220802, '洮北区', 3, 93, '白城市', 8, '吉林省', 20, '137000', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36407, 1775, 371502, '东昌府区', 3, 184, '聊城市', 16, '山东省', 20, '252000', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36409, 2422, 451002, '右江区', 3, 263, '百色市', 21, '广西壮族自治区', 20, '533000', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36411, 977, 220821, '镇赉县', 3, 93, '白城市', 8, '吉林省', 20, '137300', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36413, 1293, 330482, '平湖市', 3, 125, '嘉兴市', 12, '浙江省', 20, '314200', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36415, 1782, 371581, '临清市', 3, 184, '聊城市', 16, '山东省', 20, '252600', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36417, 2425, 451082, '平果市', 3, 263, '百色市', 21, '广西壮族自治区', 20, '531400', '2020-08-04 00:57:58', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36419, 1295, 330402, '南湖区', 3, 125, '嘉兴市', 12, '浙江省', 20, '314001', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36421, 1779, 371524, '东阿县', 3, 184, '聊城市', 16, '山东省', 20, '252200', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36423, 86, 220100, '长春市', 2, 8, '吉林省', NULL, NULL, 20, '0', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36425, 2428, 451026, '那坡县', 3, 263, '百色市', 21, '广西壮族自治区', 20, '533900', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36427, 2427, 451081, '靖西市', 3, 263, '百色市', 21, '广西壮族自治区', 20, '533800', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36429, 936, 220183, '德惠市', 3, 86, '长春市', 8, '吉林省', 20, '130300', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36431, 1776, 371521, '阳谷县', 3, 184, '聊城市', 16, '山东省', 20, '252300', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36433, 1290, 330421, '嘉善县', 3, 125, '嘉兴市', 12, '浙江省', 20, '314100', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36435, 935, 220182, '榆树市', 3, 86, '长春市', 8, '吉林省', 20, '130400', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36437, 2431, 451029, '田林县', 3, 263, '百色市', 21, '广西壮族自治区', 20, '533300', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36439, 1781, 371526, '高唐县', 3, 184, '聊城市', 16, '山东省', 20, '252800', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36441, 1291, 330424, '海盐县', 3, 125, '嘉兴市', 12, '浙江省', 20, '314300', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36443, 2423, 451003, '田阳区', 3, 263, '百色市', 21, '广西壮族自治区', 20, '533600', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36445, 172, 370300, '淄博市', 2, 16, '山东省', NULL, NULL, 20, '0', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36447, 932, 220112, '双阳区', 3, 86, '长春市', 8, '吉林省', 20, '130600', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36449, 1294, 330483, '桐乡市', 3, 125, '嘉兴市', 12, '浙江省', 20, '314500', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36451, 2426, 451024, '德保县', 3, 263, '百色市', 21, '广西壮族自治区', 20, '533700', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36453, 933, 220122, '农安县', 3, 86, '长春市', 8, '吉林省', 20, '130200', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36455, 1675, 370304, '博山区', 3, 172, '淄博市', 16, '山东省', 20, '255200', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36457, 1289, 330411, '秀洲区', 3, 125, '嘉兴市', 12, '浙江省', 20, '314001', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36459, 928, 220103, '宽城区', 3, 86, '长春市', 8, '吉林省', 20, '130051', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36461, 2424, 451022, '田东县', 3, 263, '百色市', 21, '广西壮族自治区', 20, '531500', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36463, 1676, 370305, '临淄区', 3, 172, '淄博市', 16, '山东省', 20, '255400', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36465, 1292, 330481, '海宁市', 3, 125, '嘉兴市', 12, '浙江省', 20, '314400', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36467, 934, 220113, '九台区', 3, 86, '长春市', 8, '吉林省', 20, '130500', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36469, 1679, 370322, '高青县', 3, 172, '淄博市', 16, '山东省', 20, '256300', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36471, 258, 450500, '北海市', 2, 21, '广西壮族自治区', NULL, NULL, 20, '0', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36473, 931, 220106, '绿园区', 3, 86, '长春市', 8, '吉林省', 20, '130062', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36475, 124, 330300, '温州市', 2, 12, '浙江省', NULL, NULL, 20, '0', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36477, 1678, 370321, '桓台县', 3, 172, '淄博市', 16, '山东省', 20, '256400', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36479, 952, 220184, '公主岭市', 3, 86, '长春市', 8, '吉林省', 20, '136100', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36481, 2400, 450512, '铁山港区', 3, 258, '北海市', 21, '广西壮族自治区', 20, '536017', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36483, 1287, 330381, '瑞安市', 3, 124, '温州市', 12, '浙江省', 20, '325200', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36485, 2399, 450503, '银海区', 3, 258, '北海市', 21, '广西壮族自治区', 20, '536000', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36487, 929, 220104, '朝阳区', 3, 86, '长春市', 8, '吉林省', 20, '100000', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36489, 1674, 370303, '张店区', 3, 172, '淄博市', 16, '山东省', 20, '255022', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36491, 1284, 330327, '苍南县', 3, 124, '温州市', 12, '浙江省', 20, '325800', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36493, 1680, 370323, '沂源县', 3, 172, '淄博市', 16, '山东省', 20, '256100', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36495, 930, 220105, '二道区', 3, 86, '长春市', 8, '吉林省', 20, '130031', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36497, 2398, 450502, '海城区', 3, 258, '北海市', 21, '广西壮族自治区', 20, '536000', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36499, 1281, 330305, '洞头区', 3, 124, '温州市', 12, '浙江省', 20, '325700', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36501, 927, 220102, '南关区', 3, 86, '长春市', 8, '吉林省', 20, '130022', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36503, 1283, 330326, '平阳县', 3, 124, '温州市', 12, '浙江省', 20, '325400', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36505, 1673, 370302, '淄川区', 3, 172, '淄博市', 16, '山东省', 20, '255100', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36507, 2401, 450521, '合浦县', 3, 258, '北海市', 21, '广西壮族自治区', 20, '536100', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36509, 87, 220200, '吉林市', 2, 8, '吉林省', NULL, NULL, 20, '0', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36511, 3458, 330383, '龙港市', 3, 124, '温州市', 12, '浙江省', 20, NULL, '2020-08-04 00:57:59', '2020-08-06 22:39:19', 0);
INSERT INTO `t_areas` VALUES (36513, 260, 450700, '钦州市', 2, 21, '广西壮族自治区', NULL, NULL, 20, '0', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36515, 1677, 370306, '周村区', 3, 172, '淄博市', 16, '山东省', 20, '255300', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36517, 942, 220211, '丰满区', 3, 87, '吉林市', 8, '吉林省', 20, '132013', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36519, 1285, 330328, '文成县', 3, 124, '温州市', 12, '浙江省', 20, '325300', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36521, 2406, 450702, '钦南区', 3, 260, '钦州市', 21, '广西壮族自治区', 20, '535000', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36523, 1286, 330329, '泰顺县', 3, 124, '温州市', 12, '浙江省', 20, '325500', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36525, 182, 371300, '临沂市', 2, 16, '山东省', NULL, NULL, 20, '0', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36527, 946, 220283, '舒兰市', 3, 87, '吉林市', 8, '吉林省', 20, '132600', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36529, 2407, 450703, '钦北区', 3, 260, '钦州市', 21, '广西壮族自治区', 20, '535000', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36531, 1757, 371323, '沂水县', 3, 182, '临沂市', 16, '山东省', 20, '276400', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36533, 1282, 330324, '永嘉县', 3, 124, '温州市', 12, '浙江省', 20, '315100', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36535, 945, 220282, '桦甸市', 3, 87, '吉林市', 8, '吉林省', 20, '132400', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36537, 1288, 330382, '乐清市', 3, 124, '温州市', 12, '浙江省', 20, '325600', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36539, 944, 220281, '蛟河市', 3, 87, '吉林市', 8, '吉林省', 20, '132500', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36541, 1762, 371328, '蒙阴县', 3, 182, '临沂市', 16, '山东省', 20, '276200', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36543, 2409, 450722, '浦北县', 3, 260, '钦州市', 21, '广西壮族自治区', 20, '535300', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36545, 1278, 330302, '鹿城区', 3, 124, '温州市', 12, '浙江省', 20, '325000', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36547, 940, 220203, '龙潭区', 3, 87, '吉林市', 8, '吉林省', 20, '132021', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36549, 2408, 450721, '灵山县', 3, 260, '钦州市', 21, '广西壮族自治区', 20, '535400', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36551, 1760, 371326, '平邑县', 3, 182, '临沂市', 16, '山东省', 20, '273300', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36553, 1280, 330304, '瓯海区', 3, 124, '温州市', 12, '浙江省', 20, '325005', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36555, 1279, 330303, '龙湾区', 3, 124, '温州市', 12, '浙江省', 20, '325013', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36557, 255, 450200, '柳州市', 2, 21, '广西壮族自治区', NULL, NULL, 20, '0', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36559, 1756, 371322, '郯城县', 3, 182, '临沂市', 16, '山东省', 20, '276100', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36561, 943, 220221, '永吉县', 3, 87, '吉林市', 8, '吉林省', 20, '132200', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36563, 131, 331000, '台州市', 2, 12, '浙江省', NULL, NULL, 20, '0', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36565, 2373, 450226, '三江侗族自治县', 3, 255, '柳州市', 21, '广西壮族自治区', 20, '545500', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36567, 947, 220284, '磐石市', 3, 87, '吉林市', 8, '吉林省', 20, '132300', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36569, 1761, 371327, '莒南县', 3, 182, '临沂市', 16, '山东省', 20, '276600', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36571, 2372, 450225, '融水苗族自治县', 3, 255, '柳州市', 21, '广西壮族自治区', 20, '545300', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36573, 1327, 331004, '路桥区', 3, 131, '台州市', 12, '浙江省', 20, '318050', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36575, 939, 220202, '昌邑区', 3, 87, '吉林市', 8, '吉林省', 20, '132002', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36577, 1755, 371321, '沂南县', 3, 182, '临沂市', 16, '山东省', 20, '276300', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36579, 2371, 450224, '融安县', 3, 255, '柳州市', 21, '广西壮族自治区', 20, '545400', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36581, 1329, 331083, '玉环市', 3, 131, '台州市', 12, '浙江省', 20, '317600', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36583, 941, 220204, '船营区', 3, 87, '吉林市', 8, '吉林省', 20, '132011', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36585, 1752, 371302, '兰山区', 3, 182, '临沂市', 16, '山东省', 20, '276002', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36587, 1326, 331002, '椒江区', 3, 131, '台州市', 12, '浙江省', 20, '318000', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36589, 2370, 450223, '鹿寨县', 3, 255, '柳州市', 21, '广西壮族自治区', 20, '545600', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36591, 92, 220700, '松原市', 2, 8, '吉林省', NULL, NULL, 20, '0', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36593, 1334, 331082, '临海市', 3, 131, '台州市', 12, '浙江省', 20, '317000', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36595, 2367, 450205, '柳北区', 3, 255, '柳州市', 21, '广西壮族自治区', 20, '545001', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36597, 1753, 371311, '罗庄区', 3, 182, '临沂市', 16, '山东省', 20, '276022', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36599, 975, 220781, '扶余市', 3, 92, '松原市', 8, '吉林省', 20, '131200', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36601, 1333, 331081, '温岭市', 3, 131, '台州市', 12, '浙江省', 20, '317500', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36603, 2364, 450202, '城中区', 3, 255, '柳州市', 21, '广西壮族自治区', 20, '545001', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36605, 1763, 371329, '临沭县', 3, 182, '临沂市', 16, '山东省', 20, '276700', '2020-08-04 00:57:59', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36607, 971, 220702, '宁江区', 3, 92, '松原市', 8, '吉林省', 20, '138000', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36609, 2369, 450222, '柳城县', 3, 255, '柳州市', 21, '广西壮族自治区', 20, '545200', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36611, 1330, 331022, '三门县', 3, 131, '台州市', 12, '浙江省', 20, '317100', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36613, 1754, 371312, '河东区', 3, 182, '临沂市', 16, '山东省', 20, '300171', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36615, 974, 220723, '乾安县', 3, 92, '松原市', 8, '吉林省', 20, '131400', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36617, 1331, 331023, '天台县', 3, 131, '台州市', 12, '浙江省', 20, '317200', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36619, 2365, 450203, '鱼峰区', 3, 255, '柳州市', 21, '广西壮族自治区', 20, '545005', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36621, 1759, 371325, '费县', 3, 182, '临沂市', 16, '山东省', 20, '273400', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36623, 972, 220721, '前郭尔罗斯蒙古族自治县', 3, 92, '松原市', 8, '吉林省', 20, '138000', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36625, 1328, 331003, '黄岩区', 3, 131, '台州市', 12, '浙江省', 20, '318020', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36627, 2368, 450206, '柳江区', 3, 255, '柳州市', 21, '广西壮族自治区', 20, '545100', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36629, 3401, 371324, '兰陵县', 3, 182, '临沂市', 16, '山东省', 20, '277700', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36631, 1332, 331024, '仙居县', 3, 131, '台州市', 12, '浙江省', 20, '317300', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36633, 2366, 450204, '柳南区', 3, 255, '柳州市', 21, '广西壮族自治区', 20, '545005', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36635, 973, 220722, '长岭县', 3, 92, '松原市', 8, '吉林省', 20, '131500', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36637, 123, 330200, '宁波市', 2, 12, '浙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36639, 171, 370200, '青岛市', 2, 16, '山东省', NULL, NULL, 20, '0', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36641, 266, 451300, '来宾市', 2, 21, '广西壮族自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36643, 89, 220400, '辽源市', 2, 8, '吉林省', NULL, NULL, 20, '0', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36645, 1269, 330206, '北仑区', 3, 123, '宁波市', 12, '浙江省', 20, '315800', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36647, 2451, 451322, '象州县', 3, 266, '来宾市', 21, '广西壮族自治区', 20, '545800', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36649, 1672, 370285, '莱西市', 3, 171, '青岛市', 16, '山东省', 20, '266600', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36651, 1272, 330225, '象山县', 3, 123, '宁波市', 12, '浙江省', 20, '315700', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36653, 955, 220403, '西安区', 3, 89, '辽源市', 8, '吉林省', 20, '136201', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36655, 1270, 330211, '镇海区', 3, 123, '宁波市', 12, '浙江省', 20, '315200', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36657, 2450, 451321, '忻城县', 3, 266, '来宾市', 21, '广西壮族自治区', 20, '546200', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36659, 1670, 370283, '平度市', 3, 171, '青岛市', 16, '山东省', 20, '266700', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36661, 956, 220421, '东丰县', 3, 89, '辽源市', 8, '吉林省', 20, '136300', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36663, 1268, 330205, '江北区', 3, 123, '宁波市', 12, '浙江省', 20, '315040', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36665, 2453, 451324, '金秀瑶族自治县', 3, 266, '来宾市', 21, '广西壮族自治区', 20, '545700', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36667, 1667, 370214, '城阳区', 3, 171, '青岛市', 16, '山东省', 20, '266041', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36669, 957, 220422, '东辽县', 3, 89, '辽源市', 8, '吉林省', 20, '136600', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36671, 2449, 451302, '兴宾区', 3, 266, '来宾市', 21, '广西壮族自治区', 20, '546100', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36673, 1669, 370215, '即墨区', 3, 171, '青岛市', 16, '山东省', 20, '266200', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36675, 1276, 330213, '奉化区', 3, 123, '宁波市', 12, '浙江省', 20, '315500', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36677, 954, 220402, '龙山区', 3, 89, '辽源市', 8, '吉林省', 20, '136200', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36679, 2452, 451323, '武宣县', 3, 266, '来宾市', 21, '广西壮族自治区', 20, '545900', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36681, 1666, 370213, '李沧区', 3, 171, '青岛市', 16, '山东省', 20, '266021', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36683, 1273, 330226, '宁海县', 3, 123, '宁波市', 12, '浙江省', 20, '315600', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36685, 94, 222400, '延边朝鲜族自治州', 2, 8, '吉林省', NULL, NULL, 20, '0', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36687, 1665, 370212, '崂山区', 3, 171, '青岛市', 16, '山东省', 20, '266100', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36689, 2454, 451381, '合山市', 3, 266, '来宾市', 21, '广西壮族自治区', 20, '546500', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36691, 1266, 330203, '海曙区', 3, 123, '宁波市', 12, '浙江省', 20, '315000', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36693, 1664, 370211, '黄岛区', 3, 171, '青岛市', 16, '山东省', 20, '266500', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36695, 254, 450100, '南宁市', 2, 21, '广西壮族自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36697, 983, 222403, '敦化市', 3, 94, '延边朝鲜族自治州', 8, '吉林省', 20, '133700', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36699, 1271, 330212, '鄞州区', 3, 123, '宁波市', 12, '浙江省', 20, '315100', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36701, 2361, 450125, '上林县', 3, 254, '南宁市', 21, '广西壮族自治区', 20, '530500', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36703, 984, 222404, '珲春市', 3, 94, '延边朝鲜族自治州', 8, '吉林省', 20, '133300', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36705, 1662, 370203, '市北区', 3, 171, '青岛市', 16, '山东省', 20, '266011', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36707, 1274, 330281, '余姚市', 3, 123, '宁波市', 12, '浙江省', 20, '315400', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36709, 1668, 370281, '胶州市', 3, 171, '青岛市', 16, '山东省', 20, '266300', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36711, 982, 222402, '图们市', 3, 94, '延边朝鲜族自治州', 8, '吉林省', 20, '133100', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36713, 2358, 450110, '武鸣区', 3, 254, '南宁市', 21, '广西壮族自治区', 20, '530100', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36715, 1275, 330282, '慈溪市', 3, 123, '宁波市', 12, '浙江省', 20, '315300', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36717, 1661, 370202, '市南区', 3, 171, '青岛市', 16, '山东省', 20, '266001', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36719, 179, 371000, '威海市', 2, 16, '山东省', NULL, NULL, 20, '0', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36721, 986, 222406, '和龙市', 3, 94, '延边朝鲜族自治州', 8, '吉林省', 20, '133500', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36723, 2360, 450124, '马山县', 3, 254, '南宁市', 21, '广西壮族自治区', 20, '530600', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36725, 132, 331100, '丽水市', 2, 12, '浙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36727, 1343, 331181, '龙泉市', 3, 132, '丽水市', 12, '浙江省', 20, '323700', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36729, 2363, 450127, '横县', 3, 254, '南宁市', 21, '广西壮族自治区', 20, '530300', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36731, 1740, 371002, '环翠区', 3, 179, '威海市', 16, '山东省', 20, '264200', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36733, 987, 222424, '汪清县', 3, 94, '延边朝鲜族自治州', 8, '吉林省', 20, '133200', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36735, 1335, 331102, '莲都区', 3, 132, '丽水市', 12, '浙江省', 20, '323000', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36737, 981, 222401, '延吉市', 3, 94, '延边朝鲜族自治州', 8, '吉林省', 20, '133000', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36739, 2362, 450126, '宾阳县', 3, 254, '南宁市', 21, '广西壮族自治区', 20, '530400', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36741, 1741, 371003, '文登区', 3, 179, '威海市', 16, '山东省', 20, '264400', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36743, 1339, 331124, '松阳县', 3, 132, '丽水市', 12, '浙江省', 20, '323400', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36745, 2356, 450108, '良庆区', 3, 254, '南宁市', 21, '广西壮族自治区', 20, '530200', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36747, 988, 222426, '安图县', 3, 94, '延边朝鲜族自治州', 8, '吉林省', 20, '133600', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36749, 1743, 371083, '乳山市', 3, 179, '威海市', 16, '山东省', 20, '264500', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36751, 1340, 331125, '云和县', 3, 132, '丽水市', 12, '浙江省', 20, '323600', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36753, 985, 222405, '龙井市', 3, 94, '延边朝鲜族自治州', 8, '吉林省', 20, '133400', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36755, 2357, 450109, '邕宁区', 3, 254, '南宁市', 21, '广西壮族自治区', 20, '530200', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36757, 1742, 371082, '荣成市', 3, 179, '威海市', 16, '山东省', 20, '264300', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36759, 1338, 331123, '遂昌县', 3, 132, '丽水市', 12, '浙江省', 20, '323300', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36761, 91, 220600, '白山市', 2, 8, '吉林省', NULL, NULL, 20, '0', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36763, 2354, 450105, '江南区', 3, 254, '南宁市', 21, '广西壮族自治区', 20, '530031', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36765, 1342, 331127, '景宁畲族自治县', 3, 132, '丽水市', 12, '浙江省', 20, '323500', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36767, 175, 370600, '烟台市', 2, 16, '山东省', NULL, NULL, 20, '0', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36769, 968, 220623, '长白朝鲜族自治县', 3, 91, '白山市', 8, '吉林省', 20, '134400', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36771, 2352, 450102, '兴宁区', 3, 254, '南宁市', 21, '广西壮族自治区', 20, '530012', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36773, 1693, 370602, '芝罘区', 3, 175, '烟台市', 16, '山东省', 20, '264001', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36775, 2355, 450107, '西乡塘区', 3, 254, '南宁市', 21, '广西壮族自治区', 20, '530001', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36777, 969, 220605, '江源区', 3, 91, '白山市', 8, '吉林省', 20, '134700', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36779, 1336, 331121, '青田县', 3, 132, '丽水市', 12, '浙江省', 20, '323900', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36781, 1701, 370614, '蓬莱区', 3, 175, '烟台市', 16, '山东省', 20, '265600', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36783, 967, 220622, '靖宇县', 3, 91, '白山市', 8, '吉林省', 20, '135200', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36785, 1341, 331126, '庆元县', 3, 132, '丽水市', 12, '浙江省', 20, '323800', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36787, 2353, 450103, '青秀区', 3, 254, '南宁市', 21, '广西壮族自治区', 20, '530022', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36789, 1700, 370683, '莱州市', 3, 175, '烟台市', 16, '山东省', 20, '261400', '2020-08-04 00:58:00', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36791, 966, 220621, '抚松县', 3, 91, '白山市', 8, '吉林省', 20, '134500', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36793, 1704, 370687, '海阳市', 3, 175, '烟台市', 16, '山东省', 20, '265100', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36795, 2359, 450123, '隆安县', 3, 254, '南宁市', 21, '广西壮族自治区', 20, '532700', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36797, 1337, 331122, '缙云县', 3, 132, '丽水市', 12, '浙江省', 20, '321400', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36799, 3389, 220602, '浑江区', 3, 91, '白山市', 8, '吉林省', 20, '134300', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36801, 1698, 370681, '龙口市', 3, 175, '烟台市', 16, '山东省', 20, '265700', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36803, 126, 330500, '湖州市', 2, 12, '浙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36805, 257, 450400, '梧州市', 2, 21, '广西壮族自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36807, 970, 220681, '临江市', 3, 91, '白山市', 8, '吉林省', 20, '134600', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36809, 1699, 370682, '莱阳市', 3, 175, '烟台市', 16, '山东省', 20, '265200', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36811, 2396, 450423, '蒙山县', 3, 257, '梧州市', 21, '广西壮族自治区', 20, '546700', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36813, 1298, 330521, '德清县', 3, 126, '湖州市', 12, '浙江省', 20, '313200', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36815, 1702, 370685, '招远市', 3, 175, '烟台市', 16, '山东省', 20, '265400', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36817, 90, 220500, '通化市', 2, 8, '吉林省', NULL, NULL, 20, '0', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36819, 1297, 330503, '南浔区', 3, 126, '湖州市', 12, '浙江省', 20, '313009', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36821, 2393, 450405, '长洲区', 3, 257, '梧州市', 21, '广西壮族自治区', 20, '543002', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36823, 1694, 370611, '福山区', 3, 175, '烟台市', 16, '山东省', 20, '265500', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36825, 960, 220521, '通化县', 3, 90, '通化市', 8, '吉林省', 20, '134100', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36827, 1300, 330523, '安吉县', 3, 126, '湖州市', 12, '浙江省', 20, '313300', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36829, 959, 220503, '二道江区', 3, 90, '通化市', 8, '吉林省', 20, '134003', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36831, 3411, 450406, '龙圩区', 3, 257, '梧州市', 21, '广西壮族自治区', 20, '543004', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36833, 1696, 370613, '莱山区', 3, 175, '烟台市', 16, '山东省', 20, '264600', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36835, 1299, 330522, '长兴县', 3, 126, '湖州市', 12, '浙江省', 20, '313100', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36837, 2397, 450481, '岑溪市', 3, 257, '梧州市', 21, '广西壮族自治区', 20, '543200', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36839, 958, 220502, '东昌区', 3, 90, '通化市', 8, '吉林省', 20, '134001', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36841, 1296, 330502, '吴兴区', 3, 126, '湖州市', 12, '浙江省', 20, '313000', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36843, 1703, 370686, '栖霞市', 3, 175, '烟台市', 16, '山东省', 20, '265300', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36845, 2394, 450421, '苍梧县', 3, 257, '梧州市', 21, '广西壮族自治区', 20, '543100', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36847, 962, 220524, '柳河县', 3, 90, '通化市', 8, '吉林省', 20, '135300', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36849, 129, 330800, '衢州市', 2, 12, '浙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36851, 1695, 370612, '牟平区', 3, 175, '烟台市', 16, '山东省', 20, '264100', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36853, 963, 220581, '梅河口市', 3, 90, '通化市', 8, '吉林省', 20, '135000', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36855, 2391, 450403, '万秀区', 3, 257, '梧州市', 21, '广西壮族自治区', 20, '543000', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36857, 1318, 330822, '常山县', 3, 129, '衢州市', 12, '浙江省', 20, '324200', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36859, 961, 220523, '辉南县', 3, 90, '通化市', 8, '吉林省', 20, '135100', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36861, 176, 370700, '潍坊市', 2, 16, '山东省', NULL, NULL, 20, '0', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36863, 2395, 450422, '藤县', 3, 257, '梧州市', 21, '广西壮族自治区', 20, '543300', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36865, 1319, 330824, '开化县', 3, 129, '衢州市', 12, '浙江省', 20, '324300', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36867, 964, 220582, '集安市', 3, 90, '通化市', 8, '吉林省', 20, '134200', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36869, 256, 450300, '桂林市', 2, 21, '广西壮族自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36871, 1709, 370705, '奎文区', 3, 176, '潍坊市', 16, '山东省', 20, '261031', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36873, 1316, 330802, '柯城区', 3, 129, '衢州市', 12, '浙江省', 20, '324100', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36875, 88, 220300, '四平市', 2, 8, '吉林省', NULL, NULL, 20, '0', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36877, 2383, 450325, '兴安县', 3, 256, '桂林市', 21, '广西壮族自治区', 20, '541300', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36879, 949, 220303, '铁东区', 3, 88, '四平市', 8, '吉林省', 20, '114001', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36881, 2380, 450312, '临桂区', 3, 256, '桂林市', 21, '广西壮族自治区', 20, '541100', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36883, 1710, 370724, '临朐县', 3, 176, '潍坊市', 16, '山东省', 20, '262600', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36885, 1321, 330881, '江山市', 3, 129, '衢州市', 12, '浙江省', 20, '324100', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36887, 953, 220382, '双辽市', 3, 88, '四平市', 8, '吉林省', 20, '136400', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36889, 2384, 450326, '永福县', 3, 256, '桂林市', 21, '广西壮族自治区', 20, '541800', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36891, 1706, 370702, '潍城区', 3, 176, '潍坊市', 16, '山东省', 20, '261021', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36893, 1317, 330803, '衢江区', 3, 129, '衢州市', 12, '浙江省', 20, '324022', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36895, 1715, 370784, '安丘市', 3, 176, '潍坊市', 16, '山东省', 20, '262100', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36897, 1320, 330825, '龙游县', 3, 129, '衢州市', 12, '浙江省', 20, '324400', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36899, 2390, 450332, '恭城瑶族自治县', 3, 256, '桂林市', 21, '广西壮族自治区', 20, '542500', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36901, 951, 220323, '伊通满族自治县', 3, 88, '四平市', 8, '吉林省', 20, '130700', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36903, 1713, 370782, '诸城市', 3, 176, '潍坊市', 16, '山东省', 20, '262200', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36905, 2378, 450311, '雁山区', 3, 256, '桂林市', 21, '广西壮族自治区', 20, '541006', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36907, 122, 330100, '杭州市', 2, 12, '浙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36909, 950, 220322, '梨树县', 3, 88, '四平市', 8, '吉林省', 20, '136500', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36911, 1714, 370783, '寿光市', 3, 176, '潍坊市', 16, '山东省', 20, '262700', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36913, 1253, 330102, '上城区', 3, 122, '杭州市', 12, '浙江省', 20, '310002', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36915, 2377, 450305, '七星区', 3, 256, '桂林市', 21, '广西壮族自治区', 20, '541004', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36917, 1264, 330111, '富阳区', 3, 122, '杭州市', 12, '浙江省', 20, '311400', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36919, 1707, 370703, '寒亭区', 3, 176, '潍坊市', 16, '山东省', 20, '261100', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36921, 2379, 450321, '阳朔县', 3, 256, '桂林市', 21, '广西壮族自治区', 20, '541900', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36923, 1717, 370786, '昌邑市', 3, 176, '潍坊市', 16, '山东省', 20, '261300', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36925, 1261, 330122, '桐庐县', 3, 122, '杭州市', 12, '浙江省', 20, '311500', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36927, 948, 220302, '铁西区', 3, 88, '四平市', 8, '吉林省', 20, '110021', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36929, 2389, 450381, '荔浦市', 3, 256, '桂林市', 21, '广西壮族自治区', 20, '546600', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36931, 1711, 370725, '昌乐县', 3, 176, '潍坊市', 16, '山东省', 20, '262400', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36933, 1263, 330182, '建德市', 3, 122, '杭州市', 12, '浙江省', 20, '311600', '2020-08-04 00:58:01', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36935, 3, 120000, '天津市', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36937, 1262, 330127, '淳安县', 3, 122, '杭州市', 12, '浙江省', 20, '311700', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36939, 1712, 370781, '青州市', 3, 176, '潍坊市', 16, '山东省', 20, '262500', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36941, 2388, 450330, '平乐县', 3, 256, '桂林市', 21, '广西壮族自治区', 20, '542400', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36943, 1258, 330108, '滨江区', 3, 122, '杭州市', 12, '浙江省', 20, '310051', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36945, 37, 120100, '天津城区', 2, 3, '天津市', NULL, NULL, 20, '0', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36947, 1716, 370785, '高密市', 3, 176, '潍坊市', 16, '山东省', 20, '261500', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36949, 1265, 330112, '临安区', 3, 122, '杭州市', 12, '浙江省', 20, '311300', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36951, 2386, 450328, '龙胜各族自治县', 3, 256, '桂林市', 21, '广西壮族自治区', 20, '541700', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36953, 399, 120105, '河北区', 3, 37, '天津城区', 3, '天津市', 20, '300143', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36955, 1259, 330109, '萧山区', 3, 122, '杭州市', 12, '浙江省', 20, '311200', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36957, 1708, 370704, '坊子区', 3, 176, '潍坊市', 16, '山东省', 20, '261200', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36959, 2374, 450302, '秀峰区', 3, 256, '桂林市', 21, '广西壮族自治区', 20, '541001', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36961, 395, 120101, '和平区', 3, 37, '天津城区', 3, '天津市', 20, '300041', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36963, 2376, 450304, '象山区', 3, 256, '桂林市', 21, '广西壮族自治区', 20, '541002', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36965, 1255, 330104, '江干区', 3, 122, '杭州市', 12, '浙江省', 20, '310016', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36967, 174, 370500, '东营市', 2, 16, '山东省', NULL, NULL, 20, '0', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36969, 1260, 330110, '余杭区', 3, 122, '杭州市', 12, '浙江省', 20, '311100', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36971, 409, 120115, '宝坻区', 3, 37, '天津城区', 3, '天津市', 20, '301800', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36973, 2385, 450327, '灌阳县', 3, 256, '桂林市', 21, '广西壮族自治区', 20, '541600', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36975, 1691, 370522, '利津县', 3, 174, '东营市', 16, '山东省', 20, '257400', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36977, 1257, 330106, '西湖区', 3, 122, '杭州市', 12, '浙江省', 20, '310013', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36979, 404, 120110, '东丽区', 3, 37, '天津城区', 3, '天津市', 20, '300300', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36981, 2382, 450324, '全州县', 3, 256, '桂林市', 21, '广西壮族自治区', 20, '541500', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36983, 1692, 370523, '广饶县', 3, 174, '东营市', 16, '山东省', 20, '257300', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36985, 1256, 330105, '拱墅区', 3, 122, '杭州市', 12, '浙江省', 20, '310011', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36987, 406, 120112, '津南区', 3, 37, '天津城区', 3, '天津市', 20, '300350', '2020-08-04 00:58:02', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36989, 2381, 450323, '灵川县', 3, 256, '桂林市', 21, '广西壮族自治区', 20, '541200', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36991, 1688, 370502, '东营区', 3, 174, '东营市', 16, '山东省', 20, '257029', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36993, 416, 120116, '滨海新区', 3, 37, '天津城区', 3, '天津市', 20, '300457', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36995, 1254, 330103, '下城区', 3, 122, '杭州市', 12, '浙江省', 20, '310006', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36997, 2375, 450303, '叠彩区', 3, 256, '桂林市', 21, '广西壮族自治区', 20, '541001', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (36999, 1689, 370503, '河口区', 3, 174, '东营市', 16, '山东省', 20, '257200', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37001, 128, 330700, '金华市', 2, 12, '浙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37003, 411, 120118, '静海区', 3, 37, '天津城区', 3, '天津市', 20, '301600', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37005, 2387, 450329, '资源县', 3, 256, '桂林市', 21, '广西壮族自治区', 20, '541400', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37007, 1310, 330726, '浦江县', 3, 128, '金华市', 12, '浙江省', 20, '322200', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37009, 412, 120119, '蓟州区', 3, 37, '天津城区', 3, '天津市', 20, '301900', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37011, 1690, 370505, '垦利区', 3, 174, '东营市', 16, '山东省', 20, '257500', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37013, 267, 451400, '崇左市', 2, 21, '广西壮族自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37015, 185, 371600, '滨州市', 2, 16, '山东省', NULL, NULL, 20, '0', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37017, 1315, 330784, '永康市', 3, 128, '金华市', 12, '浙江省', 20, '321300', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37019, 408, 120114, '武清区', 3, 37, '天津城区', 3, '天津市', 20, '301700', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37021, 2460, 451425, '天等县', 3, 267, '崇左市', 21, '广西壮族自治区', 20, '532800', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37023, 3414, 451402, '江州区', 3, 267, '崇左市', 21, '广西壮族自治区', 20, '532200', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37025, 398, 120104, '南开区', 3, 37, '天津城区', 3, '天津市', 20, '300100', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37027, 1783, 371602, '滨城区', 3, 185, '滨州市', 16, '山东省', 20, '256613', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37029, 1314, 330783, '东阳市', 3, 128, '金华市', 12, '浙江省', 20, '322100', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37031, 2456, 451421, '扶绥县', 3, 267, '崇左市', 21, '广西壮族自治区', 20, '532100', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37033, 397, 120103, '河西区', 3, 37, '天津城区', 3, '天津市', 20, '300202', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37035, 1787, 371603, '沾化区', 3, 185, '滨州市', 16, '山东省', 20, '256800', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37037, 1309, 330723, '武义县', 3, 128, '金华市', 12, '浙江省', 20, '321200', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37039, 2459, 451424, '大新县', 3, 267, '崇左市', 21, '广西壮族自治区', 20, '532300', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37041, 1789, 371681, '邹平市', 3, 185, '滨州市', 16, '山东省', 20, '256200', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37043, 410, 120117, '宁河区', 3, 37, '天津城区', 3, '天津市', 20, '301500', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37045, 1788, 371625, '博兴县', 3, 185, '滨州市', 16, '山东省', 20, '256500', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37047, 1312, 330781, '兰溪市', 3, 128, '金华市', 12, '浙江省', 20, '321100', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37049, 2461, 451481, '凭祥市', 3, 267, '崇左市', 21, '广西壮族自治区', 20, '532600', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37051, 400, 120106, '红桥区', 3, 37, '天津城区', 3, '天津市', 20, '300131', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37053, 1786, 371623, '无棣县', 3, 185, '滨州市', 16, '山东省', 20, '251900', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37055, 1311, 330727, '磐安县', 3, 128, '金华市', 12, '浙江省', 20, '322300', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37057, 2458, 451423, '龙州县', 3, 267, '崇左市', 21, '广西壮族自治区', 20, '532400', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37059, 407, 120113, '北辰区', 3, 37, '天津城区', 3, '天津市', 20, '300400', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37061, 1785, 371622, '阳信县', 3, 185, '滨州市', 16, '山东省', 20, '251800', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37063, 2457, 451422, '宁明县', 3, 267, '崇左市', 21, '广西壮族自治区', 20, '532500', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37065, 1313, 330782, '义乌市', 3, 128, '金华市', 12, '浙江省', 20, '322000', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37067, 405, 120111, '西青区', 3, 37, '天津城区', 3, '天津市', 20, '300380', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37069, 1784, 371621, '惠民县', 3, 185, '滨州市', 16, '山东省', 20, '251700', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37071, 259, 450600, '防城港市', 2, 21, '广西壮族自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37073, 1308, 330703, '金东区', 3, 128, '金华市', 12, '浙江省', 20, '321000', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37075, 26, 530000, '云南省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37077, 180, 371100, '日照市', 2, 16, '山东省', NULL, NULL, 20, '0', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37079, 2402, 450602, '港口区', 3, 259, '防城港市', 21, '广西壮族自治区', 20, '538001', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37081, 1307, 330702, '婺城区', 3, 128, '金华市', 12, '浙江省', 20, '321000', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37083, 306, 530600, '昭通市', 2, 26, '云南省', NULL, NULL, 20, '0', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37085, 1748, 371121, '五莲县', 3, 180, '日照市', 16, '山东省', 20, '272300', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37087, 2403, 450603, '防城区', 3, 259, '防城港市', 21, '广西壮族自治区', 20, '538021', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37089, 127, 330600, '绍兴市', 2, 12, '浙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37091, 2856, 530681, '水富市', 3, 306, '昭通市', 26, '云南省', 20, '657800', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37093, 1746, 371102, '东港区', 3, 180, '日照市', 16, '山东省', 20, '276800', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37095, 2405, 450681, '东兴市', 3, 259, '防城港市', 21, '广西壮族自治区', 20, '538100', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37097, 1306, 330683, '嵊州市', 3, 127, '绍兴市', 12, '浙江省', 20, '312400', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37099, 2852, 530626, '绥江县', 3, 306, '昭通市', 26, '云南省', 20, '657700', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37101, 1749, 371122, '莒县', 3, 180, '日照市', 16, '山东省', 20, '266500', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37103, 2404, 450621, '上思县', 3, 259, '防城港市', 21, '广西壮族自治区', 20, '535500', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37105, 1301, 330602, '越城区', 3, 127, '绍兴市', 12, '浙江省', 20, '312000', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37107, 2855, 530629, '威信县', 3, 306, '昭通市', 26, '云南省', 20, '657900', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37109, 1747, 371103, '岚山区', 3, 180, '日照市', 16, '山东省', 20, '276808', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37111, 2851, 530625, '永善县', 3, 306, '昭通市', 26, '云南省', 20, '657300', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37113, 264, 451100, '贺州市', 2, 21, '广西壮族自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37115, 173, 370400, '枣庄市', 2, 16, '山东省', NULL, NULL, 20, '0', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37117, 3394, 330603, '柯桥区', 3, 127, '绍兴市', 12, '浙江省', 20, '312030', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37119, 2850, 530624, '大关县', 3, 306, '昭通市', 26, '云南省', 20, '657400', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37121, 2437, 451123, '富川瑶族自治县', 3, 264, '贺州市', 21, '广西壮族自治区', 20, '542700', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37123, 1304, 330681, '诸暨市', 3, 127, '绍兴市', 12, '浙江省', 20, '311800', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37125, 1684, 370404, '峄城区', 3, 173, '枣庄市', 16, '山东省', 20, '277300', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37127, 2848, 530622, '巧家县', 3, 306, '昭通市', 26, '云南省', 20, '654600', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37129, 2435, 451121, '昭平县', 3, 264, '贺州市', 21, '广西壮族自治区', 20, '546800', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37131, 1686, 370406, '山亭区', 3, 173, '枣庄市', 16, '山东省', 20, '277200', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37133, 1303, 330624, '新昌县', 3, 127, '绍兴市', 12, '浙江省', 20, '312500', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37135, 2846, 530602, '昭阳区', 3, 306, '昭通市', 26, '云南省', 20, '657000', '2020-08-04 00:58:03', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37137, 1683, 370403, '薛城区', 3, 173, '枣庄市', 16, '山东省', 20, '277000', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37139, 2436, 451122, '钟山县', 3, 264, '贺州市', 21, '广西壮族自治区', 20, '542600', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37141, 1305, 330604, '上虞区', 3, 127, '绍兴市', 12, '浙江省', 20, '312300', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37143, 2849, 530623, '盐津县', 3, 306, '昭通市', 26, '云南省', 20, '657500', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37145, 1682, 370402, '市中区', 3, 173, '枣庄市', 16, '山东省', 20, '250001', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37147, 3413, 451103, '平桂区', 3, 264, '贺州市', 21, '广西壮族自治区', 20, '542800', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37149, 15, 360000, '江西省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37151, 2847, 530621, '鲁甸县', 3, 306, '昭通市', 26, '云南省', 20, '657100', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37153, 2434, 451102, '八步区', 3, 264, '贺州市', 21, '广西壮族自治区', 20, '542800', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37155, 168, 361000, '抚州市', 2, 15, '江西省', NULL, NULL, 20, '0', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37157, 1687, 370481, '滕州市', 3, 173, '枣庄市', 16, '山东省', 20, '277500', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37159, 2854, 530628, '彝良县', 3, 306, '昭通市', 26, '云南省', 20, '657600', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37161, 1685, 370405, '台儿庄区', 3, 173, '枣庄市', 16, '山东省', 20, '277400', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37163, 2853, 530627, '镇雄县', 3, 306, '昭通市', 26, '云南省', 20, '657200', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37165, 262, 450900, '玉林市', 2, 21, '广西壮族自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37167, 1635, 361003, '东乡区', 3, 168, '抚州市', 15, '江西省', 20, '331800', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37169, 183, 371400, '德州市', 2, 16, '山东省', NULL, NULL, 20, '0', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37171, 311, 532500, '红河哈尼族彝族自治州', 2, 26, '云南省', NULL, NULL, 20, '0', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37173, 3412, 450903, '福绵区', 3, 262, '玉林市', 21, '广西壮族自治区', 20, '537000', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37175, 1630, 361024, '崇仁县', 3, 168, '抚州市', 15, '江西省', 20, '344200', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37177, 1766, 371422, '宁津县', 3, 183, '德州市', 16, '山东省', 20, '253400', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37179, 2897, 532527, '泸西县', 3, 311, '红河哈尼族彝族自治州', 26, '云南省', 20, '652400', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37181, 2420, 450924, '兴业县', 3, 262, '玉林市', 21, '广西壮族自治区', 20, '537800', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37183, 1634, 361028, '资溪县', 3, 168, '抚州市', 15, '江西省', 20, '335300', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37185, 2419, 450923, '博白县', 3, 262, '玉林市', 21, '广西壮族自治区', 20, '537600', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37187, 2896, 532504, '弥勒市', 3, 311, '红河哈尼族彝族自治州', 26, '云南省', 20, '652300', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37189, 1773, 371481, '乐陵市', 3, 183, '德州市', 16, '山东省', 20, '253600', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37191, 1626, 361002, '临川区', 3, 168, '抚州市', 15, '江西省', 20, '344100', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37193, 2894, 532524, '建水县', 3, 311, '红河哈尼族彝族自治州', 26, '云南省', 20, '654300', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37195, 2418, 450922, '陆川县', 3, 262, '玉林市', 21, '广西壮族自治区', 20, '537700', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37197, 1764, 371402, '德城区', 3, 183, '德州市', 16, '山东省', 20, '253011', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37199, 2895, 532525, '石屏县', 3, 311, '红河哈尼族彝族自治州', 26, '云南省', 20, '662200', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37201, 1632, 361026, '宜黄县', 3, 168, '抚州市', 15, '江西省', 20, '344400', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37203, 2417, 450921, '容县', 3, 262, '玉林市', 21, '广西壮族自治区', 20, '537500', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37205, 1772, 371428, '武城县', 3, 183, '德州市', 16, '山东省', 20, '253300', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37207, 2891, 532502, '开远市', 3, 311, '红河哈尼族彝族自治州', 26, '云南省', 20, '661600', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37209, 1767, 371423, '庆云县', 3, 183, '德州市', 16, '山东省', 20, '253700', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37211, 2890, 532501, '个旧市', 3, 311, '红河哈尼族彝族自治州', 26, '云南省', 20, '661000', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37213, 2416, 450902, '玉州区', 3, 262, '玉林市', 21, '广西壮族自治区', 20, '537000', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37215, 1628, 361022, '黎川县', 3, 168, '抚州市', 15, '江西省', 20, '344600', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37217, 1771, 371427, '夏津县', 3, 183, '德州市', 16, '山东省', 20, '253200', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37219, 2892, 532503, '蒙自市', 3, 311, '红河哈尼族彝族自治州', 26, '云南省', 20, '661100', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37221, 2421, 450981, '北流市', 3, 262, '玉林市', 21, '广西壮族自治区', 20, '537400', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37223, 1627, 361021, '南城县', 3, 168, '抚州市', 15, '江西省', 20, '344700', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37225, 1769, 371425, '齐河县', 3, 183, '德州市', 16, '山东省', 20, '251100', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37227, 2899, 532529, '红河县', 3, 311, '红河哈尼族彝族自治州', 26, '云南省', 20, '654400', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37229, 261, 450800, '贵港市', 2, 21, '广西壮族自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37231, 1633, 361027, '金溪县', 3, 168, '抚州市', 15, '江西省', 20, '344800', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37233, 2413, 450804, '覃塘区', 3, 261, '贵港市', 21, '广西壮族自治区', 20, '537121', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37235, 1774, 371482, '禹城市', 3, 183, '德州市', 16, '山东省', 20, '251200', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37237, 2893, 532523, '屏边苗族自治县', 3, 311, '红河哈尼族彝族自治州', 26, '云南省', 20, '661200', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37239, 1631, 361025, '乐安县', 3, 168, '抚州市', 15, '江西省', 20, '344300', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37241, 1768, 371424, '临邑县', 3, 183, '德州市', 16, '山东省', 20, '251500', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37243, 2901, 532531, '绿春县', 3, 311, '红河哈尼族彝族自治州', 26, '云南省', 20, '662500', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37245, 2411, 450802, '港北区', 3, 261, '贵港市', 21, '广西壮族自治区', 20, '537100', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37247, 1629, 361023, '南丰县', 3, 168, '抚州市', 15, '江西省', 20, '344500', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37249, 3402, 371403, '陵城区', 3, 183, '德州市', 16, '山东省', 20, '253500', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37251, 2898, 532528, '元阳县', 3, 311, '红河哈尼族彝族自治州', 26, '云南省', 20, '662400', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37253, 2412, 450803, '港南区', 3, 261, '贵港市', 21, '广西壮族自治区', 20, '537132', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37255, 1636, 361030, '广昌县', 3, 168, '抚州市', 15, '江西省', 20, '344900', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37257, 1770, 371426, '平原县', 3, 183, '德州市', 16, '山东省', 20, '253100', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37259, 2900, 532530, '金平苗族瑶族傣族自治县', 3, 311, '红河哈尼族彝族自治州', 26, '云南省', 20, '661500', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37261, 2415, 450881, '桂平市', 3, 261, '贵港市', 21, '广西壮族自治区', 20, '537200', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37263, 162, 360400, '九江市', 2, 15, '江西省', NULL, NULL, 20, '0', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37265, 170, 370100, '济南市', 2, 16, '山东省', NULL, NULL, 20, '0', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37267, 2902, 532532, '河口瑶族自治县', 3, 311, '红河哈尼族彝族自治州', 26, '云南省', 20, '661300', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37269, 1577, 360430, '彭泽县', 3, 162, '九江市', 15, '江西省', 20, '332700', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37271, 1751, 370117, '钢城区', 3, 170, '济南市', 16, '山东省', 20, '271100', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37273, 2414, 450821, '平南县', 3, 261, '贵港市', 21, '广西壮族自治区', 20, '537300', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37275, 181, 370116, '莱芜区', 3, 170, '济南市', 16, '山东省', 20, '0', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37277, 1576, 360429, '湖口县', 3, 162, '九江市', 15, '江西省', 20, '332500', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37279, 265, 451200, '河池市', 2, 21, '广西壮族自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37281, 303, 530300, '曲靖市', 2, 26, '云南省', NULL, NULL, 20, '0', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37283, 1658, 370114, '章丘区', 3, 170, '济南市', 16, '山东省', 20, '250200', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37285, 2443, 451225, '罗城仫佬族自治县', 3, 265, '河池市', 21, '广西壮族自治区', 20, '546400', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37287, 1652, 370105, '天桥区', 3, 170, '济南市', 16, '山东省', 20, '250031', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37289, 1575, 360428, '都昌县', 3, 162, '九江市', 15, '江西省', 20, '332600', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37291, 2829, 530326, '会泽县', 3, 303, '曲靖市', 26, '云南省', 20, '654200', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37293, 1656, 370115, '济阳区', 3, 170, '济南市', 16, '山东省', 20, '251400', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37295, 3400, 360404, '柴桑区', 3, 162, '九江市', 15, '江西省', 20, '332100', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37297, 2824, 530304, '马龙区', 3, 303, '曲靖市', 26, '云南省', 20, '655100', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37299, 2439, 451221, '南丹县', 3, 265, '河池市', 21, '广西壮族自治区', 20, '547200', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37301, 1570, 360423, '武宁县', 3, 162, '九江市', 15, '江西省', 20, '332300', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37303, 1653, 370112, '历城区', 3, 170, '济南市', 16, '山东省', 20, '250100', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37305, 2827, 530324, '罗平县', 3, 303, '曲靖市', 26, '云南省', 20, '655800', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37307, 2440, 451222, '天峨县', 3, 265, '河池市', 21, '广西壮族自治区', 20, '547300', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37309, 1571, 360424, '修水县', 3, 162, '九江市', 15, '江西省', 20, '332400', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37311, 1649, 370102, '历下区', 3, 170, '济南市', 16, '山东省', 20, '250014', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37313, 1567, 360483, '庐山市', 3, 162, '九江市', 15, '江西省', 20, '332005', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37315, 1655, 370124, '平阴县', 3, 170, '济南市', 16, '山东省', 20, '250400', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37317, 2444, 451226, '环江毛南族自治县', 3, 265, '河池市', 21, '广西壮族自治区', 20, '547100', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37319, 2826, 530323, '师宗县', 3, 303, '曲靖市', 26, '云南省', 20, '655700', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37321, 3399, 360402, '濂溪区', 3, 162, '九江市', 15, '江西省', 20, '332005', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37323, 1657, 370126, '商河县', 3, 170, '济南市', 16, '山东省', 20, '251600', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37325, 2448, 451203, '宜州区', 3, 265, '河池市', 21, '广西壮族自治区', 20, '546300', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37327, 1568, 360403, '浔阳区', 3, 162, '九江市', 15, '江西省', 20, '332000', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37329, 2825, 530322, '陆良县', 3, 303, '曲靖市', 26, '云南省', 20, '655600', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37331, 2441, 451223, '凤山县', 3, 265, '河池市', 21, '广西壮族自治区', 20, '547600', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37333, 1572, 360425, '永修县', 3, 162, '九江市', 15, '江西省', 20, '330300', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37335, 2831, 530381, '宣威市', 3, 303, '曲靖市', 26, '云南省', 20, '655400', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37337, 1651, 370104, '槐荫区', 3, 170, '济南市', 16, '山东省', 20, '250022', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37339, 2438, 451202, '金城江区', 3, 265, '河池市', 21, '广西壮族自治区', 20, '547000', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37341, 2828, 530325, '富源县', 3, 303, '曲靖市', 26, '云南省', 20, '655500', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37343, 1579, 360482, '共青城市', 3, 162, '九江市', 15, '江西省', 20, '332020', '2020-08-04 00:58:04', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37345, 1654, 370113, '长清区', 3, 170, '济南市', 16, '山东省', 20, '250300', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37347, 2446, 451228, '都安瑶族自治县', 3, 265, '河池市', 21, '广西壮族自治区', 20, '530700', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37349, 1573, 360426, '德安县', 3, 162, '九江市', 15, '江西省', 20, '330400', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37351, 2823, 530302, '麒麟区', 3, 303, '曲靖市', 26, '云南省', 20, '655000', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37353, 186, 371700, '菏泽市', 2, 16, '山东省', NULL, NULL, 20, '0', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37355, 2447, 451229, '大化瑶族自治县', 3, 265, '河池市', 21, '广西壮族自治区', 20, '530800', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37357, 1578, 360481, '瑞昌市', 3, 162, '九江市', 15, '江西省', 20, '332200', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37359, 1796, 371726, '鄄城县', 3, 186, '菏泽市', 16, '山东省', 20, '274600', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37361, 2830, 530303, '沾益区', 3, 303, '曲靖市', 26, '云南省', 20, '655331', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37363, 2442, 451224, '东兰县', 3, 265, '河池市', 21, '广西壮族自治区', 20, '547400', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37365, 165, 360700, '赣州市', 2, 15, '江西省', NULL, NULL, 20, '0', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37367, 316, 533300, '怒江傈僳族自治州', 2, 26, '云南省', NULL, NULL, 20, '0', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37369, 1790, 371702, '牡丹区', 3, 186, '菏泽市', 16, '山东省', 20, '274009', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37371, 1597, 360732, '兴国县', 3, 165, '赣州市', 15, '江西省', 20, '342400', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37373, 2445, 451227, '巴马瑶族自治县', 3, 265, '河池市', 21, '广西壮族自治区', 20, '547500', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37375, 1798, 371728, '东明县', 3, 186, '菏泽市', 16, '山东省', 20, '274500', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37377, 2933, 533324, '贡山独龙族怒族自治县', 3, 316, '怒江傈僳族自治州', 26, '云南省', 20, '673500', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37379, 1595, 360730, '宁都县', 3, 165, '赣州市', 15, '江西省', 20, '342800', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37381, 1797, 371703, '定陶区', 3, 186, '菏泽市', 16, '山东省', 20, '274100', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37383, 1600, 360735, '石城县', 3, 165, '赣州市', 15, '江西省', 20, '342700', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37385, 11, 320000, '江苏省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37387, 2932, 533323, '福贡县', 3, 316, '怒江傈僳族自治州', 26, '云南省', 20, '673400', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37389, 115, 320700, '连云港市', 2, 11, '江苏省', NULL, NULL, 20, '0', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37391, 1590, 360725, '崇义县', 3, 165, '赣州市', 15, '江西省', 20, '341300', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37393, 2934, 533325, '兰坪白族普米族自治县', 3, 316, '怒江傈僳族自治州', 26, '云南省', 20, '671400', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37395, 1795, 371725, '郓城县', 3, 186, '菏泽市', 16, '山东省', 20, '274700', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37397, 1207, 320722, '东海县', 3, 115, '连云港市', 11, '江苏省', 20, '222300', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37399, 2931, 533301, '泸水市', 3, 316, '怒江傈僳族自治州', 26, '云南省', 20, '673100', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37401, 1596, 360731, '于都县', 3, 165, '赣州市', 15, '江西省', 20, '342300', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37403, 1794, 371724, '巨野县', 3, 186, '菏泽市', 16, '山东省', 20, '274900', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37405, 1203, 320703, '连云区', 3, 115, '连云港市', 11, '江苏省', 20, '222042', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37407, 304, 530400, '玉溪市', 2, 26, '云南省', NULL, NULL, 20, '0', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37409, 1793, 371723, '成武县', 3, 186, '菏泽市', 16, '山东省', 20, '274200', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37411, 1599, 360734, '寻乌县', 3, 165, '赣州市', 15, '江西省', 20, '342200', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37413, 1208, 320723, '灌云县', 3, 115, '连云港市', 11, '江苏省', 20, '222200', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37415, 2837, 530425, '易门县', 3, 304, '玉溪市', 26, '云南省', 20, '651100', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37417, 1791, 371721, '曹县', 3, 186, '菏泽市', 16, '山东省', 20, '274400', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37419, 1588, 360723, '大余县', 3, 165, '赣州市', 15, '江西省', 20, '341500', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37421, 2834, 530481, '澄江市', 3, 304, '玉溪市', 26, '云南省', 20, '652500', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37423, 1209, 320724, '灌南县', 3, 115, '连云港市', 11, '江苏省', 20, '223500', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37425, 1792, 371722, '单县', 3, 186, '菏泽市', 16, '山东省', 20, '274300', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37427, 1591, 360726, '安远县', 3, 165, '赣州市', 15, '江西省', 20, '342100', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37429, 1206, 320707, '赣榆区', 3, 115, '连云港市', 11, '江苏省', 20, '222100', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37431, 2838, 530426, '峨山彝族自治县', 3, 304, '玉溪市', 26, '云南省', 20, '653200', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37433, 1205, 320706, '海州区', 3, 115, '连云港市', 11, '江苏省', 20, '123000', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37435, 178, 370900, '泰安市', 2, 16, '山东省', NULL, NULL, 20, '0', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37437, 1594, 360729, '全南县', 3, 165, '赣州市', 15, '江西省', 20, '341800', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37439, 2836, 530424, '华宁县', 3, 304, '玉溪市', 26, '云南省', 20, '652800', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37441, 121, 321300, '宿迁市', 2, 11, '江苏省', NULL, NULL, 20, '0', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37443, 1738, 370982, '新泰市', 3, 178, '泰安市', 16, '山东省', 20, '271200', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37445, 1601, 360781, '瑞金市', 3, 165, '赣州市', 15, '江西省', 20, '342500', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37447, 2839, 530427, '新平彝族傣族自治县', 3, 304, '玉溪市', 26, '云南省', 20, '653400', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37449, 1250, 321322, '沭阳县', 3, 121, '宿迁市', 11, '江苏省', 20, '223600', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37451, 1598, 360733, '会昌县', 3, 165, '赣州市', 15, '江西省', 20, '342600', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37453, 2833, 530403, '江川区', 3, 304, '玉溪市', 26, '云南省', 20, '652600', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37455, 1251, 321323, '泗阳县', 3, 121, '宿迁市', 11, '江苏省', 20, '223700', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37457, 1737, 370923, '东平县', 3, 178, '泰安市', 16, '山东省', 20, '271500', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37459, 1587, 360722, '信丰县', 3, 165, '赣州市', 15, '江西省', 20, '341600', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37461, 2832, 530402, '红塔区', 3, 304, '玉溪市', 26, '云南省', 20, '653100', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37463, 1252, 321324, '泗洪县', 3, 121, '宿迁市', 11, '江苏省', 20, '223900', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37465, 1734, 370902, '泰山区', 3, 178, '泰安市', 16, '山东省', 20, '271000', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37467, 1589, 360724, '上犹县', 3, 165, '赣州市', 15, '江西省', 20, '341200', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37469, 2835, 530423, '通海县', 3, 304, '玉溪市', 26, '云南省', 20, '652700', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37471, 1249, 321311, '宿豫区', 3, 121, '宿迁市', 11, '江苏省', 20, '223800', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37473, 1735, 370911, '岱岳区', 3, 178, '泰安市', 16, '山东省', 20, '271000', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37475, 1593, 360728, '定南县', 3, 165, '赣州市', 15, '江西省', 20, '341900', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37477, 1248, 321302, '宿城区', 3, 121, '宿迁市', 11, '江苏省', 20, '223800', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37479, 2840, 530428, '元江哈尼族彝族傣族自治县', 3, 304, '玉溪市', 26, '云南省', 20, '653300', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37481, 1739, 370983, '肥城市', 3, 178, '泰安市', 16, '山东省', 20, '271600', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37483, 1602, 360703, '南康区', 3, 165, '赣州市', 15, '江西省', 20, '341400', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37485, 109, 320100, '南京市', 2, 11, '江苏省', NULL, NULL, 20, '0', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37487, 305, 530500, '保山市', 2, 26, '云南省', NULL, NULL, 20, '0', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37489, 1736, 370921, '宁阳县', 3, 178, '泰安市', 16, '山东省', 20, '271400', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37491, 1592, 360727, '龙南县', 3, 165, '赣州市', 15, '江西省', 20, '341700', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37493, 177, 370800, '济宁市', 2, 16, '山东省', NULL, NULL, 20, '0', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37495, 1147, 320111, '浦口区', 3, 109, '南京市', 11, '江苏省', 20, '210000', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37497, 2843, 530581, '腾冲市', 3, 305, '保山市', 26, '云南省', 20, '679100', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37499, 1586, 360704, '赣县区', 3, 165, '赣州市', 15, '江西省', 20, '341100', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37501, 1728, 370830, '汶上县', 3, 177, '济宁市', 16, '山东省', 20, '272501', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37503, 2841, 530502, '隆阳区', 3, 305, '保山市', 26, '云南省', 20, '678000', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37505, 1585, 360702, '章贡区', 3, 165, '赣州市', 15, '江西省', 20, '341000', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37507, 1149, 320114, '雨花台区', 3, 109, '南京市', 11, '江苏省', 20, '210000', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37509, 1733, 370883, '邹城市', 3, 177, '济宁市', 16, '山东省', 20, '273500', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37511, 164, 360600, '鹰潭市', 2, 15, '江西省', NULL, NULL, 20, '0', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37513, 1150, 320115, '江宁区', 3, 109, '南京市', 11, '江苏省', 20, '210000', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37515, 2845, 530524, '昌宁县', 3, 305, '保山市', 26, '云南省', 20, '678100', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37517, 1729, 370831, '泗水县', 3, 177, '济宁市', 16, '山东省', 20, '273200', '2020-08-04 00:58:05', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37519, 1584, 360681, '贵溪市', 3, 164, '鹰潭市', 15, '江西省', 20, '335400', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37521, 1152, 320117, '溧水区', 3, 109, '南京市', 11, '江苏省', 20, '210000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37523, 2842, 530521, '施甸县', 3, 305, '保山市', 26, '云南省', 20, '678200', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37525, 1731, 370881, '曲阜市', 3, 177, '济宁市', 16, '山东省', 20, '273100', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37527, 1583, 360603, '余江区', 3, 164, '鹰潭市', 15, '江西省', 20, '335200', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37529, 1151, 320116, '六合区', 3, 109, '南京市', 11, '江苏省', 20, '210000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37531, 1723, 370811, '任城区', 3, 177, '济宁市', 16, '山东省', 20, '272113', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37533, 2844, 530523, '龙陵县', 3, 305, '保山市', 26, '云南省', 20, '678300', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37535, 1582, 360602, '月湖区', 3, 164, '鹰潭市', 15, '江西省', 20, '335000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37537, 1153, 320118, '高淳区', 3, 109, '南京市', 11, '江苏省', 20, '210000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37539, 1727, 370829, '嘉祥县', 3, 177, '济宁市', 16, '山东省', 20, '272400', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37541, 1144, 320105, '建邺区', 3, 109, '南京市', 11, '江苏省', 20, '210000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37543, 314, 532900, '大理白族自治州', 2, 26, '云南省', NULL, NULL, 20, '0', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37545, 160, 360200, '景德镇市', 2, 15, '江西省', NULL, NULL, 20, '0', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37547, 1730, 370832, '梁山县', 3, 177, '济宁市', 16, '山东省', 20, '272600', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37549, 2924, 532931, '剑川县', 3, 314, '大理白族自治州', 26, '云南省', 20, '671300', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37551, 1145, 320106, '鼓楼区', 3, 109, '南京市', 11, '江苏省', 20, '210000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37553, 1560, 360222, '浮梁县', 3, 160, '景德镇市', 15, '江西省', 20, '333400', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37555, 1725, 370827, '鱼台县', 3, 177, '济宁市', 16, '山东省', 20, '272300', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37557, 1143, 320104, '秦淮区', 3, 109, '南京市', 11, '江苏省', 20, '210000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37559, 2925, 532932, '鹤庆县', 3, 314, '大理白族自治州', 26, '云南省', 20, '671500', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37561, 1559, 360203, '珠山区', 3, 160, '景德镇市', 15, '江西省', 20, '333000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37563, 1726, 370828, '金乡县', 3, 177, '济宁市', 16, '山东省', 20, '272200', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37565, 1148, 320113, '栖霞区', 3, 109, '南京市', 11, '江苏省', 20, '210000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37567, 2923, 532930, '洱源县', 3, 314, '大理白族自治州', 26, '云南省', 20, '671200', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37569, 1558, 360202, '昌江区', 3, 160, '景德镇市', 15, '江西省', 20, '333000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37571, 1724, 370826, '微山县', 3, 177, '济宁市', 16, '山东省', 20, '277600', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37573, 1141, 320102, '玄武区', 3, 109, '南京市', 11, '江苏省', 20, '210000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37575, 1732, 370812, '兖州区', 3, 177, '济宁市', 16, '山东省', 20, '272000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37577, 1561, 360281, '乐平市', 3, 160, '景德镇市', 15, '江西省', 20, '333300', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37579, 2917, 532924, '宾川县', 3, 314, '大理白族自治州', 26, '云南省', 20, '671600', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37581, 114, 320600, '南通市', 2, 11, '江苏省', NULL, NULL, 20, '0', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37583, 13, 340000, '安徽省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37585, 169, 361100, '上饶市', 2, 15, '江西省', NULL, NULL, 20, '0', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37587, 2922, 532929, '云龙县', 3, 314, '大理白族自治州', 26, '云南省', 20, '672700', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37589, 1647, 361130, '婺源县', 3, 169, '上饶市', 15, '江西省', 20, '333200', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37591, 1199, 320682, '如皋市', 3, 114, '南通市', 11, '江苏省', 20, '226500', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37593, 1648, 361181, '德兴市', 3, 169, '上饶市', 15, '江西省', 20, '334200', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37595, 138, 340600, '淮北市', 2, 13, '安徽省', NULL, NULL, 20, '0', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37597, 1644, 361127, '余干县', 3, 169, '上饶市', 15, '江西省', 20, '335100', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37599, 2914, 532901, '大理市', 3, 314, '大理白族自治州', 26, '云南省', 20, '671000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37601, 1201, 320684, '海门市', 3, 114, '南通市', 11, '江苏省', 20, '226100', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37603, 1380, 340602, '杜集区', 3, 138, '淮北市', 13, '安徽省', 20, '235000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37605, 1196, 320685, '海安市', 3, 114, '南通市', 11, '江苏省', 20, '226600', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37607, 1642, 361125, '横峰县', 3, 169, '上饶市', 15, '江西省', 20, '334300', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37609, 2916, 532923, '祥云县', 3, 314, '大理白族自治州', 26, '云南省', 20, '672100', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37611, 1197, 320623, '如东县', 3, 114, '南通市', 11, '江苏省', 20, '226400', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37613, 1382, 340604, '烈山区', 3, 138, '淮北市', 13, '安徽省', 20, '235000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37615, 1643, 361126, '弋阳县', 3, 169, '上饶市', 15, '江西省', 20, '334400', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37617, 2915, 532922, '漾濞彝族自治县', 3, 314, '大理白族自治州', 26, '云南省', 20, '672500', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37619, 1381, 340603, '相山区', 3, 138, '淮北市', 13, '安徽省', 20, '235000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37621, 1198, 320681, '启东市', 3, 114, '南通市', 11, '江苏省', 20, '226200', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37623, 1639, 361103, '广丰区', 3, 169, '上饶市', 15, '江西省', 20, '334600', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37625, 2921, 532928, '永平县', 3, 314, '大理白族自治州', 26, '云南省', 20, '672600', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37627, 1383, 340621, '濉溪县', 3, 138, '淮北市', 13, '安徽省', 20, '235100', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37629, 1195, 320611, '港闸区', 3, 114, '南通市', 11, '江苏省', 20, '226001', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37631, 1641, 361124, '铅山县', 3, 169, '上饶市', 15, '江西省', 20, '334500', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37633, 2920, 532927, '巍山彝族回族自治县', 3, 314, '大理白族自治州', 26, '云南省', 20, '672400', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37635, 139, 340700, '铜陵市', 2, 13, '安徽省', NULL, NULL, 20, '0', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37637, 1200, 320612, '通州区', 3, 114, '南通市', 11, '江苏省', 20, '100000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37639, 2918, 532925, '弥渡县', 3, 314, '大理白族自治州', 26, '云南省', 20, '675600', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37641, 1640, 361123, '玉山县', 3, 169, '上饶市', 15, '江西省', 20, '334700', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37643, 1645, 361128, '鄱阳县', 3, 169, '上饶市', 15, '江西省', 20, '333100', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37645, 1194, 320602, '崇川区', 3, 114, '南通市', 11, '江苏省', 20, '226001', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37647, 1386, 340711, '郊区', 3, 139, '铜陵市', 13, '安徽省', 20, '045011', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37649, 2919, 532926, '南涧彝族自治县', 3, 314, '大理白族自治州', 26, '云南省', 20, '675700', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37651, 116, 320800, '淮安市', 2, 11, '江苏省', NULL, NULL, 20, '0', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37653, 1384, 340705, '铜官区', 3, 139, '铜陵市', 13, '安徽省', 20, '244000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37655, 1646, 361129, '万年县', 3, 169, '上饶市', 15, '江西省', 20, '335500', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37657, 307, 530700, '丽江市', 2, 26, '云南省', NULL, NULL, 20, '0', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37659, 3459, 361104, '广信区', 3, 169, '上饶市', 15, '江西省', 20, NULL, '2020-08-04 00:58:06', '2020-08-06 22:39:19', 0);
INSERT INTO `t_areas` VALUES (37661, 1212, 320804, '淮阴区', 3, 116, '淮安市', 11, '江苏省', 20, '223300', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37663, 1391, 340722, '枞阳县', 3, 139, '铜陵市', 13, '安徽省', 20, '246700', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37665, 1637, 361102, '信州区', 3, 169, '上饶市', 15, '江西省', 20, '334000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37667, 2858, 530721, '玉龙纳西族自治县', 3, 307, '丽江市', 26, '云南省', 20, '674100', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37669, 3397, 340706, '义安区', 3, 139, '铜陵市', 13, '安徽省', 20, '244100', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37671, 1216, 320830, '盱眙县', 3, 116, '淮安市', 11, '江苏省', 20, '211700', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37673, 161, 360300, '萍乡市', 2, 15, '江西省', NULL, NULL, 20, '0', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37675, 140, 340800, '安庆市', 2, 13, '安徽省', NULL, NULL, 20, '0', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37677, 1217, 320831, '金湖县', 3, 116, '淮安市', 11, '江苏省', 20, '211600', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37679, 2857, 530702, '古城区', 3, 307, '丽江市', 26, '云南省', 20, '674100', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37681, 1392, 340882, '潜山市', 3, 140, '安庆市', 13, '安徽省', 20, '246300', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37683, 1562, 360302, '安源区', 3, 161, '萍乡市', 15, '江西省', 20, '337000', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37685, 2861, 530724, '宁蒗彝族自治县', 3, 307, '丽江市', 26, '云南省', 20, '674300', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37687, 1566, 360323, '芦溪县', 3, 161, '萍乡市', 15, '江西省', 20, '337053', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37689, 1215, 320813, '洪泽区', 3, 116, '淮安市', 11, '江苏省', 20, '223100', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37691, 1394, 340826, '宿松县', 3, 140, '安庆市', 13, '安徽省', 20, '246500', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37693, 2859, 530722, '永胜县', 3, 307, '丽江市', 26, '云南省', 20, '674200', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37695, 1565, 360322, '上栗县', 3, 161, '萍乡市', 15, '江西省', 20, '337009', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37697, 1214, 320826, '涟水县', 3, 116, '淮安市', 11, '江苏省', 20, '223400', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37699, 1398, 340811, '宜秀区', 3, 140, '安庆市', 13, '安徽省', 20, '246003', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37701, 2860, 530723, '华坪县', 3, 307, '丽江市', 26, '云南省', 20, '674800', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37703, 1564, 360321, '莲花县', 3, 161, '萍乡市', 15, '江西省', 20, '337100', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37705, 3393, 320812, '清江浦区', 3, 116, '淮安市', 11, '江苏省', 20, '223001', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37707, 1393, 340825, '太湖县', 3, 140, '安庆市', 13, '安徽省', 20, '246400', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37709, 317, 533400, '迪庆藏族自治州', 2, 26, '云南省', NULL, NULL, 20, '0', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37711, 3460, 320803, '淮安区', 3, 116, '淮安市', 11, '江苏省', 20, NULL, '2020-08-04 00:58:06', '2020-08-06 22:39:19', 0);
INSERT INTO `t_areas` VALUES (37713, 1563, 360313, '湘东区', 3, 161, '萍乡市', 15, '江西省', 20, '337016', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37715, 2936, 533422, '德钦县', 3, 317, '迪庆藏族自治州', 26, '云南省', 20, '674500', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37717, 118, 321000, '扬州市', 2, 11, '江苏省', NULL, NULL, 20, '0', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37719, 1396, 340828, '岳西县', 3, 140, '安庆市', 13, '安徽省', 20, '246600', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37721, 167, 360900, '宜春市', 2, 15, '江西省', NULL, NULL, 20, '0', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37723, 2935, 533401, '香格里拉市', 3, 317, '迪庆藏族自治州', 26, '云南省', 20, '674400', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37725, 1228, 321003, '邗江区', 3, 118, '扬州市', 11, '江苏省', 20, '225002', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37727, 1617, 360921, '奉新县', 3, 167, '宜春市', 15, '江西省', 20, '330700', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37729, 1388, 340802, '迎江区', 3, 140, '安庆市', 13, '安徽省', 20, '246001', '2020-08-04 00:58:06', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37731, 2937, 533423, '维西傈僳族自治县', 3, 317, '迪庆藏族自治州', 26, '云南省', 20, '674600', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37733, 1227, 321002, '广陵区', 3, 118, '扬州市', 11, '江苏省', 20, '225002', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37735, 1397, 340881, '桐城市', 3, 140, '安庆市', 13, '安徽省', 20, '231400', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37737, 1620, 360924, '宜丰县', 3, 167, '宜春市', 15, '江西省', 20, '336300', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37739, 1230, 321081, '仪征市', 3, 118, '扬州市', 11, '江苏省', 20, '211400', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37741, 313, 532800, '西双版纳傣族自治州', 2, 26, '云南省', NULL, NULL, 20, '0', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37743, 1395, 340827, '望江县', 3, 140, '安庆市', 13, '安徽省', 20, '246200', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37745, 1625, 360983, '高安市', 3, 167, '宜春市', 15, '江西省', 20, '330800', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37747, 2911, 532801, '景洪市', 3, 313, '西双版纳傣族自治州', 26, '云南省', 20, '666100', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37749, 1623, 360981, '丰城市', 3, 167, '宜春市', 15, '江西省', 20, '331100', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37751, 1231, 321084, '高邮市', 3, 118, '扬州市', 11, '江苏省', 20, '225600', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37753, 1619, 360923, '上高县', 3, 167, '宜春市', 15, '江西省', 20, '336400', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37755, 2912, 532822, '勐海县', 3, 313, '西双版纳傣族自治州', 26, '云南省', 20, '666200', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37757, 1390, 340822, '怀宁县', 3, 140, '安庆市', 13, '安徽省', 20, '246100', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37759, 1229, 321023, '宝应县', 3, 118, '扬州市', 11, '江苏省', 20, '225800', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37761, 1622, 360926, '铜鼓县', 3, 167, '宜春市', 15, '江西省', 20, '336200', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37763, 2913, 532823, '勐腊县', 3, 313, '西双版纳傣族自治州', 26, '云南省', 20, '666300', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37765, 1232, 321012, '江都区', 3, 118, '扬州市', 11, '江苏省', 20, '225200', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37767, 1389, 340803, '大观区', 3, 140, '安庆市', 13, '安徽省', 20, '246002', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37769, 302, 530100, '昆明市', 2, 26, '云南省', NULL, NULL, 20, '0', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37771, 1616, 360902, '袁州区', 3, 167, '宜春市', 15, '江西省', 20, '336000', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37773, 120, 321200, '泰州市', 2, 11, '江苏省', NULL, NULL, 20, '0', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37775, 148, 341700, '池州市', 2, 13, '安徽省', NULL, NULL, 20, '0', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37777, 1245, 321282, '靖江市', 3, 120, '泰州市', 11, '江苏省', 20, '214500', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37779, 1618, 360922, '万载县', 3, 167, '宜春市', 15, '江西省', 20, '336100', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37781, 2813, 530113, '东川区', 3, 302, '昆明市', 26, '云南省', 20, '654100', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37783, 1447, 341723, '青阳县', 3, 148, '池州市', 13, '安徽省', 20, '242800', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37785, 1246, 321283, '泰兴市', 3, 120, '泰州市', 11, '江苏省', 20, '225400', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37787, 1624, 360982, '樟树市', 3, 167, '宜春市', 15, '江西省', 20, '331200', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37789, 2821, 530129, '寻甸回族彝族自治县', 3, 302, '昆明市', 26, '云南省', 20, '655200', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37791, 1445, 341721, '东至县', 3, 148, '池州市', 13, '安徽省', 20, '247200', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37793, 1244, 321281, '兴化市', 3, 120, '泰州市', 11, '江苏省', 20, '225700', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37795, 2809, 530102, '五华区', 3, 302, '昆明市', 26, '云南省', 20, '650032', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37797, 1621, 360925, '靖安县', 3, 167, '宜春市', 15, '江西省', 20, '330600', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37799, 1444, 341702, '贵池区', 3, 148, '池州市', 13, '安徽省', 20, '247100', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37801, 1247, 321204, '姜堰区', 3, 120, '泰州市', 11, '江苏省', 20, '225500', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37803, 2812, 530112, '西山区', 3, 302, '昆明市', 26, '云南省', 20, '650100', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37805, 159, 360100, '南昌市', 2, 15, '江西省', NULL, NULL, 20, '0', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37807, 1446, 341722, '石台县', 3, 148, '池州市', 13, '安徽省', 20, '245100', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37809, 1243, 321203, '高港区', 3, 120, '泰州市', 11, '江苏省', 20, '225321', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37811, 1552, 360124, '进贤县', 3, 159, '南昌市', 15, '江西省', 20, '331700', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37813, 2817, 530125, '宜良县', 3, 302, '昆明市', 26, '云南省', 20, '652100', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37815, 137, 340500, '马鞍山市', 2, 13, '安徽省', NULL, NULL, 20, '0', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37817, 2818, 530126, '石林彝族自治县', 3, 302, '昆明市', 26, '云南省', 20, '652200', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37819, 1242, 321202, '海陵区', 3, 120, '泰州市', 11, '江苏省', 20, '225300', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37821, 1546, 360104, '青云谱区', 3, 159, '南昌市', 15, '江西省', 20, '330001', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37823, 3395, 340506, '博望区', 3, 137, '马鞍山市', 13, '安徽省', 20, '243131', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37825, 2814, 530114, '呈贡区', 3, 302, '昆明市', 26, '云南省', 20, '650500', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37827, 1549, 360121, '南昌县', 3, 159, '南昌市', 15, '江西省', 20, '330200', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37829, 2815, 530115, '晋宁区', 3, 302, '昆明市', 26, '云南省', 20, '650600', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37831, 117, 320900, '盐城市', 2, 11, '江苏省', NULL, NULL, 20, '0', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37833, 1548, 360111, '青山湖区', 3, 159, '南昌市', 15, '江西省', 20, '330029', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37835, 1378, 340521, '当涂县', 3, 137, '马鞍山市', 13, '安徽省', 20, '243100', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37837, 2822, 530181, '安宁市', 3, 302, '昆明市', 26, '云南省', 20, '650300', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37839, 1222, 320923, '阜宁县', 3, 117, '盐城市', 11, '江苏省', 20, '224400', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37841, 1375, 340504, '雨山区', 3, 137, '马鞍山市', 13, '安徽省', 20, '243071', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37843, 2816, 530124, '富民县', 3, 302, '昆明市', 26, '云南省', 20, '650400', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37845, 1544, 360102, '东湖区', 3, 159, '南昌市', 15, '江西省', 20, '330006', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37847, 1221, 320922, '滨海县', 3, 117, '盐城市', 11, '江苏省', 20, '224500', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37849, 2820, 530128, '禄劝彝族苗族自治县', 3, 302, '昆明市', 26, '云南省', 20, '651500', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37851, 1376, 340503, '花山区', 3, 137, '马鞍山市', 13, '安徽省', 20, '243000', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37853, 1550, 360112, '新建区', 3, 159, '南昌市', 15, '江西省', 20, '330100', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37855, 1223, 320924, '射阳县', 3, 117, '盐城市', 11, '江苏省', 20, '224300', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37857, 2811, 530111, '官渡区', 3, 302, '昆明市', 26, '云南省', 20, '650220', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37859, 1432, 340523, '和县', 3, 137, '马鞍山市', 13, '安徽省', 20, '238200', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37861, 1224, 320925, '建湖县', 3, 117, '盐城市', 11, '江苏省', 20, '224700', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37863, 1554, 360113, '红谷滩区', 3, 159, '南昌市', 15, '江西省', 20, '330038', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37865, 2810, 530103, '盘龙区', 3, 302, '昆明市', 26, '云南省', 20, '650051', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37867, 1431, 340522, '含山县', 3, 137, '马鞍山市', 13, '安徽省', 20, '238100', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37869, 1551, 360123, '安义县', 3, 159, '南昌市', 15, '江西省', 20, '330500', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37871, 2819, 530127, '嵩明县', 3, 302, '昆明市', 26, '云南省', 20, '651700', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37873, 1218, 320902, '亭湖区', 3, 117, '盐城市', 11, '江苏省', 20, '224005', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37875, 143, 341200, '阜阳市', 2, 13, '安徽省', NULL, NULL, 20, '0', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37877, 1219, 320903, '盐都区', 3, 117, '盐城市', 11, '江苏省', 20, '224055', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37879, 166, 360800, '吉安市', 2, 15, '江西省', NULL, NULL, 20, '0', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37881, 308, 530800, '普洱市', 2, 26, '云南省', NULL, NULL, 20, '0', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37883, 1418, 341222, '太和县', 3, 143, '阜阳市', 13, '安徽省', 20, '236600', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37885, 1605, 360821, '吉安县', 3, 166, '吉安市', 15, '江西省', 20, '343100', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37887, 1225, 320981, '东台市', 3, 117, '盐城市', 11, '江苏省', 20, '224200', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37889, 2865, 530823, '景东彝族自治县', 3, 308, '普洱市', 26, '云南省', 20, '676200', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37891, 1415, 341203, '颍东区', 3, 143, '阜阳市', 13, '安徽省', 20, '236058', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37893, 1226, 320904, '大丰区', 3, 117, '盐城市', 11, '江苏省', 20, '224100', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37895, 2867, 530825, '镇沅彝族哈尼族拉祜族自治县', 3, 308, '普洱市', 26, '云南省', 20, '666500', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37897, 1609, 360825, '永丰县', 3, 166, '吉安市', 15, '江西省', 20, '331500', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37899, 1417, 341221, '临泉县', 3, 143, '阜阳市', 13, '安徽省', 20, '236400', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37901, 1220, 320921, '响水县', 3, 117, '盐城市', 11, '江苏省', 20, '224600', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37903, 2864, 530822, '墨江哈尼族自治县', 3, 308, '普洱市', 26, '云南省', 20, '654800', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37905, 1606, 360822, '吉水县', 3, 166, '吉安市', 15, '江西省', 20, '331600', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37907, 1416, 341204, '颍泉区', 3, 143, '阜阳市', 13, '安徽省', 20, '236045', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37909, 1614, 360830, '永新县', 3, 166, '吉安市', 15, '江西省', 20, '343400', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37911, 119, 321100, '镇江市', 2, 11, '江苏省', NULL, NULL, 20, '0', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37913, 2866, 530824, '景谷傣族彝族自治县', 3, 308, '普洱市', 26, '云南省', 20, '666400', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37915, 1414, 341202, '颍州区', 3, 143, '阜阳市', 13, '安徽省', 20, '236001', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37917, 1239, 321182, '扬中市', 3, 119, '镇江市', 11, '江苏省', 20, '212200', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37919, 1611, 360827, '遂川县', 3, 166, '吉安市', 15, '江西省', 20, '343900', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37921, 2863, 530821, '宁洱哈尼族彝族自治县', 3, 308, '普洱市', 26, '云南省', 20, '665100', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37923, 1419, 341225, '阜南县', 3, 143, '阜阳市', 13, '安徽省', 20, '236300', '2020-08-04 00:58:07', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37925, 1603, 360802, '吉州区', 3, 166, '吉安市', 15, '江西省', 20, '343000', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37927, 1236, 321111, '润州区', 3, 119, '镇江市', 11, '江苏省', 20, '212004', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37929, 2862, 530802, '思茅区', 3, 308, '普洱市', 26, '云南省', 20, '665000', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37931, 2871, 530829, '西盟佤族自治县', 3, 308, '普洱市', 26, '云南省', 20, '665700', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37933, 1420, 341226, '颍上县', 3, 143, '阜阳市', 13, '安徽省', 20, '236200', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37935, 1612, 360828, '万安县', 3, 166, '吉安市', 15, '江西省', 20, '343800', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37937, 1237, 321112, '丹徒区', 3, 119, '镇江市', 11, '江苏省', 20, '212001', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37939, 1421, 341282, '界首市', 3, 143, '阜阳市', 13, '安徽省', 20, '236500', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37941, 2870, 530828, '澜沧拉祜族自治县', 3, 308, '普洱市', 26, '云南省', 20, '665600', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37943, 1235, 321102, '京口区', 3, 119, '镇江市', 11, '江苏省', 20, '212001', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37945, 1604, 360803, '青原区', 3, 166, '吉安市', 15, '江西省', 20, '343009', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37947, 141, 341000, '黄山市', 2, 13, '安徽省', NULL, NULL, 20, '0', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37949, 2868, 530826, '江城哈尼族彝族自治县', 3, 308, '普洱市', 26, '云南省', 20, '665900', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37951, 1238, 321181, '丹阳市', 3, 119, '镇江市', 11, '江苏省', 20, '212300', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37953, 1613, 360829, '安福县', 3, 166, '吉安市', 15, '江西省', 20, '343200', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37955, 2869, 530827, '孟连傣族拉祜族佤族自治县', 3, 308, '普洱市', 26, '云南省', 20, '665800', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37957, 1240, 321183, '句容市', 3, 119, '镇江市', 11, '江苏省', 20, '210000', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37959, 1400, 341003, '黄山区', 3, 141, '黄山市', 13, '安徽省', 20, '242700', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37961, 1608, 360824, '新干县', 3, 166, '吉安市', 15, '江西省', 20, '331300', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37963, 312, 532600, '文山壮族苗族自治州', 2, 26, '云南省', NULL, NULL, 20, '0', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37965, 113, 320500, '苏州市', 2, 11, '江苏省', NULL, NULL, 20, '0', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37967, 1404, 341023, '黟县', 3, 141, '黄山市', 13, '安徽省', 20, '245500', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37969, 1607, 360823, '峡江县', 3, 166, '吉安市', 15, '江西省', 20, '331400', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37971, 2908, 532626, '丘北县', 3, 312, '文山壮族苗族自治州', 26, '云南省', 20, '663200', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37973, 1188, 320582, '张家港市', 3, 113, '苏州市', 11, '江苏省', 20, '215600', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37975, 1405, 341024, '祁门县', 3, 141, '黄山市', 13, '安徽省', 20, '245600', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37977, 1615, 360881, '井冈山市', 3, 166, '吉安市', 15, '江西省', 20, '343600', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37979, 2909, 532627, '广南县', 3, 312, '文山壮族苗族自治州', 26, '云南省', 20, '663300', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37981, 2904, 532622, '砚山县', 3, 312, '文山壮族苗族自治州', 26, '云南省', 20, '663100', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37983, 1402, 341021, '歙县', 3, 141, '黄山市', 13, '安徽省', 20, '245200', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37985, 1184, 320505, '虎丘区', 3, 113, '苏州市', 11, '江苏省', 20, '215004', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37987, 1610, 360826, '泰和县', 3, 166, '吉安市', 15, '江西省', 20, '343700', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37989, 2905, 532623, '西畴县', 3, 312, '文山壮族苗族自治州', 26, '云南省', 20, '663500', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37991, 1401, 341004, '徽州区', 3, 141, '黄山市', 13, '安徽省', 20, '245061', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37993, 1191, 320585, '太仓市', 3, 113, '苏州市', 11, '江苏省', 20, '215400', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37995, 163, 360500, '新余市', 2, 15, '江西省', NULL, NULL, 20, '0', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37997, 1581, 360521, '分宜县', 3, 163, '新余市', 15, '江西省', 20, '336600', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (37999, 1403, 341022, '休宁县', 3, 141, '黄山市', 13, '安徽省', 20, '245400', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38001, 2903, 532601, '文山市', 3, 312, '文山壮族苗族自治州', 26, '云南省', 20, '663000', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38003, 3392, 320508, '姑苏区', 3, 113, '苏州市', 11, '江苏省', 20, '215008', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38005, 1580, 360502, '渝水区', 3, 163, '新余市', 15, '江西省', 20, '338025', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38007, 1399, 341002, '屯溪区', 3, 141, '黄山市', 13, '安徽省', 20, '245000', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38009, 1190, 320509, '吴江区', 3, 113, '苏州市', 11, '江苏省', 20, '215200', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38011, 2906, 532624, '麻栗坡县', 3, 312, '文山壮族苗族自治州', 26, '云南省', 20, '663600', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38013, 3456, 710000, '台湾省', 1, 0, NULL, NULL, NULL, 20, '710000', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38015, 146, 341500, '六安市', 2, 13, '安徽省', NULL, NULL, 20, '0', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38017, 1186, 320507, '相城区', 3, 113, '苏州市', 11, '江苏省', 20, '215131', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38019, 2907, 532625, '马关县', 3, 312, '文山壮族苗族自治州', 26, '云南省', 20, '663700', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38021, 1439, 341525, '霍山县', 3, 146, '六安市', 13, '安徽省', 20, '237200', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38023, 4, 130000, '河北省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38025, 2910, 532628, '富宁县', 3, 312, '文山壮族苗族自治州', 26, '云南省', 20, '663400', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38027, 3461, 320571, '苏州工业园区', 3, 113, '苏州市', 11, '江苏省', 20, NULL, '2020-08-04 00:58:08', '2020-08-06 22:39:19', 0);
INSERT INTO `t_areas` VALUES (38029, 39, 130200, '唐山市', 2, 4, '河北省', NULL, NULL, 20, '0', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38031, 1434, 341503, '裕安区', 3, 146, '六安市', 13, '安徽省', 20, '237010', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38033, 310, 532300, '楚雄彝族自治州', 2, 26, '云南省', NULL, NULL, 20, '0', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38035, 1187, 320581, '常熟市', 3, 113, '苏州市', 11, '江苏省', 20, '215500', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38037, 453, 130281, '遵化市', 3, 39, '唐山市', 4, '河北省', 20, '064200', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38039, 1438, 341524, '金寨县', 3, 146, '六安市', 13, '安徽省', 20, '237300', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38041, 2885, 532326, '大姚县', 3, 310, '楚雄彝族自治州', 26, '云南省', 20, '675400', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38043, 450, 130227, '迁西县', 3, 39, '唐山市', 4, '河北省', 20, '064300', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38045, 1185, 320506, '吴中区', 3, 113, '苏州市', 11, '江苏省', 20, '215128', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38047, 1433, 341502, '金安区', 3, 146, '六安市', 13, '安徽省', 20, '237000', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38049, 2887, 532328, '元谋县', 3, 310, '楚雄彝族自治州', 26, '云南省', 20, '651300', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38051, 454, 130283, '迁安市', 3, 39, '唐山市', 4, '河北省', 20, '064400', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38053, 3398, 341504, '叶集区', 3, 146, '六安市', 13, '安徽省', 20, '237431', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38055, 1189, 320583, '昆山市', 3, 113, '苏州市', 11, '江苏省', 20, '215300', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38057, 2884, 532325, '姚安县', 3, 310, '楚雄彝族自治州', 26, '云南省', 20, '675300', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38059, 448, 130224, '滦南县', 3, 39, '唐山市', 4, '河北省', 20, '063500', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38061, 1436, 341522, '霍邱县', 3, 146, '六安市', 13, '安徽省', 20, '237400', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38063, 110, 320200, '无锡市', 2, 11, '江苏省', NULL, NULL, 20, '0', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38065, 2882, 532323, '牟定县', 3, 310, '楚雄彝族自治州', 26, '云南省', 20, '675500', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38067, 452, NULL, '唐海县', 3, 39, '唐山市', 4, '河北省', 20, '063200', '2020-08-04 00:58:08', '2020-08-06 23:45:39', 0);
INSERT INTO `t_areas` VALUES (38069, 1437, 341523, '舒城县', 3, 146, '六安市', 13, '安徽省', 20, '231300', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38071, 3390, 320213, '梁溪区', 3, 110, '无锡市', 11, '江苏省', 20, '214000', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38073, 136, 340400, '淮南市', 2, 13, '安徽省', NULL, NULL, 20, '0', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38075, 2883, 532324, '南华县', 3, 310, '楚雄彝族自治州', 26, '云南省', 20, '675200', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38077, 3391, 320214, '新吴区', 3, 110, '无锡市', 11, '江苏省', 20, '214028', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38079, 3462, 130284, '滦州市', 3, 39, '唐山市', 4, '河北省', 20, NULL, '2020-08-04 00:58:08', '2020-08-06 22:39:19', 0);
INSERT INTO `t_areas` VALUES (38081, 1374, 340421, '凤台县', 3, 136, '淮南市', 13, '安徽省', 20, '232100', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38083, 1160, 320281, '江阴市', 3, 110, '无锡市', 11, '江苏省', 20, '214400', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38085, 2889, 532331, '禄丰县', 3, 310, '楚雄彝族自治州', 26, '云南省', 20, '651200', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38087, 449, 130225, '乐亭县', 3, 39, '唐山市', 4, '河北省', 20, '063600', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38089, 451, 130229, '玉田县', 3, 39, '唐山市', 4, '河北省', 20, '064100', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38091, 1159, 320211, '滨湖区', 3, 110, '无锡市', 11, '江苏省', 20, '214062', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38093, 1372, 340405, '八公山区', 3, 136, '淮南市', 13, '安徽省', 20, '232072', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38095, 2880, 532301, '楚雄市', 3, 310, '楚雄彝族自治州', 26, '云南省', 20, '675000', '2020-08-04 00:58:08', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38097, 1373, 340406, '潘集区', 3, 136, '淮南市', 13, '安徽省', 20, '232082', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38099, 2881, 532322, '双柏县', 3, 310, '楚雄彝族自治州', 26, '云南省', 20, '675100', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38101, 441, 130202, '路南区', 3, 39, '唐山市', 4, '河北省', 20, '063017', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38103, 1161, 320282, '宜兴市', 3, 110, '无锡市', 11, '江苏省', 20, '214200', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38105, 2888, 532329, '武定县', 3, 310, '楚雄彝族自治州', 26, '云南省', 20, '651600', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38107, 1157, 320205, '锡山区', 3, 110, '无锡市', 11, '江苏省', 20, '214101', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38109, 445, 130207, '丰南区', 3, 39, '唐山市', 4, '河北省', 20, '063300', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38111, 1369, 340402, '大通区', 3, 136, '淮南市', 13, '安徽省', 20, '232033', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38113, 442, 130203, '路北区', 3, 39, '唐山市', 4, '河北省', 20, '063015', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38115, 2886, 532327, '永仁县', 3, 310, '楚雄彝族自治州', 26, '云南省', 20, '651400', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38117, 1158, 320206, '惠山区', 3, 110, '无锡市', 11, '江苏省', 20, '214174', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38119, 1371, 340404, '谢家集区', 3, 136, '淮南市', 13, '安徽省', 20, '232052', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38121, 309, 530900, '临沧市', 2, 26, '云南省', NULL, NULL, 20, '0', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38123, 446, 130208, '丰润区', 3, 39, '唐山市', 4, '河北省', 20, '064000', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38125, 112, 320400, '常州市', 2, 11, '江苏省', NULL, NULL, 20, '0', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38127, 1370, 340403, '田家庵区', 3, 136, '淮南市', 13, '安徽省', 20, '232000', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38129, 443, 130204, '古冶区', 3, 39, '唐山市', 4, '河北省', 20, '063104', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38131, 2873, 530921, '凤庆县', 3, 309, '临沧市', 26, '云南省', 20, '675900', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38133, 1435, 340422, '寿县', 3, 136, '淮南市', 13, '安徽省', 20, '232200', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38135, 444, 130205, '开平区', 3, 39, '唐山市', 4, '河北省', 20, '063021', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38137, 2874, 530922, '云县', 3, 309, '临沧市', 26, '云南省', 20, '675800', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38139, 1180, 320413, '金坛区', 3, 112, '常州市', 11, '江苏省', 20, '213200', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38141, 47, 131000, '廊坊市', 2, 4, '河北省', NULL, NULL, 20, '0', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38143, 135, 340300, '蚌埠市', 2, 13, '安徽省', NULL, NULL, 20, '0', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38145, 1179, 320481, '溧阳市', 3, 112, '常州市', 11, '江苏省', 20, '213300', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38147, 2875, 530923, '永德县', 3, 309, '临沧市', 26, '云南省', 20, '677600', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38149, 584, 131028, '大厂回族自治县', 3, 47, '廊坊市', 4, '河北省', 20, '065300', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38151, 1365, 340311, '淮上区', 3, 135, '蚌埠市', 13, '安徽省', 20, '233000', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38153, 1177, 320411, '新北区', 3, 112, '常州市', 11, '江苏省', 20, '213001', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38155, 2876, 530924, '镇康县', 3, 309, '临沧市', 26, '云南省', 20, '677704', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38157, 582, 131025, '大城县', 3, 47, '廊坊市', 4, '河北省', 20, '065900', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38159, 1367, 340322, '五河县', 3, 135, '蚌埠市', 13, '安徽省', 20, '233300', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38161, 1178, 320412, '武进区', 3, 112, '常州市', 11, '江苏省', 20, '213161', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38163, 2872, 530902, '临翔区', 3, 309, '临沧市', 26, '云南省', 20, '677000', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38165, 581, 131024, '香河县', 3, 47, '廊坊市', 4, '河北省', 20, '065400', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38167, 1366, 340321, '怀远县', 3, 135, '蚌埠市', 13, '安徽省', 20, '233400', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38169, 1175, 320404, '钟楼区', 3, 112, '常州市', 11, '江苏省', 20, '213002', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38171, 1364, 340304, '禹会区', 3, 135, '蚌埠市', 13, '安徽省', 20, '233000', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38173, 2878, 530926, '耿马傣族佤族自治县', 3, 309, '临沧市', 26, '云南省', 20, '677500', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38175, 583, 131026, '文安县', 3, 47, '廊坊市', 4, '河北省', 20, '065800', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38177, 1174, 320402, '天宁区', 3, 112, '常州市', 11, '江苏省', 20, '213003', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38179, 2877, 530925, '双江拉祜族佤族布朗族傣族自治县', 3, 309, '临沧市', 26, '云南省', 20, '677300', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38181, 1363, 340303, '蚌山区', 3, 135, '蚌埠市', 13, '安徽省', 20, '233000', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38183, 580, 131023, '永清县', 3, 47, '廊坊市', 4, '河北省', 20, '065600', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38185, 111, 320300, '徐州市', 2, 11, '江苏省', NULL, NULL, 20, '0', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38187, 2879, 530927, '沧源佤族自治县', 3, 309, '临沧市', 26, '云南省', 20, '677400', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38189, 1362, 340302, '龙子湖区', 3, 135, '蚌埠市', 13, '安徽省', 20, '233000', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38191, 579, 131022, '固安县', 3, 47, '廊坊市', 4, '河北省', 20, '065500', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38193, 1172, 320381, '新沂市', 3, 111, '徐州市', 11, '江苏省', 20, '221400', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38195, 578, 131003, '广阳区', 3, 47, '廊坊市', 4, '河北省', 20, '065000', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38197, 315, 533100, '德宏傣族景颇族自治州', 2, 26, '云南省', NULL, NULL, 20, '0', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38199, 1166, 320311, '泉山区', 3, 111, '徐州市', 11, '江苏省', 20, '221006', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38201, 1368, 340323, '固镇县', 3, 135, '蚌埠市', 13, '安徽省', 20, '233700', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38203, 2929, 533123, '盈江县', 3, 315, '德宏傣族景颇族自治州', 26, '云南省', 20, '679300', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38205, 586, 131082, '三河市', 3, 47, '廊坊市', 4, '河北省', 20, '065200', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38207, 1167, 320312, '铜山区', 3, 111, '徐州市', 11, '江苏省', 20, '221116', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38209, 134, 340200, '芜湖市', 2, 13, '安徽省', NULL, NULL, 20, '0', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38211, 2928, 533122, '梁河县', 3, 315, '德宏傣族景颇族自治州', 26, '云南省', 20, '679200', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38213, 577, 131002, '安次区', 3, 47, '廊坊市', 4, '河北省', 20, '065000', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38215, 1358, 340222, '繁昌县', 3, 134, '芜湖市', 13, '安徽省', 20, '241200', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38217, 1163, 320303, '云龙区', 3, 111, '徐州市', 11, '江苏省', 20, '221009', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38219, 2930, 533124, '陇川县', 3, 315, '德宏傣族景颇族自治州', 26, '云南省', 20, '678700', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38221, 585, 131081, '霸州市', 3, 47, '廊坊市', 4, '河北省', 20, '065700', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38223, 1360, 340203, '弋江区', 3, 134, '芜湖市', 13, '安徽省', 20, '241000', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38225, 1171, 320324, '睢宁县', 3, 111, '徐州市', 11, '江苏省', 20, '221200', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38227, 40, 130300, '秦皇岛市', 2, 4, '河北省', NULL, NULL, 20, '0', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38229, 3433, 533103, '芒市', 3, 315, '德宏傣族景颇族自治州', 26, '云南省', 20, '533103', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38231, 1173, 320382, '邳州市', 3, 111, '徐州市', 11, '江苏省', 20, '221300', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38233, 464, 130321, '青龙满族自治县', 3, 40, '秦皇岛市', 4, '河北省', 20, '066500', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38235, 1355, 340202, '镜湖区', 3, 134, '芜湖市', 13, '安徽省', 20, '241000', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38237, 1170, 320322, '沛县', 3, 111, '徐州市', 11, '江苏省', 20, '221600', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38239, 1430, 340281, '无为市', 3, 134, '芜湖市', 13, '安徽省', 20, '238300', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38241, 2926, 533102, '瑞丽市', 3, 315, '德宏傣族景颇族自治州', 26, '云南省', 20, '678600', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38243, 467, 130324, '卢龙县', 3, 40, '秦皇岛市', 4, '河北省', 20, '066400', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38245, 1169, 320321, '丰县', 3, 111, '徐州市', 11, '江苏省', 20, '221700', '2020-08-04 00:58:09', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38247, 462, 130303, '山海关区', 3, 40, '秦皇岛市', 4, '河北省', 20, '066200', '2020-08-04 00:58:10', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38249, 1168, 320305, '贾汪区', 3, 111, '徐州市', 11, '江苏省', 20, '221011', '2020-08-04 00:58:10', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38251, 2, 110000, '北京市', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:10', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38253, 1361, 340208, '三山区', 3, 134, '芜湖市', 13, '安徽省', 20, '241000', '2020-08-04 00:58:10', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38255, 14, 350000, '福建省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:10', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38257, 466, 130306, '抚宁区', 3, 40, '秦皇岛市', 4, '河北省', 20, '066300', '2020-08-04 00:58:10', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38259, 36, 110100, '北京城区', 2, 2, '北京市', NULL, NULL, 20, '0', '2020-08-04 00:58:10', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38261, 158, 350900, '宁德市', 2, 14, '福建省', NULL, NULL, 20, '0', '2020-08-04 00:58:10', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38263, 394, 110119, '延庆区', 3, 36, '北京城区', 2, '北京市', 20, '100000', '2020-08-04 00:58:10', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38265, 461, 130302, '海港区', 3, 40, '秦皇岛市', 4, '河北省', 20, '063600', '2020-08-04 00:58:10', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38267, 1356, 340207, '鸠江区', 3, 134, '芜湖市', 13, '安徽省', 20, '241000', '2020-08-04 00:58:10', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38269, 391, 110116, '怀柔区', 3, 36, '北京城区', 2, '北京市', 20, '100000', '2020-08-04 00:58:10', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38271, 463, 130304, '北戴河区', 3, 40, '秦皇岛市', 4, '河北省', 20, '066100', '2020-08-04 00:58:10', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38273, 1539, 350924, '寿宁县', 3, 158, '宁德市', 14, '福建省', 20, '355500', '2020-08-04 00:58:10', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38275, 1357, 340221, '芜湖县', 3, 134, '芜湖市', 13, '安徽省', 20, '241100', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38277, 385, 110109, '门头沟区', 3, 36, '北京城区', 2, '北京市', 20, '100000', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38279, 465, 130322, '昌黎县', 3, 40, '秦皇岛市', 4, '河北省', 20, '066600', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38281, 1538, 350923, '屏南县', 3, 158, '宁德市', 14, '福建省', 20, '352300', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38283, 1359, 340223, '南陵县', 3, 134, '芜湖市', 13, '安徽省', 20, '242400', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38285, 388, 110113, '顺义区', 3, 36, '北京城区', 2, '北京市', 20, '100000', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38287, 44, 130700, '张家口市', 2, 4, '河北省', NULL, NULL, 20, '0', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38289, 1543, 350982, '福鼎市', 3, 158, '宁德市', 14, '福建省', 20, '355200', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38291, 142, 341100, '滁州市', 2, 13, '安徽省', NULL, NULL, 20, '0', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38293, 538, 130722, '张北县', 3, 44, '张家口市', 4, '河北省', 20, '076450', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38295, 1542, 350981, '福安市', 3, 158, '宁德市', 14, '福建省', 20, '355000', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38297, 392, 110117, '平谷区', 3, 36, '北京城区', 2, '北京市', 20, '100000', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38299, 1413, 341182, '明光市', 3, 142, '滁州市', 13, '安徽省', 20, '239400', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38301, 539, 130723, '康保县', 3, 44, '张家口市', 4, '河北省', 20, '076650', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38303, 1537, 350922, '古田县', 3, 158, '宁德市', 14, '福建省', 20, '352200', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38305, 389, 110114, '昌平区', 3, 36, '北京城区', 2, '北京市', 20, '100000', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38307, 1412, 341181, '天长市', 3, 142, '滁州市', 13, '安徽省', 20, '239300', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38309, 1540, 350925, '周宁县', 3, 158, '宁德市', 14, '福建省', 20, '355400', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38311, 540, 130724, '沽源县', 3, 44, '张家口市', 4, '河北省', 20, '076550', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38313, 377, 110101, '东城区', 3, 36, '北京城区', 2, '北京市', 20, '100000', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38315, 1411, 341126, '凤阳县', 3, 142, '滁州市', 13, '安徽省', 20, '233100', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38317, 384, 110108, '海淀区', 3, 36, '北京城区', 2, '北京市', 20, '100000', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38319, 541, 130725, '尚义县', 3, 44, '张家口市', 4, '河北省', 20, '076750', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38321, 1535, 350902, '蕉城区', 3, 158, '宁德市', 14, '福建省', 20, '352100', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38323, 383, 110107, '石景山区', 3, 36, '北京城区', 2, '北京市', 20, '100000', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38325, 1410, 341125, '定远县', 3, 142, '滁州市', 13, '安徽省', 20, '233200', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38327, 1536, 350921, '霞浦县', 3, 158, '宁德市', 14, '福建省', 20, '355100', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38329, 549, 130709, '崇礼区', 3, 44, '张家口市', 4, '河北省', 20, '076350', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38331, 386, 110111, '房山区', 3, 36, '北京城区', 2, '北京市', 20, '100000', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38333, 1541, 350926, '柘荣县', 3, 158, '宁德市', 14, '福建省', 20, '355300', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38335, 545, 130708, '万全区', 3, 44, '张家口市', 4, '河北省', 20, '076250', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38337, 1408, 341122, '来安县', 3, 142, '滁州市', 13, '安徽省', 20, '239200', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38339, 156, 350700, '南平市', 2, 14, '福建省', NULL, NULL, 20, '0', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38341, 382, 110106, '丰台区', 3, 36, '北京城区', 2, '北京市', 20, '100000', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38343, 1407, 341103, '南谯区', 3, 142, '滁州市', 13, '安徽省', 20, '239000', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38345, 548, 130732, '赤城县', 3, 44, '张家口市', 4, '河北省', 20, '075500', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38347, 1520, 350722, '浦城县', 3, 156, '南平市', 14, '福建省', 20, '353400', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38349, 378, 110102, '西城区', 3, 36, '北京城区', 2, '北京市', 20, '100000', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38351, 1406, 341102, '琅琊区', 3, 142, '滁州市', 13, '安徽省', 20, '239000', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38353, 546, 130730, '怀来县', 3, 44, '张家口市', 4, '河北省', 20, '075400', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38355, 1525, 350782, '武夷山市', 3, 156, '南平市', 14, '福建省', 20, '354300', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38357, 390, 110115, '大兴区', 3, 36, '北京城区', 2, '北京市', 20, '100000', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38359, 1409, 341124, '全椒县', 3, 142, '滁州市', 13, '安徽省', 20, '239500', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38361, 536, 130706, '下花园区', 3, 44, '张家口市', 4, '河北省', 20, '075300', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38363, 1527, 350703, '建阳区', 3, 156, '南平市', 14, '福建省', 20, '354200', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38365, 393, 110118, '密云区', 3, 36, '北京城区', 2, '北京市', 20, '100000', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38367, 133, 340100, '合肥市', 2, 13, '安徽省', NULL, NULL, 20, '0', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38369, 5, 140000, '山西省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38371, 547, 130731, '涿鹿县', 3, 44, '张家口市', 4, '河北省', 20, '075600', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38373, 1521, 350723, '光泽县', 3, 156, '南平市', 14, '福建省', 20, '354100', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38375, 1429, 340124, '庐江县', 3, 133, '合肥市', 13, '安徽省', 20, '231500', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38377, 535, 130705, '宣化区', 3, 44, '张家口市', 4, '河北省', 20, '075100', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38379, 1522, 350724, '松溪县', 3, 156, '南平市', 14, '福建省', 20, '353500', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38381, 56, 140800, '运城市', 2, 5, '山西省', NULL, NULL, 20, '0', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38383, 1347, 340111, '包河区', 3, 133, '合肥市', 13, '安徽省', 20, '230041', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38385, 1526, 350783, '建瓯市', 3, 156, '南平市', 14, '福建省', 20, '353100', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38387, 534, 130703, '桥西区', 3, 44, '张家口市', 4, '河北省', 20, '050051', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38389, 663, 140822, '万荣县', 3, 56, '运城市', 5, '山西省', 20, '044200', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38391, 662, 140821, '临猗县', 3, 56, '运城市', 5, '山西省', 20, '044100', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38393, 1519, 350721, '顺昌县', 3, 156, '南平市', 14, '福建省', 20, '353200', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38395, 145, 340181, '巢湖市', 3, 133, '合肥市', 13, '安徽省', 20, '0', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38397, 533, 130702, '桥东区', 3, 44, '张家口市', 4, '河北省', 20, '050011', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38399, 1524, 350781, '邵武市', 3, 156, '南平市', 14, '福建省', 20, '354000', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38401, 1350, 340123, '肥西县', 3, 133, '合肥市', 13, '安徽省', 20, '231200', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38403, 664, 140823, '闻喜县', 3, 56, '运城市', 5, '山西省', 20, '043800', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38405, 544, 130728, '怀安县', 3, 44, '张家口市', 4, '河北省', 20, '076150', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38407, 1523, 350725, '政和县', 3, 156, '南平市', 14, '福建省', 20, '353600', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38409, 1346, 340104, '蜀山区', 3, 133, '合肥市', 13, '安徽省', 20, '230031', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38411, 542, 130726, '蔚县', 3, 44, '张家口市', 4, '河北省', 20, '075700', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38413, 661, 140802, '盐湖区', 3, 56, '运城市', 5, '山西省', 20, '044000', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38415, 1518, 350702, '延平区', 3, 156, '南平市', 14, '福建省', 20, '353000', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38417, 1345, 340103, '庐阳区', 3, 133, '合肥市', 13, '安徽省', 20, '230001', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38419, 543, 130727, '阳原县', 3, 44, '张家口市', 4, '河北省', 20, '075800', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38421, 671, 140830, '芮城县', 3, 56, '运城市', 5, '山西省', 20, '044600', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38423, 46, 130900, '沧州市', 2, 4, '河北省', NULL, NULL, 20, '0', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38425, 1348, 340121, '长丰县', 3, 133, '合肥市', 13, '安徽省', 20, '231100', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38427, 152, 350300, '莆田市', 2, 14, '福建省', NULL, NULL, 20, '0', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38429, 669, 140828, '夏县', 3, 56, '运城市', 5, '山西省', 20, '044400', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38431, 574, 130982, '任丘市', 3, 46, '沧州市', 4, '河北省', 20, '062550', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38433, 1349, 340122, '肥东县', 3, 133, '合肥市', 13, '安徽省', 20, '231600', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38435, 1481, 350322, '仙游县', 3, 152, '莆田市', 14, '福建省', 20, '351200', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38437, 670, 140829, '平陆县', 3, 56, '运城市', 5, '山西省', 20, '044300', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38439, 571, 130929, '献县', 3, 46, '沧州市', 4, '河北省', 20, '062250', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38441, 1344, 340102, '瑶海区', 3, 133, '合肥市', 13, '安徽省', 20, '230011', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38443, 1479, 350304, '荔城区', 3, 152, '莆田市', 14, '福建省', 20, '351100', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38445, 672, 140881, '永济市', 3, 56, '运城市', 5, '山西省', 20, '044500', '2020-08-04 00:58:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38447, 561, 130902, '新华区', 3, 46, '沧州市', 4, '河北省', 20, '050051', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38449, 149, 341800, '宣城市', 2, 13, '安徽省', NULL, NULL, 20, '0', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38451, 1480, 350305, '秀屿区', 3, 152, '莆田市', 14, '福建省', 20, '351152', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38453, 667, 140826, '绛县', 3, 56, '运城市', 5, '山西省', 20, '043600', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38455, 562, 130903, '运河区', 3, 46, '沧州市', 4, '河北省', 20, '061000', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38457, 1450, 341882, '广德市', 3, 149, '宣城市', 13, '安徽省', 20, '242200', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38459, 1477, 350302, '城厢区', 3, 152, '莆田市', 14, '福建省', 20, '351100', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38461, 668, 140827, '垣曲县', 3, 56, '运城市', 5, '山西省', 20, '043700', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38463, 566, 130924, '海兴县', 3, 46, '沧州市', 4, '河北省', 20, '061200', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38465, 1478, 350303, '涵江区', 3, 152, '莆田市', 14, '福建省', 20, '351111', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38467, 1452, 341824, '绩溪县', 3, 149, '宣城市', 13, '安徽省', 20, '245300', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38469, 666, 140825, '新绛县', 3, 56, '运城市', 5, '山西省', 20, '043100', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38471, 1453, 341825, '旌德县', 3, 149, '宣城市', 13, '安徽省', 20, '242600', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38473, 157, 350800, '龙岩市', 2, 14, '福建省', NULL, NULL, 20, '0', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38475, 665, 140824, '稷山县', 3, 56, '运城市', 5, '山西省', 20, '043200', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38477, 569, 130927, '南皮县', 3, 46, '沧州市', 4, '河北省', 20, '061500', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38479, 1534, 350881, '漳平市', 3, 157, '龙岩市', 14, '福建省', 20, '364400', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38481, 1448, 341802, '宣州区', 3, 149, '宣城市', 13, '安徽省', 20, '242000', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38483, 673, 140882, '河津市', 3, 56, '运城市', 5, '山西省', 20, '043300', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38485, 565, 130923, '东光县', 3, 46, '沧州市', 4, '河北省', 20, '061600', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38487, 1454, 341881, '宁国市', 3, 149, '宣城市', 13, '安徽省', 20, '242300', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38489, 58, 141000, '临汾市', 2, 5, '山西省', NULL, NULL, 20, '0', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38491, 1531, 350823, '上杭县', 3, 157, '龙岩市', 14, '福建省', 20, '364200', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38493, 570, 130928, '吴桥县', 3, 46, '沧州市', 4, '河北省', 20, '061800', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38495, 1449, 341821, '郎溪县', 3, 149, '宣城市', 13, '安徽省', 20, '242100', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38497, 693, 141025, '古县', 3, 58, '临汾市', 5, '山西省', 20, '042400', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38499, 1532, 350824, '武平县', 3, 157, '龙岩市', 14, '福建省', 20, '364300', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38501, 575, 130983, '黄骅市', 3, 46, '沧州市', 4, '河北省', 20, '061100', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38503, 694, 141026, '安泽县', 3, 58, '临汾市', 5, '山西省', 20, '042500', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38505, 1530, 350803, '永定区', 3, 157, '龙岩市', 14, '福建省', 20, '364100', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38507, 1451, 341823, '泾县', 3, 149, '宣城市', 13, '安徽省', 20, '242500', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38509, 564, 130922, '青县', 3, 46, '沧州市', 4, '河北省', 20, '062650', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38511, 147, 341600, '亳州市', 2, 13, '安徽省', NULL, NULL, 20, '0', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38513, 698, 141030, '大宁县', 3, 58, '临汾市', 5, '山西省', 20, '042300', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38515, 563, 130921, '沧县', 3, 46, '沧州市', 4, '河北省', 20, '061000', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38517, 1528, 350802, '新罗区', 3, 157, '龙岩市', 14, '福建省', 20, '364000', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38519, 1529, 350821, '长汀县', 3, 157, '龙岩市', 14, '福建省', 20, '366300', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38521, 1440, 341602, '谯城区', 3, 147, '亳州市', 13, '安徽省', 20, '236800', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38523, 573, 130981, '泊头市', 3, 46, '沧州市', 4, '河北省', 20, '062150', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38525, 702, 141034, '汾西县', 3, 58, '临汾市', 5, '山西省', 20, '031500', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38527, 576, 130984, '河间市', 3, 46, '沧州市', 4, '河北省', 20, '062450', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38529, 1533, 350825, '连城县', 3, 157, '龙岩市', 14, '福建省', 20, '366200', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38531, 699, 141031, '隰县', 3, 58, '临汾市', 5, '山西省', 20, '041300', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38533, 1443, 341623, '利辛县', 3, 147, '亳州市', 13, '安徽省', 20, '236700', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38535, 568, 130926, '肃宁县', 3, 46, '沧州市', 4, '河北省', 20, '062350', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38537, 150, 350100, '福州市', 2, 14, '福建省', NULL, NULL, 20, '0', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38539, 696, 141028, '吉县', 3, 58, '临汾市', 5, '山西省', 20, '042200', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38541, 1442, 341622, '蒙城县', 3, 147, '亳州市', 13, '安徽省', 20, '233500', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38543, 572, 130930, '孟村回族自治县', 3, 46, '沧州市', 4, '河北省', 20, '061400', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38545, 703, 141081, '侯马市', 3, 58, '临汾市', 5, '山西省', 20, '043007', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38547, 1461, 350122, '连江县', 3, 150, '福州市', 14, '福建省', 20, '350500', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38549, 1441, 341621, '涡阳县', 3, 147, '亳州市', 13, '安徽省', 20, '233600', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38551, 567, 130925, '盐山县', 3, 46, '沧州市', 4, '河北省', 20, '061300', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38553, 1462, 350123, '罗源县', 3, 150, '福州市', 14, '福建省', 20, '350600', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38555, 700, 141032, '永和县', 3, 58, '临汾市', 5, '山西省', 20, '041400', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38557, 144, 341300, '宿州市', 2, 13, '安徽省', NULL, NULL, 20, '0', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38559, 41, 130400, '邯郸市', 2, 4, '河北省', NULL, NULL, 20, '0', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38561, 1463, 350124, '闽清县', 3, 150, '福州市', 14, '福建省', 20, '350800', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38563, 1423, 341302, '埇桥区', 3, 144, '宿州市', 13, '安徽省', 20, '234000', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38565, 487, 130481, '武安市', 3, 41, '邯郸市', 4, '河北省', 20, '056300', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38567, 1460, 350121, '闽侯县', 3, 150, '福州市', 14, '福建省', 20, '350100', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38569, 704, 141082, '霍州市', 3, 58, '临汾市', 5, '山西省', 20, '031400', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38571, 1457, 350104, '仓山区', 3, 150, '福州市', 14, '福建省', 20, '350007', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38573, 1427, 341324, '泗县', 3, 144, '宿州市', 13, '安徽省', 20, '234300', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38575, 697, 141029, '乡宁县', 3, 58, '临汾市', 5, '山西省', 20, '042100', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38577, 474, 130423, '临漳县', 3, 41, '邯郸市', 4, '河北省', 20, '056600', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38579, 1464, 350125, '永泰县', 3, 150, '福州市', 14, '福建省', 20, '350700', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38581, 1425, 341322, '萧县', 3, 144, '宿州市', 13, '安徽省', 20, '235200', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38583, 485, 130434, '魏县', 3, 41, '邯郸市', 4, '河北省', 20, '056800', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38585, 689, 141021, '曲沃县', 3, 58, '临汾市', 5, '山西省', 20, '043400', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38587, 1426, 341323, '灵璧县', 3, 144, '宿州市', 13, '安徽省', 20, '234200', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38589, 1466, 350181, '福清市', 3, 150, '福州市', 14, '福建省', 20, '350300', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38591, 701, 141033, '蒲县', 3, 58, '临汾市', 5, '山西省', 20, '041200', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38593, 472, 130406, '峰峰矿区', 3, 41, '邯郸市', 4, '河北省', 20, '056200', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38595, 1424, 341321, '砀山县', 3, 144, '宿州市', 13, '安徽省', 20, '235300', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38597, 1467, 350112, '长乐区', 3, 150, '福州市', 14, '福建省', 20, '350200', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38599, 695, 141027, '浮山县', 3, 58, '临汾市', 5, '山西省', 20, '042600', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38601, 25, 520000, '贵州省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38603, 479, 130407, '肥乡区', 3, 41, '邯郸市', 4, '河北省', 20, '057550', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38605, 1465, 350128, '平潭县', 3, 150, '福州市', 14, '福建省', 20, '350400', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38607, 691, 141023, '襄汾县', 3, 58, '临汾市', 5, '山西省', 20, '041500', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38609, 294, 520200, '六盘水市', 2, 25, '贵州省', NULL, NULL, 20, '0', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38611, 1456, 350103, '台江区', 3, 150, '福州市', 14, '福建省', 20, '350004', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38613, 477, 130426, '涉县', 3, 41, '邯郸市', 4, '河北省', 20, '056400', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38615, 692, 141024, '洪洞县', 3, 58, '临汾市', 5, '山西省', 20, '031600', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38617, 2731, 520201, '钟山区', 3, 294, '六盘水市', 25, '贵州省', 20, '553000', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38619, 1458, 350105, '马尾区', 3, 150, '福州市', 14, '福建省', 20, '350015', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38621, 688, 141002, '尧都区', 3, 58, '临汾市', 5, '山西省', 20, '041000', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38623, 482, 130431, '鸡泽县', 3, 41, '邯郸市', 4, '河北省', 20, '057350', '2020-08-04 00:58:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38625, 2732, 520203, '六枝特区', 3, 294, '六盘水市', 25, '贵州省', 20, '553400', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38627, 690, 141022, '翼城县', 3, 58, '临汾市', 5, '山西省', 20, '043500', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38629, 1459, 350111, '晋安区', 3, 150, '福州市', 14, '福建省', 20, '350011', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38631, 486, 130435, '曲周县', 3, 41, '邯郸市', 4, '河北省', 20, '057250', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38633, 3428, 520281, '盘州市', 3, 294, '六盘水市', 25, '贵州省', 20, '520281', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38635, 49, 140100, '太原市', 2, 5, '山西省', NULL, NULL, 20, '0', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38637, 153, 350400, '三明市', 2, 14, '福建省', NULL, NULL, 20, '0', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38639, 2733, 520221, '水城县', 3, 294, '六盘水市', 25, '贵州省', 20, '553000', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38641, 603, 140109, '万柏林区', 3, 49, '太原市', 5, '山西省', 20, '030027', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38643, 478, 130427, '磁县', 3, 41, '邯郸市', 4, '河北省', 20, '056500', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38645, 297, 520600, '铜仁市', 2, 25, '贵州省', NULL, NULL, 20, '0', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38647, 604, 140110, '晋源区', 3, 49, '太原市', 5, '山西省', 20, '030025', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38649, 471, 130404, '复兴区', 3, 41, '邯郸市', 4, '河北省', 20, '056003', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38651, 1491, 350429, '泰宁县', 3, 153, '三明市', 14, '福建省', 20, '354400', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38653, 2758, 520623, '石阡县', 3, 297, '铜仁市', 25, '贵州省', 20, '555100', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38655, 602, 140108, '尖草坪区', 3, 49, '太原市', 5, '山西省', 20, '030003', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38657, 470, 130403, '丛台区', 3, 41, '邯郸市', 4, '河北省', 20, '056004', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38659, 1482, 350402, '梅列区', 3, 153, '三明市', 14, '福建省', 20, '365000', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38661, 607, 140123, '娄烦县', 3, 49, '太原市', 5, '山西省', 20, '030300', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38663, 2760, 520625, '印江土家族苗族自治县', 3, 297, '铜仁市', 25, '贵州省', 20, '555200', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38665, 480, 130408, '永年区', 3, 41, '邯郸市', 4, '河北省', 20, '057150', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38667, 1486, 350424, '宁化县', 3, 153, '三明市', 14, '福建省', 20, '365400', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38669, 2761, 520626, '德江县', 3, 297, '铜仁市', 25, '贵州省', 20, '565200', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38671, 601, 140107, '杏花岭区', 3, 49, '太原市', 5, '山西省', 20, '030001', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38673, 1485, 350423, '清流县', 3, 153, '三明市', 14, '福建省', 20, '365300', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38675, 469, 130402, '邯山区', 3, 41, '邯郸市', 4, '河北省', 20, '056001', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38677, 3431, 520602, '碧江区', 3, 297, '铜仁市', 25, '贵州省', 20, '520602', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38679, 600, 140106, '迎泽区', 3, 49, '太原市', 5, '山西省', 20, '030024', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38681, 1493, 350481, '永安市', 3, 153, '三明市', 14, '福建省', 20, '366000', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38683, 475, 130424, '成安县', 3, 41, '邯郸市', 4, '河北省', 20, '056700', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38685, 2756, 520621, '江口县', 3, 297, '铜仁市', 25, '贵州省', 20, '554400', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38687, 606, 140122, '阳曲县', 3, 49, '太原市', 5, '山西省', 20, '030100', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38689, 484, 130433, '馆陶县', 3, 41, '邯郸市', 4, '河北省', 20, '057750', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38691, 1483, 350403, '三元区', 3, 153, '三明市', 14, '福建省', 20, '365001', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38693, 3432, 520603, '万山区', 3, 297, '铜仁市', 25, '贵州省', 20, '554200', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38695, 605, 140121, '清徐县', 3, 49, '太原市', 5, '山西省', 20, '030400', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38697, 481, 130430, '邱县', 3, 41, '邯郸市', 4, '河北省', 20, '057450', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38699, 1487, 350425, '大田县', 3, 153, '三明市', 14, '福建省', 20, '366100', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38701, 2763, 520628, '松桃苗族自治县', 3, 297, '铜仁市', 25, '贵州省', 20, '554100', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38703, 599, 140105, '小店区', 3, 49, '太原市', 5, '山西省', 20, '030032', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38705, 1488, 350426, '尤溪县', 3, 153, '三明市', 14, '福建省', 20, '365100', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38707, 476, 130425, '大名县', 3, 41, '邯郸市', 4, '河北省', 20, '056900', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38709, 1492, 350430, '建宁县', 3, 153, '三明市', 14, '福建省', 20, '354500', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38711, 608, 140181, '古交市', 3, 49, '太原市', 5, '山西省', 20, '030200', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38713, 483, 130432, '广平县', 3, 41, '邯郸市', 4, '河北省', 20, '057650', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38715, 2762, 520627, '沿河土家族自治县', 3, 297, '铜仁市', 25, '贵州省', 20, '565300', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38717, 1489, 350427, '沙县', 3, 153, '三明市', 14, '福建省', 20, '365500', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38719, 42, 130500, '邢台市', 2, 4, '河北省', NULL, NULL, 20, '0', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38721, 51, 140300, '阳泉市', 2, 5, '山西省', NULL, NULL, 20, '0', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38723, 1484, 350421, '明溪县', 3, 153, '三明市', 14, '福建省', 20, '365200', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38725, 2759, 520624, '思南县', 3, 297, '铜仁市', 25, '贵州省', 20, '565100', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38727, 493, 130523, '内丘县', 3, 42, '邢台市', 4, '河北省', 20, '054200', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38729, 623, 140321, '平定县', 3, 51, '阳泉市', 5, '山西省', 20, '045200', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38731, 2757, 520622, '玉屏侗族自治县', 3, 297, '铜仁市', 25, '贵州省', 20, '554004', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38733, 1490, 350428, '将乐县', 3, 153, '三明市', 14, '福建省', 20, '353300', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38735, 494, 130524, '柏乡县', 3, 42, '邢台市', 4, '河北省', 20, '055450', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38737, 621, 140303, '矿区', 3, 51, '阳泉市', 5, '山西省', 20, '037001', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38739, 295, 520300, '遵义市', 2, 25, '贵州省', NULL, NULL, 20, '0', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38741, 154, 350500, '泉州市', 2, 14, '福建省', NULL, NULL, 20, '0', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38743, 500, 130530, '新河县', 3, 42, '邢台市', 4, '河北省', 20, '051730', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38745, 624, 140322, '盂县', 3, 51, '阳泉市', 5, '山西省', 20, '045100', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38747, 2739, 520323, '绥阳县', 3, 295, '遵义市', 25, '贵州省', 20, '563300', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38749, 620, 140302, '城区', 3, 51, '阳泉市', 5, '山西省', 20, '037008', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38751, 1501, 350526, '德化县', 3, 154, '泉州市', 14, '福建省', 20, '362500', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38753, 497, 130527, '南和区', 3, 42, '邢台市', 4, '河北省', 20, '054400', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38755, 2744, 520328, '湄潭县', 3, 295, '遵义市', 25, '贵州省', 20, '564100', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38757, 54, 140600, '朔州市', 2, 5, '山西省', NULL, NULL, 20, '0', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38759, 1500, 350525, '永春县', 3, 154, '泉州市', 14, '福建省', 20, '362600', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38761, 506, 130581, '南宫市', 3, 42, '邢台市', 4, '河北省', 20, '055750', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38763, 2738, 520322, '桐梓县', 3, 295, '遵义市', 25, '贵州省', 20, '563200', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38765, 645, 140603, '平鲁区', 3, 54, '朔州市', 5, '山西省', 20, '038600', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38767, 2745, 520329, '余庆县', 3, 295, '遵义市', 25, '贵州省', 20, '564400', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38769, 502, 130532, '平乡县', 3, 42, '邢台市', 4, '河北省', 20, '054500', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38771, 1496, 350504, '洛江区', 3, 154, '泉州市', 14, '福建省', 20, '362011', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38773, 648, 140623, '右玉县', 3, 54, '朔州市', 5, '山西省', 20, '037200', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38775, 1497, 350505, '泉港区', 3, 154, '泉州市', 14, '福建省', 20, '362114', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38777, 507, 130582, '沙河市', 3, 42, '邢台市', 4, '河北省', 20, '054100', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38779, 644, 140602, '朔城区', 3, 54, '朔州市', 5, '山西省', 20, '038500', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38781, 3429, 520304, '播州区', 3, 295, '遵义市', 25, '贵州省', 20, '520304', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38783, 1495, 350503, '丰泽区', 3, 154, '泉州市', 14, '福建省', 20, '362000', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38785, 647, 140622, '应县', 3, 54, '朔州市', 5, '山西省', 20, '037600', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38787, 2748, 520382, '仁怀市', 3, 295, '遵义市', 25, '贵州省', 20, '564500', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38789, 501, 130531, '广宗县', 3, 42, '邢台市', 4, '河北省', 20, '054600', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38791, 1503, 350581, '石狮市', 3, 154, '泉州市', 14, '福建省', 20, '362700', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38793, 2747, 520381, '赤水市', 3, 295, '遵义市', 25, '贵州省', 20, '564700', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38795, 646, 140621, '山阴县', 3, 54, '朔州市', 5, '山西省', 20, '036900', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38797, 504, 130534, '清河县', 3, 42, '邢台市', 4, '河北省', 20, '054800', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38799, 649, 140681, '怀仁市', 3, 54, '朔州市', 5, '山西省', 20, '038300', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38801, 1505, 350583, '南安市', 3, 154, '泉州市', 14, '福建省', 20, '362300', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38803, 492, 130522, '临城县', 3, 42, '邢台市', 4, '河北省', 20, '054300', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38805, 2746, 520330, '习水县', 3, 295, '遵义市', 25, '贵州省', 20, '564600', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38807, 57, 140900, '忻州市', 2, 5, '山西省', NULL, NULL, 20, '0', '2020-08-04 00:58:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38809, 1498, 350521, '惠安县', 3, 154, '泉州市', 14, '福建省', 20, '362100', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38811, 503, 130533, '威县', 3, 42, '邢台市', 4, '河北省', 20, '054700', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38813, 2741, 520325, '道真仡佬族苗族自治县', 3, 295, '遵义市', 25, '贵州省', 20, '563500', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38815, 1504, 350582, '晋江市', 3, 154, '泉州市', 14, '福建省', 20, '362200', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38817, 686, 140932, '偏关县', 3, 57, '忻州市', 5, '山西省', 20, '036400', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38819, 505, 130535, '临西县', 3, 42, '邢台市', 4, '河北省', 20, '054900', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38821, 2740, 520324, '正安县', 3, 295, '遵义市', 25, '贵州省', 20, '563400', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38823, 680, 140926, '静乐县', 3, 57, '忻州市', 5, '山西省', 20, '035100', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38825, 1502, 350527, '金门县', 3, 154, '泉州市', 14, '福建省', 20, '362000', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38827, 498, 130528, '宁晋县', 3, 42, '邢台市', 4, '河北省', 20, '055550', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38829, 2742, 520326, '务川仡佬族苗族自治县', 3, 295, '遵义市', 25, '贵州省', 20, '564300', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38831, 687, 140981, '原平市', 3, 57, '忻州市', 5, '山西省', 20, '034100', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38833, 1494, 350502, '鲤城区', 3, 154, '泉州市', 14, '福建省', 20, '362000', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38835, 2743, 520327, '凤冈县', 3, 295, '遵义市', 25, '贵州省', 20, '564200', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38837, 495, 130525, '隆尧县', 3, 42, '邢台市', 4, '河北省', 20, '055350', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38839, 683, 140929, '岢岚县', 3, 57, '忻州市', 5, '山西省', 20, '036300', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38841, 1499, 350524, '安溪县', 3, 154, '泉州市', 14, '福建省', 20, '362400', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38843, 2736, 520303, '汇川区', 3, 295, '遵义市', 25, '贵州省', 20, '563000', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38845, 3463, 130526, '任泽区', 3, 42, '邢台市', 4, '河北省', 20, NULL, '2020-08-04 00:58:14', '2020-08-06 22:39:19', 0);
INSERT INTO `t_areas` VALUES (38847, 677, 140923, '代县', 3, 57, '忻州市', 5, '山西省', 20, '034200', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38849, 499, 130529, '巨鹿县', 3, 42, '邢台市', 4, '河北省', 20, '055250', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38851, 2735, 520302, '红花岗区', 3, 295, '遵义市', 25, '贵州省', 20, '563000', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38853, 151, 350200, '厦门市', 2, 14, '福建省', NULL, NULL, 20, '0', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38855, 682, 140928, '五寨县', 3, 57, '忻州市', 5, '山西省', 20, '036200', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38857, 490, 130503, '信都区', 3, 42, '邢台市', 4, '河北省', 20, NULL, '2020-08-04 00:58:14', '2020-08-04 01:20:07', 0);
INSERT INTO `t_areas` VALUES (38859, 1470, 350206, '湖里区', 3, 151, '厦门市', 14, '福建省', 20, '361006', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38861, 296, 520400, '安顺市', 2, 25, '贵州省', NULL, NULL, 20, '0', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38863, 679, 140925, '宁武县', 3, 57, '忻州市', 5, '山西省', 20, '036700', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38865, 489, 130502, '襄都区', 3, 42, '邢台市', 4, '河北省', 20, NULL, '2020-08-04 00:58:14', '2020-08-04 01:20:07', 0);
INSERT INTO `t_areas` VALUES (38867, 2749, 520402, '西秀区', 3, 296, '安顺市', 25, '贵州省', 20, '561000', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38869, 1468, 350203, '思明区', 3, 151, '厦门市', 14, '福建省', 20, '361001', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38871, 684, 140930, '河曲县', 3, 57, '忻州市', 5, '山西省', 20, '036500', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38873, 38, 130100, '石家庄市', 2, 4, '河北省', NULL, NULL, 20, '0', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38875, 1473, 350213, '翔安区', 3, 151, '厦门市', 14, '福建省', 20, '361101', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38877, 2754, 520425, '紫云苗族布依族自治县', 3, 296, '安顺市', 25, '贵州省', 20, '550800', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38879, 1469, 350205, '海沧区', 3, 151, '厦门市', 14, '福建省', 20, '361026', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38881, 676, 140922, '五台县', 3, 57, '忻州市', 5, '山西省', 20, '035500', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38883, 675, 140921, '定襄县', 3, 57, '忻州市', 5, '山西省', 20, '035400', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38885, 424, 130123, '正定县', 3, 38, '石家庄市', 4, '河北省', 20, '050800', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38887, 2752, 520423, '镇宁布依族苗族自治县', 3, 296, '安顺市', 25, '贵州省', 20, '561200', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38889, 1471, 350211, '集美区', 3, 151, '厦门市', 14, '福建省', 20, '361021', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38891, 674, 140902, '忻府区', 3, 57, '忻州市', 5, '山西省', 20, '034000', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38893, 436, 130109, '藁城区', 3, 38, '石家庄市', 4, '河北省', 20, '052160', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38895, 1472, 350212, '同安区', 3, 151, '厦门市', 14, '福建省', 20, '361100', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38897, 2753, 520424, '关岭布依族苗族自治县', 3, 296, '安顺市', 25, '贵州省', 20, '561300', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38899, 685, 140931, '保德县', 3, 57, '忻州市', 5, '山西省', 20, '036600', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38901, 432, 130131, '平山县', 3, 38, '石家庄市', 4, '河北省', 20, '050400', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38903, 155, 350600, '漳州市', 2, 14, '福建省', NULL, NULL, 20, '0', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38905, 2750, 520403, '平坝区', 3, 296, '安顺市', 25, '贵州省', 20, '561100', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38907, 681, 140927, '神池县', 3, 57, '忻州市', 5, '山西省', 20, '036100', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38909, 427, 130126, '灵寿县', 3, 38, '石家庄市', 4, '河北省', 20, '050500', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38911, 2751, 520422, '普定县', 3, 296, '安顺市', 25, '贵州省', 20, '562100', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38913, 1516, 350629, '华安县', 3, 155, '漳州市', 14, '福建省', 20, '363800', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38915, 1514, 350627, '南靖县', 3, 155, '漳州市', 14, '福建省', 20, '363600', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38917, 678, 140924, '繁峙县', 3, 57, '忻州市', 5, '山西省', 20, '034300', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38919, 301, 522700, '黔南布依族苗族自治州', 2, 25, '贵州省', NULL, NULL, 20, '0', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38921, 431, 130130, '无极县', 3, 38, '石家庄市', 4, '河北省', 20, '052400', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38923, 1517, 350681, '龙海市', 3, 155, '漳州市', 14, '福建省', 20, '363100', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38925, 55, 140700, '晋中市', 2, 5, '山西省', NULL, NULL, 20, '0', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38927, 428, 130127, '高邑县', 3, 38, '石家庄市', 4, '河北省', 20, '051330', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38929, 2805, 522729, '长顺县', 3, 301, '黔南布依族苗族自治州', 25, '贵州省', 20, '550700', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38931, 1510, 350623, '漳浦县', 3, 155, '漳州市', 14, '福建省', 20, '363200', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38933, 433, 130132, '元氏县', 3, 38, '石家庄市', 4, '河北省', 20, '051130', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38935, 2802, 522726, '独山县', 3, 301, '黔南布依族苗族自治州', 25, '贵州省', 20, '558200', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38937, 654, 140724, '昔阳县', 3, 55, '晋中市', 5, '山西省', 20, '045300', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38939, 1513, 350626, '东山县', 3, 155, '漳州市', 14, '福建省', 20, '363400', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38941, 430, 130129, '赞皇县', 3, 38, '石家庄市', 4, '河北省', 20, '051230', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38943, 2807, 522731, '惠水县', 3, 301, '黔南布依族苗族自治州', 25, '贵州省', 20, '550600', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38945, 653, 140723, '和顺县', 3, 55, '晋中市', 5, '山西省', 20, '032700', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38947, 2803, 522727, '平塘县', 3, 301, '黔南布依族苗族自治州', 25, '贵州省', 20, '558300', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38949, 1511, 350624, '诏安县', 3, 155, '漳州市', 14, '福建省', 20, '363500', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38951, 439, 130110, '鹿泉区', 3, 38, '石家庄市', 4, '河北省', 20, '050200', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38953, 655, 140725, '寿阳县', 3, 55, '晋中市', 5, '山西省', 20, '045400', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38955, 422, 130108, '裕华区', 3, 38, '石家庄市', 4, '河北省', 20, '050081', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38957, 1507, 350602, '芗城区', 3, 155, '漳州市', 14, '福建省', 20, '363000', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38959, 2804, 522728, '罗甸县', 3, 301, '黔南布依族苗族自治州', 25, '贵州省', 20, '550100', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38961, 652, 140722, '左权县', 3, 55, '晋中市', 5, '山西省', 20, '032600', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38963, 2799, 522722, '荔波县', 3, 301, '黔南布依族苗族自治州', 25, '贵州省', 20, '558400', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38965, 417, 130102, '长安区', 3, 38, '石家庄市', 4, '河北省', 20, '050011', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38967, 1508, 350603, '龙文区', 3, 155, '漳州市', 14, '福建省', 20, '363005', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38969, 651, 140721, '榆社县', 3, 55, '晋中市', 5, '山西省', 20, '031800', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38971, 437, 130183, '晋州市', 3, 38, '石家庄市', 4, '河北省', 20, '052200', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38973, 2806, 522730, '龙里县', 3, 301, '黔南布依族苗族自治州', 25, '贵州省', 20, '551200', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38975, 1509, 350622, '云霄县', 3, 155, '漳州市', 14, '福建省', 20, '363300', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38977, 660, 140781, '介休市', 3, 55, '晋中市', 5, '山西省', 20, '031200', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38979, 423, 130121, '井陉县', 3, 38, '石家庄市', 4, '河北省', 20, '050300', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38981, 2800, 522723, '贵定县', 3, 301, '黔南布依族苗族自治州', 25, '贵州省', 20, '551300', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38983, 659, 140729, '灵石县', 3, 55, '晋中市', 5, '山西省', 20, '031300', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38985, 1515, 350628, '平和县', 3, 155, '漳州市', 14, '福建省', 20, '363700', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38987, 421, 130107, '井陉矿区', 3, 38, '石家庄市', 4, '河北省', 20, '050100', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38989, 2808, 522732, '三都水族自治县', 3, 301, '黔南布依族苗族自治州', 25, '贵州省', 20, '558100', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38991, 1512, 350625, '长泰县', 3, 155, '漳州市', 14, '福建省', 20, '363900', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38993, 650, 140702, '榆次区', 3, 55, '晋中市', 5, '山西省', 20, '030600', '2020-08-04 00:58:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38995, 435, 130181, '辛集市', 3, 38, '石家庄市', 4, '河北省', 20, '052300', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38997, 2801, 522725, '瓮安县', 3, 301, '黔南布依族苗族自治州', 25, '贵州省', 20, '550400', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (38999, 438, 130184, '新乐市', 3, 38, '石家庄市', 4, '河北省', 20, '050700', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39001, 31, 640000, '宁夏回族自治区', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39003, 657, 140727, '祁县', 3, 55, '晋中市', 5, '山西省', 20, '030900', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39005, 2798, 522702, '福泉市', 3, 301, '黔南布依族苗族自治州', 25, '贵州省', 20, '550500', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39007, 429, 130128, '深泽县', 3, 38, '石家庄市', 4, '河北省', 20, '052560', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39009, 656, 140703, '太谷区', 3, 55, '晋中市', 5, '山西省', 20, '030800', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39011, 358, 640200, '石嘴山市', 2, 31, '宁夏回族自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39013, 2797, 522701, '都匀市', 3, 301, '黔南布依族苗族自治州', 25, '贵州省', 20, '558000', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39015, 434, 130133, '赵县', 3, 38, '石家庄市', 4, '河北省', 20, '051530', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39017, 299, 520500, '毕节市', 2, 25, '贵州省', NULL, NULL, 20, '0', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39019, 658, 140728, '平遥县', 3, 55, '晋中市', 5, '山西省', 20, '031100', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39021, 3258, 640202, '大武口区', 3, 358, '石嘴山市', 31, '宁夏回族自治区', 20, '753000', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39023, 425, 130111, '栾城区', 3, 38, '石家庄市', 4, '河北省', 20, '051430', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39025, 59, 141100, '吕梁市', 2, 5, '山西省', NULL, NULL, 20, '0', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39027, 3430, 520502, '七星关区', 3, 299, '毕节市', 25, '贵州省', 20, '520502', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39029, 3259, 640205, '惠农区', 3, 358, '石嘴山市', 31, '宁夏回族自治区', 20, '753600', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39031, 426, 130125, '行唐县', 3, 38, '石家庄市', 4, '河北省', 20, '050600', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39033, 2774, 520521, '大方县', 3, 299, '毕节市', 25, '贵州省', 20, '551600', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39035, 715, 141130, '交口县', 3, 59, '吕梁市', 5, '山西省', 20, '032400', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39037, 3260, 640221, '平罗县', 3, 358, '石嘴山市', 31, '宁夏回族自治区', 20, '753400', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39039, 48, 131100, '衡水市', 2, 4, '河北省', NULL, NULL, 20, '0', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39041, 2775, 520522, '黔西县', 3, 299, '毕节市', 25, '贵州省', 20, '551500', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39043, 713, 141128, '方山县', 3, 59, '吕梁市', 5, '山西省', 20, '033100', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39045, 361, 640500, '中卫市', 2, 31, '宁夏回族自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39047, 2776, 520523, '金沙县', 3, 299, '毕节市', 25, '贵州省', 20, '551800', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39049, 712, 141127, '岚县', 3, 59, '吕梁市', 5, '山西省', 20, '033500', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39051, 3272, 640521, '中宁县', 3, 361, '中卫市', 31, '宁夏回族自治区', 20, '755100', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39053, 590, 131122, '武邑县', 3, 48, '衡水市', 4, '河北省', 20, '053400', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39055, 2778, 520525, '纳雍县', 3, 299, '毕节市', 25, '贵州省', 20, '553300', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39057, 709, 141124, '临县', 3, 59, '吕梁市', 5, '山西省', 20, '033200', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39059, 3273, 640522, '海原县', 3, 361, '中卫市', 31, '宁夏回族自治区', 20, '755200', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39061, 591, 131123, '武强县', 3, 48, '衡水市', 4, '河北省', 20, '053300', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39063, 2777, 520524, '织金县', 3, 299, '毕节市', 25, '贵州省', 20, '552100', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39065, 705, 141102, '离石区', 3, 59, '吕梁市', 5, '山西省', 20, '033000', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39067, 3271, 640502, '沙坡头区', 3, 361, '中卫市', 31, '宁夏回族自治区', 20, '755000', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39069, 589, 131121, '枣强县', 3, 48, '衡水市', 4, '河北省', 20, '053100', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39071, 2779, 520526, '威宁彝族回族苗族自治县', 3, 299, '毕节市', 25, '贵州省', 20, '553100', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39073, 360, 640400, '固原市', 2, 31, '宁夏回族自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39075, 588, 131102, '桃城区', 3, 48, '衡水市', 4, '河北省', 20, '053000', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39077, 710, 141125, '柳林县', 3, 59, '吕梁市', 5, '山西省', 20, '033300', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39079, 2780, 520527, '赫章县', 3, 299, '毕节市', 25, '贵州省', 20, '553200', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39081, 598, 131182, '深州市', 3, 48, '衡水市', 4, '河北省', 20, '053800', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39083, 3268, 640423, '隆德县', 3, 360, '固原市', 31, '宁夏回族自治区', 20, '756300', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39085, 714, 141129, '中阳县', 3, 59, '吕梁市', 5, '山西省', 20, '033400', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39087, 300, 522600, '黔东南苗族侗族自治州', 2, 25, '贵州省', NULL, NULL, 20, '0', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39089, 596, 131128, '阜城县', 3, 48, '衡水市', 4, '河北省', 20, '053700', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39091, 3270, 640425, '彭阳县', 3, 360, '固原市', 31, '宁夏回族自治区', 20, '756500', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39093, 708, 141123, '兴县', 3, 59, '吕梁市', 5, '山西省', 20, '033600', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39095, 2784, 522624, '三穗县', 3, 300, '黔东南苗族侗族自治州', 25, '贵州省', 20, '556500', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39097, 593, 131125, '安平县', 3, 48, '衡水市', 4, '河北省', 20, '053600', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39099, 3266, 640402, '原州区', 3, 360, '固原市', 31, '宁夏回族自治区', 20, '756000', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39101, 711, 141126, '石楼县', 3, 59, '吕梁市', 5, '山西省', 20, '032500', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39103, 592, 131124, '饶阳县', 3, 48, '衡水市', 4, '河北省', 20, '053900', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39105, 2792, 522632, '榕江县', 3, 300, '黔东南苗族侗族自治州', 25, '贵州省', 20, '557200', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39107, 707, 141122, '交城县', 3, 59, '吕梁市', 5, '山西省', 20, '030500', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39109, 3269, 640424, '泾源县', 3, 360, '固原市', 31, '宁夏回族自治区', 20, '756400', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39111, 2794, 522634, '雷山县', 3, 300, '黔东南苗族侗族自治州', 25, '贵州省', 20, '557100', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39113, 597, 131103, '冀州区', 3, 48, '衡水市', 4, '河北省', 20, '053200', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39115, 706, 141121, '文水县', 3, 59, '吕梁市', 5, '山西省', 20, '032100', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39117, 3267, 640422, '西吉县', 3, 360, '固原市', 31, '宁夏回族自治区', 20, '756200', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39119, 2787, 522627, '天柱县', 3, 300, '黔东南苗族侗族自治州', 25, '贵州省', 20, '556600', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39121, 595, 131127, '景县', 3, 48, '衡水市', 4, '河北省', 20, '053500', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39123, 357, 640100, '银川市', 2, 31, '宁夏回族自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39125, 717, 141182, '汾阳市', 3, 59, '吕梁市', 5, '山西省', 20, '032200', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39127, 2783, 522623, '施秉县', 3, 300, '黔东南苗族侗族自治州', 25, '贵州省', 20, '556200', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39129, 594, 131126, '故城县', 3, 48, '衡水市', 4, '河北省', 20, '253800', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39131, 3253, 640105, '西夏区', 3, 357, '银川市', 31, '宁夏回族自治区', 20, '750021', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39133, 716, 141181, '孝义市', 3, 59, '吕梁市', 5, '山西省', 20, '032300', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39135, 2785, 522625, '镇远县', 3, 300, '黔东南苗族侗族自治州', 25, '贵州省', 20, '557700', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39137, 43, 130600, '保定市', 2, 4, '河北省', NULL, NULL, 20, '0', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39139, 3255, 640121, '永宁县', 3, 357, '银川市', 31, '宁夏回族自治区', 20, '750100', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39141, 50, 140200, '大同市', 2, 5, '山西省', NULL, NULL, 20, '0', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39143, 2796, 522636, '丹寨县', 3, 300, '黔东南苗族侗族自治州', 25, '贵州省', 20, '557500', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39145, 3254, 640106, '金凤区', 3, 357, '银川市', 31, '宁夏回族自治区', 20, '750011', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39147, 520, 130630, '涞源县', 3, 43, '保定市', 4, '河北省', 20, '074300', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39149, 2781, 522601, '凯里市', 3, 300, '黔东南苗族侗族自治州', 25, '贵州省', 20, '556000', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39151, 617, 140225, '浑源县', 3, 50, '大同市', 5, '山西省', 20, '037400', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39153, 522, 130632, '安新县', 3, 43, '保定市', 4, '河北省', 20, '071600', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39155, 3256, 640122, '贺兰县', 3, 357, '银川市', 31, '宁夏回族自治区', 20, '750200', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39157, 2791, 522631, '黎平县', 3, 300, '黔东南苗族侗族自治州', 25, '贵州省', 20, '557300', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39159, 616, 140224, '灵丘县', 3, 50, '大同市', 5, '山西省', 20, '034400', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39161, 523, 130633, '易县', 3, 43, '保定市', 4, '河北省', 20, '074200', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39163, 3252, 640104, '兴庆区', 3, 357, '银川市', 31, '宁夏回族自治区', 20, '750001', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39165, 615, 140223, '广灵县', 3, 50, '大同市', 5, '山西省', 20, '037500', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39167, 2793, 522633, '从江县', 3, 300, '黔东南苗族侗族自治州', 25, '贵州省', 20, '557400', '2020-08-04 00:58:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39169, 515, 130609, '徐水区', 3, 43, '保定市', 4, '河北省', 20, '072550', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39171, 3257, 640181, '灵武市', 3, 357, '银川市', 31, '宁夏回族自治区', 20, '750004', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39173, 613, 140221, '阳高县', 3, 50, '大同市', 5, '山西省', 20, '038100', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39175, 2789, 522629, '剑河县', 3, 300, '黔东南苗族侗族自治州', 25, '贵州省', 20, '556400', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39177, 526, 130636, '顺平县', 3, 43, '保定市', 4, '河北省', 20, '072250', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39179, 359, 640300, '吴忠市', 2, 31, '宁夏回族自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39181, 3381, 140215, '云州区', 3, 50, '大同市', 5, '山西省', 20, '037000', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39183, 2788, 522628, '锦屏县', 3, 300, '黔东南苗族侗族自治州', 25, '贵州省', 20, '556700', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39185, 518, 130628, '高阳县', 3, 43, '保定市', 4, '河北省', 20, '071500', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39187, 3264, 640381, '青铜峡市', 3, 359, '吴忠市', 31, '宁夏回族自治区', 20, '751600', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39189, 3380, 140214, '云冈区', 3, 50, '大同市', 5, '山西省', 20, '037001', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39191, 3464, 130602, '竞秀区', 3, 43, '保定市', 4, '河北省', 20, NULL, '2020-08-04 00:58:16', '2020-08-06 22:39:19', 0);
INSERT INTO `t_areas` VALUES (39193, 2790, 522630, '台江县', 3, 300, '黔东南苗族侗族自治州', 25, '贵州省', 20, '556300', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39195, 3379, 140213, '平城区', 3, 50, '大同市', 5, '山西省', 20, '037006', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39197, 3263, 640324, '同心县', 3, 359, '吴忠市', 31, '宁夏回族自治区', 20, '751300', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39199, 2782, 522622, '黄平县', 3, 300, '黔东南苗族侗族自治州', 25, '贵州省', 20, '556100', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39201, 511, 130607, '满城区', 3, 43, '保定市', 4, '河北省', 20, '072150', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39203, 3262, 640323, '盐池县', 3, 359, '吴忠市', 31, '宁夏回族自治区', 20, '751500', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39205, 614, 140222, '天镇县', 3, 50, '大同市', 5, '山西省', 20, '038200', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39207, 530, 130682, '定州市', 3, 43, '保定市', 4, '河北省', 20, '073000', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39209, 2795, 522635, '麻江县', 3, 300, '黔东南苗族侗族自治州', 25, '贵州省', 20, '557600', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39211, 612, 140212, '新荣区', 3, 50, '大同市', 5, '山西省', 20, '037002', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39213, 3265, 640303, '红寺堡区', 3, 359, '吴忠市', 31, '宁夏回族自治区', 20, '751900', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39215, 2786, 522626, '岑巩县', 3, 300, '黔东南苗族侗族自治州', 25, '贵州省', 20, '557800', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39217, 3261, 640302, '利通区', 3, 359, '吴忠市', 31, '宁夏回族自治区', 20, '751100', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39219, 531, 130683, '安国市', 3, 43, '保定市', 4, '河北省', 20, '071200', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39221, 618, 140226, '左云县', 3, 50, '大同市', 5, '山西省', 20, '037100', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39223, 298, 522300, '黔西南布依族苗族自治州', 2, 25, '贵州省', NULL, NULL, 20, '0', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39225, 3378, 130606, '莲池区', 3, 43, '保定市', 4, '河北省', 20, '071000', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39227, 32, 650000, '新疆维吾尔自治区', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39229, 52, 140400, '长治市', 2, 5, '山西省', NULL, NULL, 20, '0', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39231, 3451, 659007, '双河市', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '659007', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39233, 2765, 522301, '兴义市', 3, 298, '黔西南布依族苗族自治州', 25, '贵州省', 20, '562400', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39235, 513, 130623, '涞水县', 3, 43, '保定市', 4, '河北省', 20, '074100', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39237, 637, 140406, '潞城区', 3, 52, '长治市', 5, '山西省', 20, '047500', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39239, 2766, 522302, '兴仁市', 3, 298, '黔西南布依族苗族自治州', 25, '贵州省', 20, '562300', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39241, 3449, 659005, '北屯市', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '659005', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39243, 2772, 522328, '安龙县', 3, 298, '黔西南布依族苗族自治州', 25, '贵州省', 20, '552400', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39245, 529, 130681, '涿州市', 3, 43, '保定市', 4, '河北省', 20, '072750', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39247, 633, 140428, '长子县', 3, 52, '长治市', 5, '山西省', 20, '046600', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39249, 367, 652700, '博尔塔拉蒙古自治州', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39251, 527, 130637, '博野县', 3, 43, '保定市', 4, '河北省', 20, '071300', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39253, 2771, 522327, '册亨县', 3, 298, '黔西南布依族苗族自治州', 25, '贵州省', 20, '552200', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39255, 631, 140426, '黎城县', 3, 52, '长治市', 5, '山西省', 20, '047600', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39257, 525, 130635, '蠡县', 3, 43, '保定市', 4, '河北省', 20, '071400', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39259, 3302, 652723, '温泉县', 3, 367, '博尔塔拉蒙古自治州', 32, '新疆维吾尔自治区', 20, '833500', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39261, 2769, 522325, '贞丰县', 3, 298, '黔西南布依族苗族自治州', 25, '贵州省', 20, '562200', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39263, 3383, 140404, '上党区', 3, 52, '长治市', 5, '山西省', 20, '047100', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39265, 514, 130624, '阜平县', 3, 43, '保定市', 4, '河北省', 20, '073200', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39267, 3447, 652702, '阿拉山口市', 3, 367, '博尔塔拉蒙古自治州', 32, '新疆维吾尔自治区', 20, '652702', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39269, 2767, 522323, '普安县', 3, 298, '黔西南布依族苗族自治州', 25, '贵州省', 20, '561500', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39271, 629, 140405, '屯留区', 3, 52, '长治市', 5, '山西省', 20, '046100', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39273, 3300, 652701, '博乐市', 3, 367, '博尔塔拉蒙古自治州', 32, '新疆维吾尔自治区', 20, '833400', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39275, 512, 130608, '清苑区', 3, 43, '保定市', 4, '河北省', 20, '071100', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39277, 2770, 522326, '望谟县', 3, 298, '黔西南布依族苗族自治州', 25, '贵州省', 20, '552300', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39279, 636, 140431, '沁源县', 3, 52, '长治市', 5, '山西省', 20, '046500', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39281, 3301, 652722, '精河县', 3, 367, '博尔塔拉蒙古自治州', 32, '新疆维吾尔自治区', 20, '833300', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39283, 2768, 522324, '晴隆县', 3, 298, '黔西南布依族苗族自治州', 25, '贵州省', 20, '561400', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39285, 521, 130631, '望都县', 3, 43, '保定市', 4, '河北省', 20, '072450', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39287, 293, 520100, '贵阳市', 2, 25, '贵州省', NULL, NULL, 20, '0', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39289, 630, 140425, '平顺县', 3, 52, '长治市', 5, '山西省', 20, '047400', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39291, 3450, 659006, '铁门关市', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '659006', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39293, 524, 130634, '曲阳县', 3, 43, '保定市', 4, '河北省', 20, '073100', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39295, 3452, 659008, '可克达拉市', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '659008', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39297, 2726, 520121, '开阳县', 3, 293, '贵阳市', 25, '贵州省', 20, '550300', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39299, 628, 140423, '襄垣县', 3, 52, '长治市', 5, '山西省', 20, '046200', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39301, 517, 130627, '唐县', 3, 43, '保定市', 4, '河北省', 20, '072350', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39303, 3382, 140403, '潞州区', 3, 52, '长治市', 5, '山西省', 20, '046000', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39305, 362, 650100, '乌鲁木齐市', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39307, 2724, 520113, '白云区', 3, 293, '贵阳市', 25, '贵州省', 20, '014080', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39309, 532, 130684, '高碑店市', 3, 43, '保定市', 4, '河北省', 20, '074000', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39311, 635, 140430, '沁县', 3, 52, '长治市', 5, '山西省', 20, '046400', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39313, 2727, 520122, '息烽县', 3, 293, '贵阳市', 25, '贵州省', 20, '551100', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39315, 3279, 650107, '达坂城区', 3, 362, '乌鲁木齐市', 32, '新疆维吾尔自治区', 20, '830039', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39317, 2728, 520123, '修文县', 3, 293, '贵阳市', 25, '贵州省', 20, '550200', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39319, 519, 130629, '容城县', 3, 43, '保定市', 4, '河北省', 20, '071700', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39321, 3274, 650102, '天山区', 3, 362, '乌鲁木齐市', 32, '新疆维吾尔自治区', 20, '830000', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39323, 634, 140429, '武乡县', 3, 52, '长治市', 5, '山西省', 20, '046300', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39325, 2729, 520181, '清镇市', 3, 293, '贵阳市', 25, '贵州省', 20, '551400', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39327, 3277, 650105, '水磨沟区', 3, 362, '乌鲁木齐市', 32, '新疆维吾尔自治区', 20, '830017', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39329, 632, 140427, '壶关县', 3, 52, '长治市', 5, '山西省', 20, '047300', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39331, 516, 130626, '定兴县', 3, 43, '保定市', 4, '河北省', 20, '072650', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39333, 2723, 520112, '乌当区', 3, 293, '贵阳市', 25, '贵州省', 20, '550018', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39335, 528, 130638, '雄县', 3, 43, '保定市', 4, '河北省', 20, '071800', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39337, 53, 140500, '晋城市', 2, 5, '山西省', NULL, NULL, 20, '0', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39339, 3280, 650109, '米东区', 3, 362, '乌鲁木齐市', 32, '新疆维吾尔自治区', 20, '830019', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39341, 2720, 520102, '南明区', 3, 293, '贵阳市', 25, '贵州省', 20, '550001', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39343, 45, 130800, '承德市', 2, 4, '河北省', NULL, NULL, 20, '0', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39345, 643, 140581, '高平市', 3, 53, '晋城市', 5, '山西省', 20, '048400', '2020-08-04 00:58:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39347, 3278, 650106, '头屯河区', 3, 362, '乌鲁木齐市', 32, '新疆维吾尔自治区', 20, '830022', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39349, 2722, 520111, '花溪区', 3, 293, '贵阳市', 25, '贵州省', 20, '550025', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39351, 560, 130828, '围场满族蒙古族自治县', 3, 45, '承德市', 4, '河北省', 20, '068450', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39353, 642, 140525, '泽州县', 3, 53, '晋城市', 5, '山西省', 20, '048012', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39355, 2721, 520103, '云岩区', 3, 293, '贵阳市', 25, '贵州省', 20, '550001', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39357, 3281, 650121, '乌鲁木齐县', 3, 362, '乌鲁木齐市', 32, '新疆维吾尔自治区', 20, '830063', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39359, 558, 130826, '丰宁满族自治县', 3, 45, '承德市', 4, '河北省', 20, '068350', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39361, 639, 140521, '沁水县', 3, 53, '晋城市', 5, '山西省', 20, '048200', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39363, 3427, 520115, '观山湖区', 3, 293, '贵阳市', 25, '贵州省', 20, '520115', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39365, 3275, 650103, '沙依巴克区', 3, 362, '乌鲁木齐市', 32, '新疆维吾尔自治区', 20, '830002', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39367, 557, 130825, '隆化县', 3, 45, '承德市', 4, '河北省', 20, '068150', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39369, 640, 140522, '阳城县', 3, 53, '晋城市', 5, '山西省', 20, '048100', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39371, 3276, 650104, '新市区', 3, 362, '乌鲁木齐市', 32, '新疆维吾尔自治区', 20, '071052', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39373, 641, 140524, '陵川县', 3, 53, '晋城市', 5, '山西省', 20, '048300', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39375, 559, 130827, '宽城满族自治县', 3, 45, '承德市', 4, '河北省', 20, '067600', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39377, 10, 310000, '上海市', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39379, 3453, 659009, '昆玉市', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '659009', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39381, 29, 620000, '甘肃省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39383, 552, 130804, '鹰手营子矿区', 3, 45, '承德市', 4, '河北省', 20, '067200', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39385, 108, 310100, '上海城区', 2, 10, '上海市', NULL, NULL, 20, '0', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39387, 368, 652800, '巴音郭楞蒙古自治州', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39389, 337, 620300, '金昌市', 2, 29, '甘肃省', NULL, NULL, 20, '0', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39391, 1139, 310120, '奉贤区', 3, 108, '上海城区', 10, '上海市', 20, '201400', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39393, 555, 130881, '平泉市', 3, 45, '承德市', 4, '河北省', 20, '067500', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39395, 3310, 652828, '和硕县', 3, 368, '巴音郭楞蒙古自治州', 32, '新疆维吾尔自治区', 20, '841200', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39397, 3131, 620321, '永昌县', 3, 337, '金昌市', 29, '甘肃省', 20, '737200', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39399, 1140, 310151, '崇明区', 3, 108, '上海城区', 10, '上海市', 20, '202150', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39401, 554, 130822, '兴隆县', 3, 45, '承德市', 4, '河北省', 20, '067300', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39403, 3130, 620302, '金川区', 3, 337, '金昌市', 29, '甘肃省', 20, '737103', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39405, 3309, 652827, '和静县', 3, 368, '巴音郭楞蒙古自治州', 32, '新疆维吾尔自治区', 20, '841300', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39407, 1135, 310116, '金山区', 3, 108, '上海城区', 10, '上海市', 20, '153026', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39409, 556, 130824, '滦平县', 3, 45, '承德市', 4, '河北省', 20, '068250', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39411, 3306, 652824, '若羌县', 3, 368, '巴音郭楞蒙古自治州', 32, '新疆维吾尔自治区', 20, '841800', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39413, 338, 620400, '白银市', 2, 29, '甘肃省', NULL, NULL, 20, '0', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39415, 1134, 310115, '浦东新区', 3, 108, '上海城区', 10, '上海市', 20, '200135', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39417, 3308, 652826, '焉耆回族自治县', 3, 368, '巴音郭楞蒙古自治州', 32, '新疆维吾尔自治区', 20, '841100', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39419, 551, 130803, '双滦区', 3, 45, '承德市', 4, '河北省', 20, '067000', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39421, 3134, 620421, '靖远县', 3, 338, '白银市', 29, '甘肃省', 20, '730600', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39423, 1122, 310101, '黄浦区', 3, 108, '上海城区', 10, '上海市', 20, '200001', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39425, 550, 130802, '双桥区', 3, 45, '承德市', 4, '河北省', 20, '067000', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39427, 3133, 620403, '平川区', 3, 338, '白银市', 29, '甘肃省', 20, '730913', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39429, 3311, 652829, '博湖县', 3, 368, '巴音郭楞蒙古自治州', 32, '新疆维吾尔自治区', 20, '841400', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39431, 1132, 310113, '宝山区', 3, 108, '上海城区', 10, '上海市', 20, '155131', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39433, 3132, 620402, '白银区', 3, 338, '白银市', 29, '甘肃省', 20, '730900', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39435, 3307, 652825, '且末县', 3, 368, '巴音郭楞蒙古自治州', 32, '新疆维吾尔自治区', 20, '841900', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39437, 553, 130821, '承德县', 3, 45, '承德市', 4, '河北省', 20, '067400', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39439, 1133, 310114, '嘉定区', 3, 108, '上海城区', 10, '上海市', 20, '201800', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39441, 3303, 652801, '库尔勒市', 3, 368, '巴音郭楞蒙古自治州', 32, '新疆维吾尔自治区', 20, '841000', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39443, 3136, 620423, '景泰县', 3, 338, '白银市', 29, '甘肃省', 20, '730400', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39445, 3454, 810000, '香港特别行政区', 1, 0, NULL, NULL, NULL, 20, '810000', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39447, 1130, 310110, '杨浦区', 3, 108, '上海城区', 10, '上海市', 20, '200082', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39449, 3135, 620422, '会宁县', 3, 338, '白银市', 29, '甘肃省', 20, '730700', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39451, 3304, 652822, '轮台县', 3, 368, '巴音郭楞蒙古自治州', 32, '新疆维吾尔自治区', 20, '841600', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39453, 1136, 310117, '松江区', 3, 108, '上海城区', 10, '上海市', 20, '201600', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39455, 3305, 652823, '尉犁县', 3, 368, '巴音郭楞蒙古自治州', 32, '新疆维吾尔自治区', 20, '841500', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39457, 343, 620900, '酒泉市', 2, 29, '甘肃省', NULL, NULL, 20, '0', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39459, 1129, 310109, '虹口区', 3, 108, '上海城区', 10, '上海市', 20, '200080', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39461, 372, 653200, '和田地区', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39463, 3162, 620921, '金塔县', 3, 343, '酒泉市', 29, '甘肃省', 20, '735300', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39465, 3344, 653227, '民丰县', 3, 372, '和田地区', 32, '新疆维吾尔自治区', 20, '848500', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39467, 1126, 310106, '静安区', 3, 108, '上海城区', 10, '上海市', 20, '200040', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39469, 3164, 620923, '肃北蒙古族自治县', 3, 343, '酒泉市', 29, '甘肃省', 20, '736300', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39471, 3343, 653226, '于田县', 3, 372, '和田地区', 32, '新疆维吾尔自治区', 20, '848400', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39473, 3166, 620981, '玉门市', 3, 343, '酒泉市', 29, '甘肃省', 20, '735200', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39475, 1125, 310105, '长宁区', 3, 108, '上海城区', 10, '上海市', 20, '200050', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39477, 3337, 653201, '和田市', 3, 372, '和田地区', 32, '新疆维吾尔自治区', 20, '848000', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39479, 3167, 620982, '敦煌市', 3, 343, '酒泉市', 29, '甘肃省', 20, '736200', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39481, 3338, 653221, '和田县', 3, 372, '和田地区', 32, '新疆维吾尔自治区', 20, '848000', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39483, 1131, 310112, '闵行区', 3, 108, '上海城区', 10, '上海市', 20, '201100', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39485, 3161, 620902, '肃州区', 3, 343, '酒泉市', 29, '甘肃省', 20, '735000', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39487, 3342, 653225, '策勒县', 3, 372, '和田地区', 32, '新疆维吾尔自治区', 20, '848300', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39489, 1124, 310104, '徐汇区', 3, 108, '上海城区', 10, '上海市', 20, '200030', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39491, 3443, 620922, '瓜州县', 3, 343, '酒泉市', 29, '甘肃省', 20, '620922', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39493, 3340, 653223, '皮山县', 3, 372, '和田地区', 32, '新疆维吾尔自治区', 20, '845150', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39495, 1137, 310118, '青浦区', 3, 108, '上海城区', 10, '上海市', 20, '201700', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39497, 3165, 620924, '阿克塞哈萨克族自治县', 3, 343, '酒泉市', 29, '甘肃省', 20, '736400', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39499, 3341, 653224, '洛浦县', 3, 372, '和田地区', 32, '新疆维吾尔自治区', 20, '848200', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39501, 19, 430000, '湖南省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39503, 346, 621200, '陇南市', 2, 29, '甘肃省', NULL, NULL, 20, '0', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39505, 3339, 653222, '墨玉县', 3, 372, '和田地区', 32, '新疆维吾尔自治区', 20, '848100', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39507, 3189, 621226, '礼县', 3, 346, '陇南市', 29, '甘肃省', 20, '742200', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39509, 374, 654200, '塔城地区', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39511, 224, 430600, '岳阳市', 2, 19, '湖南省', NULL, NULL, 20, '0', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39513, 3186, 621223, '宕昌县', 3, 346, '陇南市', 29, '甘肃省', 20, '748500', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39515, 3355, 654201, '塔城市', 3, 374, '塔城地区', 32, '新疆维吾尔自治区', 20, '834700', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39517, 2116, 430611, '君山区', 3, 224, '岳阳市', 19, '湖南省', 20, '414005', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39519, 3183, 621202, '武都区', 3, 346, '陇南市', 29, '甘肃省', 20, '746000', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39521, 3357, 654221, '额敏县', 3, 374, '塔城地区', 32, '新疆维吾尔自治区', 20, '834600', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39523, 2115, 430603, '云溪区', 3, 224, '岳阳市', 19, '湖南省', 20, '414009', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39525, 3361, 654226, '和布克赛尔蒙古自治县', 3, 374, '塔城地区', 32, '新疆维吾尔自治区', 20, '834400', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39527, 3187, 621224, '康县', 3, 346, '陇南市', 29, '甘肃省', 20, '746500', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39529, 2118, 430623, '华容县', 3, 224, '岳阳市', 19, '湖南省', 20, '414200', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39531, 3360, 654225, '裕民县', 3, 374, '塔城地区', 32, '新疆维吾尔自治区', 20, '834800', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39533, 2114, 430602, '岳阳楼区', 3, 224, '岳阳市', 19, '湖南省', 20, '414000', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39535, 3191, 621228, '两当县', 3, 346, '陇南市', 29, '甘肃省', 20, '742400', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39537, 3359, 654224, '托里县', 3, 374, '塔城地区', 32, '新疆维吾尔自治区', 20, '834500', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39539, 2121, 430681, '汨罗市', 3, 224, '岳阳市', 19, '湖南省', 20, '414400', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39541, 3190, 621227, '徽县', 3, 346, '陇南市', 29, '甘肃省', 20, '742300', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39543, 3356, 654202, '乌苏市', 3, 374, '塔城地区', 32, '新疆维吾尔自治区', 20, '833300', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39545, 2119, 430624, '湘阴县', 3, 224, '岳阳市', 19, '湖南省', 20, '410500', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39547, 3184, 621221, '成县', 3, 346, '陇南市', 29, '甘肃省', 20, '742500', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39549, 3358, 654223, '沙湾县', 3, 374, '塔城地区', 32, '新疆维吾尔自治区', 20, '832100', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39551, 3185, 621222, '文县', 3, 346, '陇南市', 29, '甘肃省', 20, '746400', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39553, 2122, 430682, '临湘市', 3, 224, '岳阳市', 19, '湖南省', 20, '414300', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39555, 375, 654300, '阿勒泰地区', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39557, 3363, 654321, '布尔津县', 3, 375, '阿勒泰地区', 32, '新疆维吾尔自治区', 20, '836600', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39559, 2117, 430621, '岳阳县', 3, 224, '岳阳市', 19, '湖南省', 20, '414100', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39561, 3188, 621225, '西和县', 3, 346, '陇南市', 29, '甘肃省', 20, '742100', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39563, 3366, 654324, '哈巴河县', 3, 375, '阿勒泰地区', 32, '新疆维吾尔自治区', 20, '836700', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39565, 342, 620800, '平凉市', 2, 29, '甘肃省', NULL, NULL, 20, '0', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39567, 2120, 430626, '平江县', 3, 224, '岳阳市', 19, '湖南省', 20, '215005', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39569, 3156, 620822, '灵台县', 3, 342, '平凉市', 29, '甘肃省', 20, '744400', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39571, 227, 430900, '益阳市', 2, 19, '湖南省', NULL, NULL, 20, '0', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39573, 3368, 654326, '吉木乃县', 3, 375, '阿勒泰地区', 32, '新疆维吾尔自治区', 20, '836800', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39575, 3154, 620802, '崆峒区', 3, 342, '平凉市', 29, '甘肃省', 20, '678400', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39577, 2136, 430902, '资阳区', 3, 227, '益阳市', 19, '湖南省', 20, '413001', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39579, 3367, 654325, '青河县', 3, 375, '阿勒泰地区', 32, '新疆维吾尔自治区', 20, '836200', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39581, 2139, 430922, '桃江县', 3, 227, '益阳市', 19, '湖南省', 20, '413400', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39583, 3159, 620825, '庄浪县', 3, 342, '平凉市', 29, '甘肃省', 20, '744600', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39585, 3364, 654322, '富蕴县', 3, 375, '阿勒泰地区', 32, '新疆维吾尔自治区', 20, '836100', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39587, 2137, 430903, '赫山区', 3, 227, '益阳市', 19, '湖南省', 20, '413002', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39589, 3157, 620823, '崇信县', 3, 342, '平凉市', 29, '甘肃省', 20, '744200', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39591, 3362, 654301, '阿勒泰市', 3, 375, '阿勒泰地区', 32, '新疆维吾尔自治区', 20, '836500', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39593, 2140, 430923, '安化县', 3, 227, '益阳市', 19, '湖南省', 20, '413500', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39595, 3160, 620826, '静宁县', 3, 342, '平凉市', 29, '甘肃省', 20, '743400', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39597, 3365, 654323, '福海县', 3, 375, '阿勒泰地区', 32, '新疆维吾尔自治区', 20, '836400', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39599, 2141, 430981, '沅江市', 3, 227, '益阳市', 19, '湖南省', 20, '413100', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39601, 3158, 620881, '华亭市', 3, 342, '平凉市', 29, '甘肃省', 20, '744100', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39603, 2138, 430921, '南县', 3, 227, '益阳市', 19, '湖南省', 20, '413200', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39605, 366, 652300, '昌吉回族自治州', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39607, 3155, 620821, '泾川县', 3, 342, '平凉市', 29, '甘肃省', 20, '744300', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39609, 222, 430400, '衡阳市', 2, 19, '湖南省', NULL, NULL, 20, '0', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39611, 340, 620600, '武威市', 2, 29, '甘肃省', NULL, NULL, 20, '0', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39613, 3297, 652325, '奇台县', 3, 366, '昌吉回族自治州', 32, '新疆维吾尔自治区', 20, '831800', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39615, 3146, 620622, '古浪县', 3, 340, '武威市', 29, '甘肃省', 20, '671000', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39617, 2097, 430423, '衡山县', 3, 222, '衡阳市', 19, '湖南省', 20, '421300', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39619, 3296, 652324, '玛纳斯县', 3, 366, '昌吉回族自治州', 32, '新疆维吾尔自治区', 20, '832200', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39621, 3144, 620602, '凉州区', 3, 340, '武威市', 29, '甘肃省', 20, '671000', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39623, 2098, 430424, '衡东县', 3, 222, '衡阳市', 19, '湖南省', 20, '421400', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39625, 3295, 652323, '呼图壁县', 3, 366, '昌吉回族自治州', 32, '新疆维吾尔自治区', 20, '831200', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39627, 2095, 430421, '衡阳县', 3, 222, '衡阳市', 19, '湖南省', 20, '421200', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39629, 3147, 620623, '天祝藏族自治县', 3, 340, '武威市', 29, '甘肃省', 20, '671000', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39631, 3299, 652328, '木垒哈萨克自治县', 3, 366, '昌吉回族自治州', 32, '新疆维吾尔自治区', 20, '831900', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39633, 2094, 430412, '南岳区', 3, 222, '衡阳市', 19, '湖南省', 20, '421900', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39635, 3293, 652302, '阜康市', 3, 366, '昌吉回族自治州', 32, '新疆维吾尔自治区', 20, '831500', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39637, 2100, 430481, '耒阳市', 3, 222, '衡阳市', 19, '湖南省', 20, '421800', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39639, 3292, 652301, '昌吉市', 3, 366, '昌吉回族自治州', 32, '新疆维吾尔自治区', 20, '831100', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39641, 3145, 620621, '民勤县', 3, 340, '武威市', 29, '甘肃省', 20, '671000', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39643, 2091, 430406, '雁峰区', 3, 222, '衡阳市', 19, '湖南省', 20, '421001', '2020-08-04 00:58:18', '2020-09-21 22:59:39', 0);
INSERT INTO `t_areas` VALUES (39645, 3298, 652327, '吉木萨尔县', 3, 366, '昌吉回族自治州', 32, '新疆维吾尔自治区', 20, '831700', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39647, 335, 620100, '兰州市', 2, 29, '甘肃省', NULL, NULL, 20, '0', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39649, 2090, 430405, '珠晖区', 3, 222, '衡阳市', 19, '湖南省', 20, '421002', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39651, 3369, 659001, '石河子市', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '832000', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39653, 2092, 430407, '石鼓区', 3, 222, '衡阳市', 19, '湖南省', 20, '421001', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39655, 3126, 620121, '永登县', 3, 335, '兰州市', 29, '甘肃省', 20, '678000', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39657, 3372, 659004, '五家渠市', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '831300', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39659, 2096, 430422, '衡南县', 3, 222, '衡阳市', 19, '湖南省', 20, '421131', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39661, 3127, 620122, '皋兰县', 3, 335, '兰州市', 29, '甘肃省', 20, '678000', '2020-08-04 00:58:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39663, 2099, 430426, '祁东县', 3, 222, '衡阳市', 19, '湖南省', 20, '421600', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39665, 373, 654000, '伊犁哈萨克自治州', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39667, 3123, 620104, '西固区', 3, 335, '兰州市', 29, '甘肃省', 20, '674100', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39669, 2093, 430408, '蒸湘区', 3, 222, '衡阳市', 19, '湖南省', 20, '421001', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39671, 3125, 620111, '红古区', 3, 335, '兰州市', 29, '甘肃省', 20, '678000', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39673, 2101, 430482, '常宁市', 3, 222, '衡阳市', 19, '湖南省', 20, '421500', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39675, 3346, 654003, '奎屯市', 3, 373, '伊犁哈萨克自治州', 32, '新疆维吾尔自治区', 20, '833200', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39677, 231, 431300, '娄底市', 2, 19, '湖南省', NULL, NULL, 20, '0', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39679, 3347, 654021, '伊宁县', 3, 373, '伊犁哈萨克自治州', 32, '新疆维吾尔自治区', 20, '835100', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39681, 3124, 620105, '安宁区', 3, 335, '兰州市', 29, '甘肃省', 20, '674100', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39683, 2179, 431381, '冷水江市', 3, 231, '娄底市', 19, '湖南省', 20, '417500', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39685, 3351, 654025, '新源县', 3, 373, '伊犁哈萨克自治州', 32, '新疆维吾尔自治区', 20, '835800', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39687, 3121, 620102, '城关区', 3, 335, '兰州市', 29, '甘肃省', 20, '850000', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39689, 2178, 431322, '新化县', 3, 231, '娄底市', 19, '湖南省', 20, '417600', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39691, 3350, 654024, '巩留县', 3, 373, '伊犁哈萨克自治州', 32, '新疆维吾尔自治区', 20, '835400', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39693, 3122, 620103, '七里河区', 3, 335, '兰州市', 29, '甘肃省', 20, '674100', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39695, 2180, 431382, '涟源市', 3, 231, '娄底市', 19, '湖南省', 20, '417100', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39697, 3354, 654028, '尼勒克县', 3, 373, '伊犁哈萨克自治州', 32, '新疆维吾尔自治区', 20, '835700', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39699, 3128, 620123, '榆中县', 3, 335, '兰州市', 29, '甘肃省', 20, '678000', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39701, 3353, 654027, '特克斯县', 3, 373, '伊犁哈萨克自治州', 32, '新疆维吾尔自治区', 20, '835500', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39703, 2177, 431321, '双峰县', 3, 231, '娄底市', 19, '湖南省', 20, '417700', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39705, 336, 620200, '嘉峪关市', 2, 29, '甘肃省', NULL, NULL, 20, '0', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39707, 2176, 431302, '娄星区', 3, 231, '娄底市', 19, '湖南省', 20, '417000', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39709, 3352, 654026, '昭苏县', 3, 373, '伊犁哈萨克自治州', 32, '新疆维吾尔自治区', 20, '835600', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39711, 225, 430700, '常德市', 2, 19, '湖南省', NULL, NULL, 20, '0', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39713, 348, 623000, '甘南藏族自治州', 2, 29, '甘肃省', NULL, NULL, 20, '0', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39715, 3348, 654022, '察布查尔锡伯自治县', 3, 373, '伊犁哈萨克自治州', 32, '新疆维吾尔自治区', 20, '835300', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39717, 2130, 430726, '石门县', 3, 225, '常德市', 19, '湖南省', 20, '415300', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39719, 3202, 623022, '卓尼县', 3, 348, '甘南藏族自治州', 29, '甘肃省', 20, '747600', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39721, 3349, 654023, '霍城县', 3, 373, '伊犁哈萨克自治州', 32, '新疆维吾尔自治区', 20, '835200', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39723, 3207, 623027, '夏河县', 3, 348, '甘南藏族自治州', 29, '甘肃省', 20, '747100', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39725, 2127, 430723, '澧县', 3, 225, '常德市', 19, '湖南省', 20, '415500', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39727, 3448, 654004, '霍尔果斯市', 3, 373, '伊犁哈萨克自治州', 32, '新疆维吾尔自治区', 20, '654004', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39729, 3200, 623001, '合作市', 3, 348, '甘南藏族自治州', 29, '甘肃省', 20, '747000', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39731, 3345, 654002, '伊宁市', 3, 373, '伊犁哈萨克自治州', 32, '新疆维吾尔自治区', 20, '835000', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39733, 2131, 430781, '津市市', 3, 225, '常德市', 19, '湖南省', 20, '415400', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39735, 3201, 623021, '临潭县', 3, 348, '甘南藏族自治州', 29, '甘肃省', 20, '747500', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39737, 2128, 430724, '临澧县', 3, 225, '常德市', 19, '湖南省', 20, '415200', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39739, 2126, 430722, '汉寿县', 3, 225, '常德市', 19, '湖南省', 20, '415900', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39741, 3370, 659002, '阿拉尔市', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '843300', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39743, 2124, 430703, '鼎城区', 3, 225, '常德市', 19, '湖南省', 20, '415101', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39745, 3205, 623025, '玛曲县', 3, 348, '甘南藏族自治州', 29, '甘肃省', 20, '747300', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39747, 3204, 623024, '迭部县', 3, 348, '甘南藏族自治州', 29, '甘肃省', 20, '747400', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39749, 3203, 623023, '舟曲县', 3, 348, '甘南藏族自治州', 29, '甘肃省', 20, '746300', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39751, 2123, 430702, '武陵区', 3, 225, '常德市', 19, '湖南省', 20, '415000', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39753, 364, 650400, '吐鲁番市', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39755, 3206, 623026, '碌曲县', 3, 348, '甘南藏族自治州', 29, '甘肃省', 20, '747200', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39757, 2129, 430725, '桃源县', 3, 225, '常德市', 19, '湖南省', 20, '415700', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39759, 3287, 650421, '鄯善县', 3, 364, '吐鲁番市', 32, '新疆维吾尔自治区', 20, '838200', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39761, 347, 622900, '临夏回族自治州', 2, 29, '甘肃省', NULL, NULL, 20, '0', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39763, 3288, 650422, '托克逊县', 3, 364, '吐鲁番市', 32, '新疆维吾尔自治区', 20, '838100', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39765, 2125, 430721, '安乡县', 3, 225, '常德市', 19, '湖南省', 20, '415600', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39767, 3445, 650402, '高昌区', 3, 364, '吐鲁番市', 32, '新疆维吾尔自治区', 20, '650402', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39769, 3199, 622927, '积石山保安族东乡族撒拉族自治县', 3, 347, '临夏回族自治州', 29, '甘肃省', 20, '731700', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39771, 226, 430800, '张家界市', 2, 19, '湖南省', NULL, NULL, 20, '0', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39773, 371, 653100, '喀什地区', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39775, 3198, 622926, '东乡族自治县', 3, 347, '临夏回族自治州', 29, '甘肃省', 20, '731400', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39777, 2133, 430811, '武陵源区', 3, 226, '张家界市', 19, '湖南省', 20, '427400', '2020-08-04 00:58:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39779, 3327, 653122, '疏勒县', 3, 371, '喀什地区', 32, '新疆维吾尔自治区', 20, '844200', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39781, 3195, 622923, '永靖县', 3, 347, '临夏回族自治州', 29, '甘肃省', 20, '731600', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39783, 2134, 430821, '慈利县', 3, 226, '张家界市', 19, '湖南省', 20, '427200', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39785, 3332, 653127, '麦盖提县', 3, 371, '喀什地区', 32, '新疆维吾尔自治区', 20, '844600', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39787, 3192, 622901, '临夏市', 3, 347, '临夏回族自治州', 29, '甘肃省', 20, '731100', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39789, 2135, 430822, '桑植县', 3, 226, '张家界市', 19, '湖南省', 20, '427100', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39791, 3330, 653125, '莎车县', 3, 371, '喀什地区', 32, '新疆维吾尔自治区', 20, '844700', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39793, 3193, 622921, '临夏县', 3, 347, '临夏回族自治州', 29, '甘肃省', 20, '731800', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39795, 230, 431200, '怀化市', 2, 19, '湖南省', NULL, NULL, 20, '0', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39797, 3334, 653129, '伽师县', 3, 371, '喀什地区', 32, '新疆维吾尔自治区', 20, '844300', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39799, 3196, 622924, '广河县', 3, 347, '临夏回族自治州', 29, '甘肃省', 20, '731300', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39801, 2175, 431281, '洪江市', 3, 230, '怀化市', 19, '湖南省', 20, '418116', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39803, 3336, 653131, '塔什库尔干塔吉克自治县', 3, 371, '喀什地区', 32, '新疆维吾尔自治区', 20, '845250', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39805, 3197, 622925, '和政县', 3, 347, '临夏回族自治州', 29, '甘肃省', 20, '731200', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39807, 2172, 431228, '芷江侗族自治县', 3, 230, '怀化市', 19, '湖南省', 20, '419100', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39809, 3331, 653126, '叶城县', 3, 371, '喀什地区', 32, '新疆维吾尔自治区', 20, '844900', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39811, 3194, 622922, '康乐县', 3, 347, '临夏回族自治州', 29, '甘肃省', 20, '731500', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39813, 3329, 653124, '泽普县', 3, 371, '喀什地区', 32, '新疆维吾尔自治区', 20, '844800', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39815, 2174, 431230, '通道侗族自治县', 3, 230, '怀化市', 19, '湖南省', 20, '418500', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39817, 341, 620700, '张掖市', 2, 29, '甘肃省', NULL, NULL, 20, '0', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39819, 3335, 653130, '巴楚县', 3, 371, '喀什地区', 32, '新疆维吾尔自治区', 20, '843800', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39821, 2167, 431223, '辰溪县', 3, 230, '怀化市', 19, '湖南省', 20, '419500', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39823, 3152, 620724, '高台县', 3, 341, '张掖市', 29, '甘肃省', 20, '734300', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39825, 3326, 653121, '疏附县', 3, 371, '喀什地区', 32, '新疆维吾尔自治区', 20, '844100', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39827, 2166, 431222, '沅陵县', 3, 230, '怀化市', 19, '湖南省', 20, '419600', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39829, 3149, 620721, '肃南裕固族自治县', 3, 341, '张掖市', 29, '甘肃省', 20, '671000', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39831, 2168, 431224, '溆浦县', 3, 230, '怀化市', 19, '湖南省', 20, '419300', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39833, 3328, 653123, '英吉沙县', 3, 371, '喀什地区', 32, '新疆维吾尔自治区', 20, '844500', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39835, 3150, 620722, '民乐县', 3, 341, '张掖市', 29, '甘肃省', 20, '671000', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39837, 2173, 431229, '靖州苗族侗族自治县', 3, 230, '怀化市', 19, '湖南省', 20, '418400', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39839, 3325, 653101, '喀什市', 3, 371, '喀什地区', 32, '新疆维吾尔自治区', 20, '844000', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39841, 3153, 620725, '山丹县', 3, 341, '张掖市', 29, '甘肃省', 20, '734100', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39843, 2169, 431225, '会同县', 3, 230, '怀化市', 19, '湖南省', 20, '418300', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39845, 3333, 653128, '岳普湖县', 3, 371, '喀什地区', 32, '新疆维吾尔自治区', 20, '844400', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39847, 3151, 620723, '临泽县', 3, 341, '张掖市', 29, '甘肃省', 20, '671000', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39849, 2171, 431227, '新晃侗族自治县', 3, 230, '怀化市', 19, '湖南省', 20, '419200', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39851, 2170, 431226, '麻阳苗族自治县', 3, 230, '怀化市', 19, '湖南省', 20, '419400', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39853, 3148, 620702, '甘州区', 3, 341, '张掖市', 29, '甘肃省', 20, '671000', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39855, 365, 650500, '哈密市', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39857, 344, 621000, '庆阳市', 2, 29, '甘肃省', NULL, NULL, 20, '0', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39859, 3446, 650502, '伊州区', 3, 365, '哈密市', 32, '新疆维吾尔自治区', 20, '650502', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39861, 2165, 431221, '中方县', 3, 230, '怀化市', 19, '湖南省', 20, '418005', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39863, 2164, 431202, '鹤城区', 3, 230, '怀化市', 19, '湖南省', 20, '418000', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39865, 3173, 621025, '正宁县', 3, 344, '庆阳市', 29, '甘肃省', 20, '677000', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39867, 3290, 650521, '巴里坤哈萨克自治县', 3, 365, '哈密市', 32, '新疆维吾尔自治区', 20, '839200', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39869, 232, 433100, '湘西土家族苗族自治州', 2, 19, '湖南省', NULL, NULL, 20, '0', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39871, 3291, 650522, '伊吾县', 3, 365, '哈密市', 32, '新疆维吾尔自治区', 20, '839300', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39873, 3175, 621027, '镇原县', 3, 344, '庆阳市', 29, '甘肃省', 20, '677000', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39875, 2187, 433127, '永顺县', 3, 232, '湘西土家族苗族自治州', 19, '湖南省', 20, '416700', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39877, 3171, 621023, '华池县', 3, 344, '庆阳市', 29, '甘肃省', 20, '745600', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39879, 3371, 659003, '图木舒克市', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '843806', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39881, 370, 653000, '克孜勒苏柯尔克孜自治州', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39883, 3170, 621022, '环县', 3, 344, '庆阳市', 29, '甘肃省', 20, '745700', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39885, 2185, 433125, '保靖县', 3, 232, '湘西土家族苗族自治州', 19, '湖南省', 20, '416500', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39887, 3324, 653024, '乌恰县', 3, 370, '克孜勒苏柯尔克孜自治州', 32, '新疆维吾尔自治区', 20, '845450', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39889, 2184, 433124, '花垣县', 3, 232, '湘西土家族苗族自治州', 19, '湖南省', 20, '416400', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39891, 3174, 621026, '宁县', 3, 344, '庆阳市', 29, '甘肃省', 20, '677000', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39893, 3321, 653001, '阿图什市', 3, 370, '克孜勒苏柯尔克孜自治州', 32, '新疆维吾尔自治区', 20, '845350', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39895, 3168, 621002, '西峰区', 3, 344, '庆阳市', 29, '甘肃省', 20, '745000', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39897, 2181, 433101, '吉首市', 3, 232, '湘西土家族苗族自治州', 19, '湖南省', 20, '416000', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39899, 3169, 621021, '庆城县', 3, 344, '庆阳市', 29, '甘肃省', 20, '745100', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39901, 3323, 653023, '阿合奇县', 3, 370, '克孜勒苏柯尔克孜自治州', 32, '新疆维吾尔自治区', 20, '843500', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39903, 2186, 433126, '古丈县', 3, 232, '湘西土家族苗族自治州', 19, '湖南省', 20, '416300', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39905, 2182, 433122, '泸溪县', 3, 232, '湘西土家族苗族自治州', 19, '湖南省', 20, '416100', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39907, 3172, 621024, '合水县', 3, 344, '庆阳市', 29, '甘肃省', 20, '745400', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39909, 3322, 653022, '阿克陶县', 3, 370, '克孜勒苏柯尔克孜自治州', 32, '新疆维吾尔自治区', 20, '845550', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39911, 2188, 433130, '龙山县', 3, 232, '湘西土家族苗族自治州', 19, '湖南省', 20, '416800', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39913, 369, 652900, '阿克苏地区', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39915, 345, 621100, '定西市', 2, 29, '甘肃省', NULL, NULL, 20, '0', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39917, 3179, 621123, '渭源县', 3, 345, '定西市', 29, '甘肃省', 20, '677000', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39919, 3313, 652922, '温宿县', 3, 369, '阿克苏地区', 32, '新疆维吾尔自治区', 20, '843100', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39921, 2183, 433123, '凤凰县', 3, 232, '湘西土家族苗族自治州', 19, '湖南省', 20, '416200', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39923, 3312, 652901, '阿克苏市', 3, 369, '阿克苏地区', 32, '新疆维吾尔自治区', 20, '843000', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39925, 219, 430100, '长沙市', 2, 19, '湖南省', NULL, NULL, 20, '0', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39927, 3180, 621124, '临洮县', 3, 345, '定西市', 29, '甘肃省', 20, '677000', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39929, 3182, 621126, '岷县', 3, 345, '定西市', 29, '甘肃省', 20, '748400', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39931, 2070, 430105, '开福区', 3, 219, '长沙市', 19, '湖南省', 20, '410008', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39933, 3314, 652902, '库车市', 3, 369, '阿克苏地区', 32, '新疆维吾尔自治区', 20, '842000', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39935, 3181, 621125, '漳县', 3, 345, '定西市', 29, '甘肃省', 20, '748300', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39937, 3315, 652924, '沙雅县', 3, 369, '阿克苏地区', 32, '新疆维吾尔自治区', 20, '842200', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39939, 2069, 430104, '岳麓区', 3, 219, '长沙市', 19, '湖南省', 20, '410006', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39941, 3176, 621102, '安定区', 3, 345, '定西市', 29, '甘肃省', 20, '677000', '2020-08-04 00:58:20', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39943, 3317, 652926, '拜城县', 3, 369, '阿克苏地区', 32, '新疆维吾尔自治区', 20, '842300', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39945, 2068, 430103, '天心区', 3, 219, '长沙市', 19, '湖南省', 20, '410011', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39947, 3178, 621122, '陇西县', 3, 345, '定西市', 29, '甘肃省', 20, '677000', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39949, 3320, 652929, '柯坪县', 3, 369, '阿克苏地区', 32, '新疆维吾尔自治区', 20, '843600', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39951, 3177, 621121, '通渭县', 3, 345, '定西市', 29, '甘肃省', 20, '677000', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39953, 2075, 430181, '浏阳市', 3, 219, '长沙市', 19, '湖南省', 20, '410300', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39955, 3316, 652925, '新和县', 3, 369, '阿克苏地区', 32, '新疆维吾尔自治区', 20, '842100', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39957, 2072, 430121, '长沙县', 3, 219, '长沙市', 19, '湖南省', 20, '410100', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39959, 339, 620500, '天水市', 2, 29, '甘肃省', NULL, NULL, 20, '0', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39961, 3319, 652928, '阿瓦提县', 3, 369, '阿克苏地区', 32, '新疆维吾尔自治区', 20, '843200', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39963, 3141, 620523, '甘谷县', 3, 339, '天水市', 29, '甘肃省', 20, '671000', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39965, 3318, 652927, '乌什县', 3, 369, '阿克苏地区', 32, '新疆维吾尔自治区', 20, '843400', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39967, 2073, 430112, '望城区', 3, 219, '长沙市', 19, '湖南省', 20, '410200', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39969, 363, 650200, '克拉玛依市', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39971, 3140, 620522, '秦安县', 3, 339, '天水市', 29, '甘肃省', 20, '671000', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39973, 2074, 430182, '宁乡市', 3, 219, '长沙市', 19, '湖南省', 20, '410600', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39975, 3137, 620502, '秦州区', 3, 339, '天水市', 29, '甘肃省', 20, '741000', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39977, 3284, 650204, '白碱滩区', 3, 363, '克拉玛依市', 32, '新疆维吾尔自治区', 20, '834008', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39979, 2067, 430102, '芙蓉区', 3, 219, '长沙市', 19, '湖南省', 20, '410011', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39981, 3138, 620503, '麦积区', 3, 339, '天水市', 29, '甘肃省', 20, '741020', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39983, 2071, 430111, '雨花区', 3, 219, '长沙市', 19, '湖南省', 20, '410011', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39985, 3283, 650203, '克拉玛依区', 3, 363, '克拉玛依市', 32, '新疆维吾尔自治区', 20, '834000', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39987, 221, 430300, '湘潭市', 2, 19, '湖南省', NULL, NULL, 20, '0', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39989, 3143, 620525, '张家川回族自治县', 3, 339, '天水市', 29, '甘肃省', 20, '671000', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39991, 3285, 650205, '乌尔禾区', 3, 363, '克拉玛依市', 32, '新疆维吾尔自治区', 20, '834012', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39993, 3139, 620521, '清水县', 3, 339, '天水市', 29, '甘肃省', 20, '741400', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39995, 2087, 430321, '湘潭县', 3, 221, '湘潭市', 19, '湖南省', 20, '411228', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39997, 3282, 650202, '独山子区', 3, 363, '克拉玛依市', 32, '新疆维吾尔自治区', 20, '834021', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (39999, 3465, 659010, '胡杨河市', 2, 32, '新疆维吾尔自治区', NULL, NULL, 20, NULL, '2020-08-04 00:58:21', '2020-08-06 22:39:19', 0);
INSERT INTO `t_areas` VALUES (40001, 2085, 430302, '雨湖区', 3, 221, '湘潭市', 19, '湖南省', 20, '411100', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40003, 3142, 620524, '武山县', 3, 339, '天水市', 29, '甘肃省', 20, '671000', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40005, 2086, 430304, '岳塘区', 3, 221, '湘潭市', 19, '湖南省', 20, '411101', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40007, 7, 210000, '辽宁省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40009, 24, 510000, '四川省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40011, 2089, 430382, '韶山市', 3, 221, '湘潭市', 19, '湖南省', 20, '411300', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40013, 288, 511900, '巴中市', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40015, 78, 210700, '锦州市', 2, 7, '辽宁省', NULL, NULL, 20, '0', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40017, 878, 210727, '义县', 3, 78, '锦州市', 7, '辽宁省', 20, '121100', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40019, 2088, 430381, '湘乡市', 3, 221, '湘潭市', 19, '湖南省', 20, '411400', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40021, 2664, 511902, '巴州区', 3, 288, '巴中市', 24, '四川省', 20, '636001', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40023, 877, 210726, '黑山县', 3, 78, '锦州市', 7, '辽宁省', 20, '121400', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40025, 2667, 511923, '平昌县', 3, 288, '巴中市', 24, '四川省', 20, '636400', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40027, 220, 430200, '株洲市', 2, 19, '湖南省', NULL, NULL, 20, '0', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40029, 879, 210781, '凌海市', 3, 78, '锦州市', 7, '辽宁省', 20, '121200', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40031, 2076, 430202, '荷塘区', 3, 220, '株洲市', 19, '湖南省', 20, '412000', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40033, 2665, 511921, '通江县', 3, 288, '巴中市', 24, '四川省', 20, '636700', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40035, 876, 210711, '太和区', 3, 78, '锦州市', 7, '辽宁省', 20, '121011', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40037, 2081, 430223, '攸县', 3, 220, '株洲市', 19, '湖南省', 20, '412300', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40039, 2666, 511922, '南江县', 3, 288, '巴中市', 24, '四川省', 20, '636600', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40041, 3388, 210782, '北镇市', 3, 78, '锦州市', 7, '辽宁省', 20, '121300', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40043, 3426, 511903, '恩阳区', 3, 288, '巴中市', 24, '四川省', 20, '511903', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40045, 2082, 430224, '茶陵县', 3, 220, '株洲市', 19, '湖南省', 20, '412400', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40047, 875, 210703, '凌河区', 3, 78, '锦州市', 7, '辽宁省', 20, '121000', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40049, 874, 210702, '古塔区', 3, 78, '锦州市', 7, '辽宁省', 20, '121001', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40051, 272, 510100, '成都市', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40053, 2083, 430225, '炎陵县', 3, 220, '株洲市', 19, '湖南省', 20, '412500', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40055, 73, 210200, '大连市', 2, 7, '辽宁省', NULL, NULL, 20, '0', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40057, 2549, 510182, '彭州市', 3, 272, '成都市', 24, '四川省', 20, '611930', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40059, 3408, 430212, '渌口区', 3, 220, '株洲市', 19, '湖南省', 20, '412000', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40061, 840, 210212, '旅顺口区', 3, 73, '大连市', 7, '辽宁省', 20, '116041', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40063, 2548, 510181, '都江堰市', 3, 272, '成都市', 24, '四川省', 20, '611830', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40065, 2077, 430203, '芦淞区', 3, 220, '株洲市', 19, '湖南省', 20, '412000', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40067, 841, 210213, '金州区', 3, 73, '大连市', 7, '辽宁省', 20, '116100', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40069, 2545, 510129, '大邑县', 3, 272, '成都市', 24, '四川省', 20, '611300', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40071, 2079, 430211, '天元区', 3, 220, '株洲市', 19, '湖南省', 20, '412007', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40073, 843, 210281, '瓦房店市', 3, 73, '大连市', 7, '辽宁省', 20, '116300', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40075, 2546, 510131, '蒲江县', 3, 272, '成都市', 24, '四川省', 20, '611630', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40077, 842, 210224, '长海县', 3, 73, '大连市', 7, '辽宁省', 20, '116500', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40079, 2539, 510113, '青白江区', 3, 272, '成都市', 24, '四川省', 20, '610300', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40081, 2078, 430204, '石峰区', 3, 220, '株洲市', 19, '湖南省', 20, '412005', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40083, 839, 210211, '甘井子区', 3, 73, '大连市', 7, '辽宁省', 20, '116033', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40085, 2084, 430281, '醴陵市', 3, 220, '株洲市', 19, '湖南省', 20, '412200', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40087, 2671, 510185, '简阳市', 3, 272, '成都市', 24, '四川省', 20, '641400', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40089, 3466, 210214, '普兰店区', 3, 73, '大连市', 7, '辽宁省', 20, NULL, '2020-08-04 00:58:21', '2020-08-06 22:39:19', 0);
INSERT INTO `t_areas` VALUES (40091, 223, 430500, '邵阳市', 2, 19, '湖南省', NULL, NULL, 20, '0', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40093, 2551, 510184, '崇州市', 3, 272, '成都市', 24, '四川省', 20, '611230', '2020-08-04 00:58:21', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40095, 845, 210283, '庄河市', 3, 73, '大连市', 7, '辽宁省', 20, '116400', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40097, 2108, 430524, '隆回县', 3, 223, '邵阳市', 19, '湖南省', 20, '422200', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40099, 2542, 510121, '金堂县', 3, 272, '成都市', 24, '四川省', 20, '610400', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40101, 836, 210202, '中山区', 3, 73, '大连市', 7, '辽宁省', 20, '116001', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40103, 2103, 430503, '大祥区', 3, 223, '邵阳市', 19, '湖南省', 20, '422000', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40105, 2550, 510183, '邛崃市', 3, 272, '成都市', 24, '四川省', 20, '611530', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40107, 837, 210203, '西岗区', 3, 73, '大连市', 7, '辽宁省', 20, '116011', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40109, 2110, 430527, '绥宁县', 3, 223, '邵阳市', 19, '湖南省', 20, '422600', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40111, 2547, 510132, '新津区', 3, 272, '成都市', 24, '四川省', 20, '611430', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40113, 838, 210204, '沙河口区', 3, 73, '大连市', 7, '辽宁省', 20, '116021', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40115, 2104, 430511, '北塔区', 3, 223, '邵阳市', 19, '湖南省', 20, '422007', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40117, 2541, 510115, '温江区', 3, 272, '成都市', 24, '四川省', 20, '611130', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40119, 77, 210600, '丹东市', 2, 7, '辽宁省', NULL, NULL, 20, '0', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40121, 2102, 430502, '双清区', 3, 223, '邵阳市', 19, '湖南省', 20, '422001', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40123, 3420, 510117, '郫都区', 3, 272, '成都市', 24, '四川省', 20, '611730', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40125, 873, 210682, '凤城市', 3, 77, '丹东市', 7, '辽宁省', 20, '118100', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40127, 2107, 430523, '邵阳县', 3, 223, '邵阳市', 19, '湖南省', 20, '422100', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40129, 2543, 510116, '双流区', 3, 272, '成都市', 24, '四川省', 20, '610200', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40131, 2112, 430529, '城步苗族自治县', 3, 223, '邵阳市', 19, '湖南省', 20, '422500', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40133, 2536, 510107, '武侯区', 3, 272, '成都市', 24, '四川省', 20, '610041', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40135, 870, 210604, '振安区', 3, 77, '丹东市', 7, '辽宁省', 20, '118001', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40137, 2535, 510106, '金牛区', 3, 272, '成都市', 24, '四川省', 20, '610036', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40139, 2105, 430582, '邵东市', 3, 223, '邵阳市', 19, '湖南省', 20, '422800', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40141, 872, 210681, '东港市', 3, 77, '丹东市', 7, '辽宁省', 20, '118300', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40143, 2540, 510114, '新都区', 3, 272, '成都市', 24, '四川省', 20, '610500', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40145, 869, 210603, '振兴区', 3, 77, '丹东市', 7, '辽宁省', 20, '118002', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40147, 2106, 430522, '新邵县', 3, 223, '邵阳市', 19, '湖南省', 20, '422900', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40149, 2538, 510112, '龙泉驿区', 3, 272, '成都市', 24, '四川省', 20, '610100', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40151, 2111, 430528, '新宁县', 3, 223, '邵阳市', 19, '湖南省', 20, '422700', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40153, 871, 210624, '宽甸满族自治县', 3, 77, '丹东市', 7, '辽宁省', 20, '118200', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40155, 2537, 510108, '成华区', 3, 272, '成都市', 24, '四川省', 20, '610066', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40157, 868, 210602, '元宝区', 3, 77, '丹东市', 7, '辽宁省', 20, '118000', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40159, 2113, 430581, '武冈市', 3, 223, '邵阳市', 19, '湖南省', 20, '422400', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40161, 2534, 510105, '青羊区', 3, 272, '成都市', 24, '四川省', 20, '610031', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40163, 75, 210400, '抚顺市', 2, 7, '辽宁省', NULL, NULL, 20, '0', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40165, 2533, 510104, '锦江区', 3, 272, '成都市', 24, '四川省', 20, '610021', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40167, 2109, 430525, '洞口县', 3, 223, '邵阳市', 19, '湖南省', 20, '422300', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40169, 276, 510600, '德阳市', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40171, 228, 431000, '郴州市', 2, 19, '湖南省', NULL, NULL, 20, '0', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40173, 861, 210423, '清原满族自治县', 3, 75, '抚顺市', 7, '辽宁省', 20, '113300', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40175, 2576, 510682, '什邡市', 3, 276, '德阳市', 24, '四川省', 20, '618400', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40177, 2151, 431028, '安仁县', 3, 228, '郴州市', 19, '湖南省', 20, '423600', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40179, 860, 210422, '新宾满族自治县', 3, 75, '抚顺市', 7, '辽宁省', 20, '113200', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40181, 2573, 510623, '中江县', 3, 276, '德阳市', 24, '四川省', 20, '618100', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40183, 2149, 431026, '汝城县', 3, 228, '郴州市', 19, '湖南省', 20, '424100', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40185, 2146, 431023, '永兴县', 3, 228, '郴州市', 19, '湖南省', 20, '423300', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40187, 858, 210411, '顺城区', 3, 75, '抚顺市', 7, '辽宁省', 20, '113006', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40189, 2575, 510681, '广汉市', 3, 276, '德阳市', 24, '四川省', 20, '618300', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40191, 856, 210403, '东洲区', 3, 75, '抚顺市', 7, '辽宁省', 20, '113003', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40193, 2143, 431003, '苏仙区', 3, 228, '郴州市', 19, '湖南省', 20, '423000', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40195, 2572, 510603, '旌阳区', 3, 276, '德阳市', 24, '四川省', 20, '618000', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40197, 855, 210402, '新抚区', 3, 75, '抚顺市', 7, '辽宁省', 20, '113008', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40199, 2152, 431081, '资兴市', 3, 228, '郴州市', 19, '湖南省', 20, '423400', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40201, 2574, 510604, '罗江区', 3, 276, '德阳市', 24, '四川省', 20, '618500', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40203, 857, 210404, '望花区', 3, 75, '抚顺市', 7, '辽宁省', 20, '113001', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40205, 2142, 431002, '北湖区', 3, 228, '郴州市', 19, '湖南省', 20, '423000', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40207, 2577, 510683, '绵竹市', 3, 276, '德阳市', 24, '四川省', 20, '618200', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40209, 859, 210421, '抚顺县', 3, 75, '抚顺市', 7, '辽宁省', 20, '113006', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40211, 2150, 431027, '桂东县', 3, 228, '郴州市', 19, '湖南省', 20, '423500', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40213, 85, 211400, '葫芦岛市', 2, 7, '辽宁省', NULL, NULL, 20, '0', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40215, 278, 510800, '广元市', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40217, 2148, 431025, '临武县', 3, 228, '郴州市', 19, '湖南省', 20, '424300', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40219, 922, 211403, '龙港区', 3, 85, '葫芦岛市', 7, '辽宁省', 20, '125003', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40221, 3422, 510811, '昭化区', 3, 278, '广元市', 24, '四川省', 20, '628000', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40223, 2145, 431022, '宜章县', 3, 228, '郴州市', 19, '湖南省', 20, '424200', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40225, 925, 211422, '建昌县', 3, 85, '葫芦岛市', 7, '辽宁省', 20, '125300', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40227, 2147, 431024, '嘉禾县', 3, 228, '郴州市', 19, '湖南省', 20, '424500', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40229, 2596, 510823, '剑阁县', 3, 278, '广元市', 24, '四川省', 20, '628300', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40231, 2593, 510812, '朝天区', 3, 278, '广元市', 24, '四川省', 20, '628017', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40233, 926, 211481, '兴城市', 3, 85, '葫芦岛市', 7, '辽宁省', 20, '125100', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40235, 2144, 431021, '桂阳县', 3, 228, '郴州市', 19, '湖南省', 20, '424400', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40237, 924, 211421, '绥中县', 3, 85, '葫芦岛市', 7, '辽宁省', 20, '125200', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40239, 229, 431100, '永州市', 2, 19, '湖南省', NULL, NULL, 20, '0', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40241, 2597, 510824, '苍溪县', 3, 278, '广元市', 24, '四川省', 20, '628400', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40243, 921, 211402, '连山区', 3, 85, '葫芦岛市', 7, '辽宁省', 20, '125001', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40245, 2153, 431103, '冷水滩区', 3, 229, '永州市', 19, '湖南省', 20, '425100', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40247, 2594, 510821, '旺苍县', 3, 278, '广元市', 24, '四川省', 20, '628200', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40249, 923, 211404, '南票区', 3, 85, '葫芦岛市', 7, '辽宁省', 20, '125027', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40251, 2154, 431121, '祁阳县', 3, 229, '永州市', 19, '湖南省', 20, '426100', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40253, 2595, 510822, '青川县', 3, 278, '广元市', 24, '四川省', 20, '628100', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40255, 83, 211200, '铁岭市', 2, 7, '辽宁省', NULL, NULL, 20, '0', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40257, 2155, 431122, '东安县', 3, 229, '永州市', 19, '湖南省', 20, '425900', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40259, 2591, 510802, '利州区', 3, 278, '广元市', 24, '四川省', 20, '628017', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40261, 279, 510900, '遂宁市', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:22', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40263, 913, 211282, '开原市', 3, 83, '铁岭市', 7, '辽宁省', 20, '112300', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40265, 2163, 431102, '零陵区', 3, 229, '永州市', 19, '湖南省', 20, '425002', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40267, 2602, 510923, '大英县', 3, 279, '遂宁市', 24, '四川省', 20, '629300', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40269, 912, 211281, '调兵山市', 3, 83, '铁岭市', 7, '辽宁省', 20, '112700', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40271, 2161, 431128, '新田县', 3, 229, '永州市', 19, '湖南省', 20, '425700', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40273, 2601, 510981, '射洪市', 3, 279, '遂宁市', 24, '四川省', 20, '629200', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40275, 908, 211204, '清河区', 3, 83, '铁岭市', 7, '辽宁省', 20, '112003', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40277, 2159, 431126, '宁远县', 3, 229, '永州市', 19, '湖南省', 20, '425600', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40279, 907, 211202, '银州区', 3, 83, '铁岭市', 7, '辽宁省', 20, '112000', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40281, 2600, 510921, '蓬溪县', 3, 279, '遂宁市', 24, '四川省', 20, '629100', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40283, 2156, 431123, '双牌县', 3, 229, '永州市', 19, '湖南省', 20, '425200', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40285, 910, 211223, '西丰县', 3, 83, '铁岭市', 7, '辽宁省', 20, '112400', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40287, 2599, 510904, '安居区', 3, 279, '遂宁市', 24, '四川省', 20, '629000', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40289, 2160, 431127, '蓝山县', 3, 229, '永州市', 19, '湖南省', 20, '425800', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40291, 909, 211221, '铁岭县', 3, 83, '铁岭市', 7, '辽宁省', 20, '112000', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40293, 2598, 510903, '船山区', 3, 279, '遂宁市', 24, '四川省', 20, '629000', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40295, 911, 211224, '昌图县', 3, 83, '铁岭市', 7, '辽宁省', 20, '112500', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40297, 2157, 431124, '道县', 3, 229, '永州市', 19, '湖南省', 20, '425300', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40299, 289, 512000, '资阳市', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40301, 72, 210100, '沈阳市', 2, 7, '辽宁省', NULL, NULL, 20, '0', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40303, 2158, 431125, '江永县', 3, 229, '永州市', 19, '湖南省', 20, '425400', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40305, 2669, 512021, '安岳县', 3, 289, '资阳市', 24, '四川省', 20, '642350', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40307, 832, 210181, '新民市', 3, 72, '沈阳市', 7, '辽宁省', 20, '110300', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40309, 2162, 431129, '江华瑶族自治县', 3, 229, '永州市', 19, '湖南省', 20, '425500', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40311, 2668, 512002, '雁江区', 3, 289, '资阳市', 24, '四川省', 20, '641300', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40313, 825, 210111, '苏家屯区', 3, 72, '沈阳市', 7, '辽宁省', 20, '110101', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40315, 22, 460000, '海南省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40317, 2670, 512022, '乐至县', 3, 289, '资阳市', 24, '四川省', 20, '641500', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40319, 823, 210105, '皇姑区', 3, 72, '沈阳市', 7, '辽宁省', 20, '110031', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40321, 2471, 469007, '东方市', 2, 22, '海南省', NULL, NULL, 20, '572600', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40323, 277, 510700, '绵阳市', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40325, 828, 210114, '于洪区', 3, 72, '沈阳市', 7, '辽宁省', 20, '110141', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40327, 2473, 469022, '屯昌县', 2, 22, '海南省', NULL, NULL, 20, '571600', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40329, 2579, 510704, '游仙区', 3, 277, '绵阳市', 24, '四川省', 20, '621022', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40331, 830, 210123, '康平县', 3, 72, '沈阳市', 7, '辽宁省', 20, '110500', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40333, 2583, 510725, '梓潼县', 3, 277, '绵阳市', 24, '四川省', 20, '622150', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40335, 2470, 469006, '万宁市', 2, 22, '海南省', NULL, NULL, 20, '571500', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40337, 831, 210124, '法库县', 3, 72, '沈阳市', 7, '辽宁省', 20, '110400', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40339, 2580, 510722, '三台县', 3, 277, '绵阳市', 24, '四川省', 20, '621100', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40341, 2475, 469024, '临高县', 2, 22, '海南省', NULL, NULL, 20, '571800', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40343, 821, 210103, '沈河区', 3, 72, '沈阳市', 7, '辽宁省', 20, '110013', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40345, 2586, 510781, '江油市', 3, 277, '绵阳市', 24, '四川省', 20, '621700', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40347, 2477, 469026, '昌江黎族自治县', 2, 22, '海南省', NULL, NULL, 20, '572700', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40349, 822, 210104, '大东区', 3, 72, '沈阳市', 7, '辽宁省', 20, '110041', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40351, 2581, 510723, '盐亭县', 3, 277, '绵阳市', 24, '四川省', 20, '621600', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40353, 2472, 469021, '定安县', 2, 22, '海南省', NULL, NULL, 20, '571200', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40355, 2584, 510726, '北川羌族自治县', 3, 277, '绵阳市', 24, '四川省', 20, '622750', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40357, 829, 210115, '辽中区', 3, 72, '沈阳市', 7, '辽宁省', 20, '110200', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40359, 2476, 469025, '白沙黎族自治县', 2, 22, '海南省', NULL, NULL, 20, '572800', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40361, 3421, 510705, '安州区', 3, 277, '绵阳市', 24, '四川省', 20, '622650', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40363, 827, 210113, '沈北新区', 3, 72, '沈阳市', 7, '辽宁省', 20, '110121', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40365, 2578, 510703, '涪城区', 3, 277, '绵阳市', 24, '四川省', 20, '621000', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40367, 2467, 469002, '琼海市', 2, 22, '海南省', NULL, NULL, 20, '571400', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40369, 834, NULL, '浑南区', 3, 72, '沈阳市', 7, '辽宁省', 20, '110179', '2020-08-04 00:58:23', '2020-08-07 00:29:08', 0);
INSERT INTO `t_areas` VALUES (40371, 2585, 510727, '平武县', 3, 277, '绵阳市', 24, '四川省', 20, '622550', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40373, 2481, 469030, '琼中黎族苗族自治县', 2, 22, '海南省', NULL, NULL, 20, '572900', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40375, 79, 210800, '营口市', 2, 7, '辽宁省', NULL, NULL, 20, '0', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40377, 285, 511600, '广安市', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40379, 2468, 460400, '儋州市', 2, 22, '海南省', NULL, NULL, 20, '571700', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40381, 888, 210882, '大石桥市', 3, 79, '营口市', 7, '辽宁省', 20, '115100', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40383, 2647, 511623, '邻水县', 3, 285, '广安市', 24, '四川省', 20, '638500', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40385, 885, 210804, '鲅鱼圈区', 3, 79, '营口市', 7, '辽宁省', 20, '115007', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40387, 2478, 469027, '乐东黎族自治县', 2, 22, '海南省', NULL, NULL, 20, '572500', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40389, 2646, 511622, '武胜县', 3, 285, '广安市', 24, '四川省', 20, '638400', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40391, 887, 210881, '盖州市', 3, 79, '营口市', 7, '辽宁省', 20, '115200', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40393, 2474, 469023, '澄迈县', 2, 22, '海南省', NULL, NULL, 20, '571900', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40395, 2644, 511602, '广安区', 3, 285, '广安市', 24, '四川省', 20, '638000', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40397, 884, 210803, '西市区', 3, 79, '营口市', 7, '辽宁省', 20, '115004', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40399, 270, 460200, '三亚市', 2, 22, '海南省', NULL, NULL, 20, '0', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40401, 2648, 511681, '华蓥市', 3, 285, '广安市', 24, '四川省', 20, '638600', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40403, 2489, 460204, '天涯区', 3, 270, '三亚市', 22, '海南省', 20, '572029', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40405, 883, 210802, '站前区', 3, 79, '营口市', 7, '辽宁省', 20, '115002', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40407, 2491, 460202, '海棠区', 3, 270, '三亚市', 22, '海南省', 20, '572014', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40409, 3424, 511603, '前锋区', 3, 285, '广安市', 24, '四川省', 20, '638019', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40411, 886, 210811, '老边区', 3, 79, '营口市', 7, '辽宁省', 20, '115005', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40413, 2645, 511621, '岳池县', 3, 285, '广安市', 24, '四川省', 20, '638300', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40415, 3415, 460203, '吉阳区', 3, 270, '三亚市', 22, '海南省', 20, '572099', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40417, 82, 211100, '盘锦市', 2, 7, '辽宁省', NULL, NULL, 20, '0', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40419, 286, 511700, '达州市', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40421, 3417, 460205, '崖州区', 3, 270, '三亚市', 22, '海南省', 20, '572024', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40423, 904, 211103, '兴隆台区', 3, 82, '盘锦市', 7, '辽宁省', 20, '124010', '2020-08-04 00:58:23', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40425, 2479, 469028, '陵水黎族自治县', 2, 22, '海南省', NULL, NULL, 20, '572400', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40427, 906, 211122, '盘山县', 3, 82, '盘锦市', 7, '辽宁省', 20, '124000', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40429, 2653, 511724, '大竹县', 3, 286, '达州市', 24, '四川省', 20, '635100', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40431, 905, 211104, '大洼区', 3, 82, '盘锦市', 7, '辽宁省', 20, '124200', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40433, 2469, 469005, '文昌市', 2, 22, '海南省', NULL, NULL, 20, '571300', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40435, 2654, 511725, '渠县', 3, 286, '达州市', 24, '四川省', 20, '635200', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40437, 903, 211102, '双台子区', 3, 82, '盘锦市', 7, '辽宁省', 20, '124000', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40439, 3418, 460300, '三沙市', 2, 22, '海南省', NULL, NULL, 20, '573199', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40441, 2651, 511722, '宣汉县', 3, 286, '达州市', 24, '四川省', 20, '636150', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40443, 80, 210900, '阜新市', 2, 7, '辽宁省', NULL, NULL, 20, '0', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40445, 3467, 460301, '西沙区', 3, 3418, '三沙市', 22, '海南省', 20, NULL, '2020-08-04 00:58:24', '2020-08-06 22:39:19', 0);
INSERT INTO `t_areas` VALUES (40447, 2652, 511723, '开江县', 3, 286, '达州市', 24, '四川省', 20, '636250', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40449, 892, 210905, '清河门区', 3, 80, '阜新市', 7, '辽宁省', 20, '123006', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40453, 2655, 511781, '万源市', 3, 286, '达州市', 24, '四川省', 20, '636350', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40455, 891, 210904, '太平区', 3, 80, '阜新市', 7, '辽宁省', 20, '123003', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40457, 2649, 511702, '通川区', 3, 286, '达州市', 24, '四川省', 20, '635000', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40459, 894, 210921, '阜新蒙古族自治县', 3, 80, '阜新市', 7, '辽宁省', 20, '123100', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40461, 268, 460100, '海口市', 2, 22, '海南省', NULL, NULL, 20, '0', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40463, 3425, 511703, '达川区', 3, 286, '达州市', 24, '四川省', 20, '511703', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40465, 890, 210903, '新邱区', 3, 80, '阜新市', 7, '辽宁省', 20, '123005', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40467, 895, 210922, '彰武县', 3, 80, '阜新市', 7, '辽宁省', 20, '123200', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40469, 282, 511300, '南充市', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40471, 2465, 460108, '美兰区', 3, 268, '海口市', 22, '海南省', 20, '570203', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40473, 893, 210911, '细河区', 3, 80, '阜新市', 7, '辽宁省', 20, '123000', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40475, 2624, 511323, '蓬安县', 3, 282, '南充市', 24, '四川省', 20, '637800', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40477, 2463, 460106, '龙华区', 3, 268, '海口市', 22, '海南省', 20, '570105', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40479, 76, 210500, '本溪市', 2, 7, '辽宁省', NULL, NULL, 20, '0', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40481, 2626, 511325, '西充县', 3, 282, '南充市', 24, '四川省', 20, '637200', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40483, 2464, 460107, '琼山区', 3, 268, '海口市', 22, '海南省', 20, '571100', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40485, 867, 210522, '桓仁满族自治县', 3, 76, '本溪市', 7, '辽宁省', 20, '117200', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40487, 2623, 511322, '营山县', 3, 282, '南充市', 24, '四川省', 20, '637700', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40489, 2462, 460105, '秀英区', 3, 268, '海口市', 22, '海南省', 20, '570311', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40491, 2622, 511321, '南部县', 3, 282, '南充市', 24, '四川省', 20, '637300', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40493, 864, 210503, '溪湖区', 3, 76, '本溪市', 7, '辽宁省', 20, '117002', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40495, 2480, 469029, '保亭黎族苗族自治县', 2, 22, '海南省', NULL, NULL, 20, '572300', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40497, 865, 210505, '南芬区', 3, 76, '本溪市', 7, '辽宁省', 20, '117014', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40499, 2621, 511304, '嘉陵区', 3, 282, '南充市', 24, '四川省', 20, '637100', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40501, 2466, 469001, '五指山市', 2, 22, '海南省', NULL, NULL, 20, '572200', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40503, 862, 210502, '平山区', 3, 76, '本溪市', 7, '辽宁省', 20, '117000', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40505, 2625, 511324, '仪陇县', 3, 282, '南充市', 24, '四川省', 20, '637600', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40507, 30, 630000, '青海省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40509, 2620, 511303, '高坪区', 3, 282, '南充市', 24, '四川省', 20, '637100', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40511, 354, 632600, '果洛藏族自治州', 2, 30, '青海省', NULL, NULL, 20, '0', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40513, 863, 210504, '明山区', 3, 76, '本溪市', 7, '辽宁省', 20, '117021', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40515, 2619, 511302, '顺庆区', 3, 282, '南充市', 24, '四川省', 20, '637000', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40517, 3236, 632623, '甘德县', 3, 354, '果洛藏族自治州', 30, '青海省', 20, '814100', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40519, 866, 210521, '本溪满族自治县', 3, 76, '本溪市', 7, '辽宁省', 20, '117100', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40521, 2627, 511381, '阆中市', 3, 282, '南充市', 24, '四川省', 20, '637400', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40523, 81, 211000, '辽阳市', 2, 7, '辽宁省', NULL, NULL, 20, '0', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40525, 3234, 632621, '玛沁县', 3, 354, '果洛藏族自治州', 30, '青海省', 20, '814000', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40527, 280, 511000, '内江市', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40529, 3237, 632624, '达日县', 3, 354, '果洛藏族自治州', 30, '青海省', 20, '814200', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40531, 899, 211005, '弓长岭区', 3, 81, '辽阳市', 7, '辽宁省', 20, '111008', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40533, 2606, 511025, '资中县', 3, 280, '内江市', 24, '四川省', 20, '641200', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40535, 902, 211081, '灯塔市', 3, 81, '辽阳市', 7, '辽宁省', 20, '111300', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40537, 3238, 632625, '久治县', 3, 354, '果洛藏族自治州', 30, '青海省', 20, '624700', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40539, 2604, 511011, '东兴区', 3, 280, '内江市', 24, '四川省', 20, '641100', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40541, 901, 211021, '辽阳县', 3, 81, '辽阳市', 7, '辽宁省', 20, '111200', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40543, 2605, 511024, '威远县', 3, 280, '内江市', 24, '四川省', 20, '642450', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40545, 3235, 632622, '班玛县', 3, 354, '果洛藏族自治州', 30, '青海省', 20, '814300', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40547, 896, 211002, '白塔区', 3, 81, '辽阳市', 7, '辽宁省', 20, '111000', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40549, 2607, 511083, '隆昌市', 3, 280, '内江市', 24, '四川省', 20, '642150', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40551, 897, 211003, '文圣区', 3, 81, '辽阳市', 7, '辽宁省', 20, '111000', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40553, 3239, 632626, '玛多县', 3, 354, '果洛藏族自治州', 30, '青海省', 20, '813500', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40555, 284, 511500, '宜宾市', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40557, 353, 632500, '海南藏族自治州', 2, 30, '青海省', NULL, NULL, 20, '0', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40559, 900, 211011, '太子河区', 3, 81, '辽阳市', 7, '辽宁省', 20, '111000', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40561, 2640, 511526, '珙县', 3, 284, '宜宾市', 24, '四川省', 20, '644500', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40563, 898, 211004, '宏伟区', 3, 81, '辽阳市', 7, '辽宁省', 20, '111003', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40565, 3231, 632523, '贵德县', 3, 353, '海南藏族自治州', 30, '青海省', 20, '811700', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40567, 74, 210300, '鞍山市', 2, 7, '辽宁省', NULL, NULL, 20, '0', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40569, 3229, 632521, '共和县', 3, 353, '海南藏族自治州', 30, '青海省', 20, '813000', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40571, 2642, 511528, '兴文县', 3, 284, '宜宾市', 24, '四川省', 20, '644400', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40573, 852, 210321, '台安县', 3, 74, '鞍山市', 7, '辽宁省', 20, '114100', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40575, 2638, 511524, '长宁县', 3, 284, '宜宾市', 24, '四川省', 20, '644300', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40577, 3233, 632525, '贵南县', 3, 353, '海南藏族自治州', 30, '青海省', 20, '813100', '2020-08-04 00:58:24', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40579, 853, 210323, '岫岩满族自治县', 3, 74, '鞍山市', 7, '辽宁省', 20, '114300', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40581, 2637, 511523, '江安县', 3, 284, '宜宾市', 24, '四川省', 20, '644200', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40583, 3230, 632522, '同德县', 3, 353, '海南藏族自治州', 30, '青海省', 20, '813200', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40585, 3232, 632524, '兴海县', 3, 353, '海南藏族自治州', 30, '青海省', 20, '813300', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40587, 2636, 511503, '南溪区', 3, 284, '宜宾市', 24, '四川省', 20, '644100', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40589, 851, 210311, '千山区', 3, 74, '鞍山市', 7, '辽宁省', 20, '114041', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40591, 2634, 511502, '翠屏区', 3, 284, '宜宾市', 24, '四川省', 20, '644000', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40593, 355, 632700, '玉树藏族自治州', 2, 30, '青海省', NULL, NULL, 20, '0', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40595, 2639, 511525, '高县', 3, 284, '宜宾市', 24, '四川省', 20, '645150', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40597, 850, 210304, '立山区', 3, 74, '鞍山市', 7, '辽宁省', 20, '114031', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40599, 3242, 632723, '称多县', 3, 355, '玉树藏族自治州', 30, '青海省', 20, '815100', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40601, 2641, 511527, '筠连县', 3, 284, '宜宾市', 24, '四川省', 20, '645250', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40603, 854, 210381, '海城市', 3, 74, '鞍山市', 7, '辽宁省', 20, '114200', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40605, 3243, 632724, '治多县', 3, 355, '玉树藏族自治州', 30, '青海省', 20, '815400', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40607, 84, 211300, '朝阳市', 2, 7, '辽宁省', NULL, NULL, 20, '0', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40609, 2643, 511529, '屏山县', 3, 284, '宜宾市', 24, '四川省', 20, '645350', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40611, 3245, 632726, '曲麻莱县', 3, 355, '玉树藏族自治州', 30, '青海省', 20, '815500', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40613, 3423, 511504, '叙州区', 3, 284, '宜宾市', 24, '四川省', 20, '644600', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40615, 917, 211322, '建平县', 3, 84, '朝阳市', 7, '辽宁省', 20, '122400', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40617, 3240, 632701, '玉树市', 3, 355, '玉树藏族自治州', 30, '青海省', 20, '815000', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40619, 275, 510500, '泸州市', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40621, 919, 211381, '北票市', 3, 84, '朝阳市', 7, '辽宁省', 20, '122100', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40623, 3241, 632722, '杂多县', 3, 355, '玉树藏族自治州', 30, '青海省', 20, '815300', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40625, 2567, 510504, '龙马潭区', 3, 275, '泸州市', 24, '四川省', 20, '646000', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40627, 916, 211321, '朝阳县', 3, 84, '朝阳市', 7, '辽宁省', 20, '122000', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40629, 3244, 632725, '囊谦县', 3, 355, '玉树藏族自治州', 30, '青海省', 20, '815200', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40631, 2568, 510521, '泸县', 3, 275, '泸州市', 24, '四川省', 20, '646106', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40633, 914, 211302, '双塔区', 3, 84, '朝阳市', 7, '辽宁省', 20, '122000', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40635, 352, 632300, '黄南藏族自治州', 2, 30, '青海省', NULL, NULL, 20, '0', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40637, 915, 211303, '龙城区', 3, 84, '朝阳市', 7, '辽宁省', 20, '122000', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40639, 2566, 510503, '纳溪区', 3, 275, '泸州市', 24, '四川省', 20, '646300', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40641, 3226, 632322, '尖扎县', 3, 352, '黄南藏族自治州', 30, '青海省', 20, '811200', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40643, 918, 211324, '喀喇沁左翼蒙古族自治县', 3, 84, '朝阳市', 7, '辽宁省', 20, '122300', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40645, 2570, 510524, '叙永县', 3, 275, '泸州市', 24, '四川省', 20, '646400', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40647, 3225, 632321, '同仁县', 3, 352, '黄南藏族自治州', 30, '青海省', 20, '811300', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40649, 920, 211382, '凌源市', 3, 84, '朝阳市', 7, '辽宁省', 20, '122500', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40651, 2571, 510525, '古蔺县', 3, 275, '泸州市', 24, '四川省', 20, '646500', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40653, 3228, 632324, '河南蒙古族自治县', 3, 352, '黄南藏族自治州', 30, '青海省', 20, '811500', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40655, 18, 420000, '湖北省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40657, 3227, 632323, '泽库县', 3, 352, '黄南藏族自治州', 30, '青海省', 20, '811400', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40659, 2565, 510502, '江阳区', 3, 275, '泸州市', 24, '四川省', 20, '646000', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40661, 207, 420300, '十堰市', 2, 18, '湖北省', NULL, NULL, 20, '0', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40663, 2569, 510522, '合江县', 3, 275, '泸州市', 24, '四川省', 20, '646200', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40665, 356, 632800, '海西蒙古族藏族自治州', 2, 30, '青海省', NULL, NULL, 20, '0', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40667, 290, 513200, '阿坝藏族羌族自治州', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40669, 1990, 420381, '丹江口市', 3, 207, '十堰市', 18, '湖北省', 20, '442700', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40671, 3250, 632823, '天峻县', 3, 356, '海西蒙古族藏族自治州', 30, '青海省', 20, '817200', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40673, 2682, 513231, '阿坝县', 3, 290, '阿坝藏族羌族自治州', 24, '四川省', 20, '624600', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40675, 3405, 420304, '郧阳区', 3, 207, '十堰市', 18, '湖北省', 20, '442500', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40677, 3247, 632802, '德令哈市', 3, 356, '海西蒙古族藏族自治州', 30, '青海省', 20, '817000', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40679, 2679, 513228, '黑水县', 3, 290, '阿坝藏族羌族自治州', 24, '四川省', 20, '623500', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40681, 1984, 420303, '张湾区', 3, 207, '十堰市', 18, '湖北省', 20, '442001', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40683, 3249, 632822, '都兰县', 3, 356, '海西蒙古族藏族自治州', 30, '青海省', 20, '816100', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40685, 2676, 513225, '九寨沟县', 3, 290, '阿坝藏族羌族自治州', 24, '四川省', 20, '623400', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40687, 3246, 632801, '格尔木市', 3, 356, '海西蒙古族藏族自治州', 30, '青海省', 20, '816000', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40689, 1983, 420302, '茅箭区', 3, 207, '十堰市', 18, '湖北省', 20, '442012', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40691, 2673, 513222, '理县', 3, 290, '阿坝藏族羌族自治州', 24, '四川省', 20, '623100', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40693, 1988, 420324, '竹溪县', 3, 207, '十堰市', 18, '湖北省', 20, '442300', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40695, 3468, 632825, '海西蒙古族藏族自治州直辖', 3, 356, '海西蒙古族藏族自治州', 30, '青海省', 20, NULL, '2020-08-04 00:58:25', '2020-08-06 22:39:19', 0);
INSERT INTO `t_areas` VALUES (40697, 2683, 513232, '若尔盖县', 3, 290, '阿坝藏族羌族自治州', 24, '四川省', 20, '624500', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40699, 3248, 632821, '乌兰县', 3, 356, '海西蒙古族藏族自治州', 30, '青海省', 20, '817100', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40701, 1987, 420323, '竹山县', 3, 207, '十堰市', 18, '湖北省', 20, '442200', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40703, 2677, 513226, '金川县', 3, 290, '阿坝藏族羌族自治州', 24, '四川省', 20, '624100', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40705, 3444, 632803, '茫崖市', 3, 356, '海西蒙古族藏族自治州', 30, '青海省', 20, '632803', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40707, 1989, 420325, '房县', 3, 207, '十堰市', 18, '湖北省', 20, '442100', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40709, 2684, 513233, '红原县', 3, 290, '阿坝藏族羌族自治州', 24, '四川省', 20, '624400', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40711, 1986, 420322, '郧西县', 3, 207, '十堰市', 18, '湖北省', 20, '442600', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40713, 350, 630200, '海东市', 2, 30, '青海省', NULL, NULL, 20, '0', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40715, 2672, 513221, '汶川县', 3, 290, '阿坝藏族羌族自治州', 24, '四川省', 20, '623000', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40717, 209, 420600, '襄阳市', 2, 18, '湖北省', NULL, NULL, 20, '0', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40719, 3219, 630224, '化隆回族自治县', 3, 350, '海东市', 30, '青海省', 20, '810900', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40721, 2680, 513201, '马尔康市', 3, 290, '阿坝藏族羌族自治州', 24, '四川省', 20, '624000', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40723, 2013, 420684, '宜城市', 3, 209, '襄阳市', 18, '湖北省', 20, '441400', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40725, 2675, 513224, '松潘县', 3, 290, '阿坝藏族羌族自治州', 24, '四川省', 20, '623300', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40727, 3216, 630222, '民和回族土族自治县', 3, 350, '海东市', 30, '青海省', 20, '810800', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40729, 2010, 420626, '保康县', 3, 209, '襄阳市', 18, '湖北省', 20, '441600', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40731, 3217, 630202, '乐都区', 3, 350, '海东市', 30, '青海省', 20, '810700', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40733, 2674, 513223, '茂县', 3, 290, '阿坝藏族羌族自治州', 24, '四川省', 20, '623200', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40735, 3220, 630225, '循化撒拉族自治县', 3, 350, '海东市', 30, '青海省', 20, '811100', '2020-08-04 00:58:25', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40737, 2012, 420683, '枣阳市', 3, 209, '襄阳市', 18, '湖北省', 20, '441200', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40739, 2678, 513227, '小金县', 3, 290, '阿坝藏族羌族自治州', 24, '四川省', 20, '624200', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40741, 2009, 420625, '谷城县', 3, 209, '襄阳市', 18, '湖北省', 20, '441700', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40743, 3215, 630203, '平安区', 3, 350, '海东市', 30, '青海省', 20, '810600', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40745, 2681, 513230, '壤塘县', 3, 290, '阿坝藏族羌族自治州', 24, '四川省', 20, '624300', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40747, 2008, 420624, '南漳县', 3, 209, '襄阳市', 18, '湖北省', 20, '441500', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40749, 273, 510300, '自贡市', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40751, 3218, 630223, '互助土族自治县', 3, 350, '海东市', 30, '青海省', 20, '810500', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40753, 349, 630100, '西宁市', 2, 30, '青海省', NULL, NULL, 20, '0', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40755, 2011, 420682, '老河口市', 3, 209, '襄阳市', 18, '湖北省', 20, '441800', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40757, 2557, 510311, '沿滩区', 3, 273, '自贡市', 24, '四川省', 20, '643030', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40759, 2005, 420602, '襄城区', 3, 209, '襄阳市', 18, '湖北省', 20, '441021', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40761, 3214, 630123, '湟源县', 3, 349, '西宁市', 30, '青海省', 20, '812100', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40763, 2556, 510304, '大安区', 3, 273, '自贡市', 24, '四川省', 20, '643010', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40765, 2006, 420606, '樊城区', 3, 209, '襄阳市', 18, '湖北省', 20, '441001', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40767, 2558, 510321, '荣县', 3, 273, '自贡市', 24, '四川省', 20, '643100', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40769, 3208, 630102, '城东区', 3, 349, '西宁市', 30, '青海省', 20, '810000', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40771, 3406, 420607, '襄州区', 3, 209, '襄阳市', 18, '湖北省', 20, '441100', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40773, 2554, 510302, '自流井区', 3, 273, '自贡市', 24, '四川省', 20, '643000', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40775, 3212, 630121, '大通回族土族自治县', 3, 349, '西宁市', 30, '青海省', 20, '810100', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40777, 208, 420500, '宜昌市', 2, 18, '湖北省', NULL, NULL, 20, '0', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40779, 3210, 630104, '城西区', 3, 349, '西宁市', 30, '青海省', 20, '810000', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40781, 2559, 510322, '富顺县', 3, 273, '自贡市', 24, '四川省', 20, '643200', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40783, 1996, 420525, '远安县', 3, 208, '宜昌市', 18, '湖北省', 20, '444200', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40785, 3213, 630106, '湟中区', 3, 349, '西宁市', 30, '青海省', 20, '811600', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40787, 2555, 510303, '贡井区', 3, 273, '自贡市', 24, '四川省', 20, '643020', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40789, 3211, 630105, '城北区', 3, 349, '西宁市', 30, '青海省', 20, '810000', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40791, 1997, 420526, '兴山县', 3, 208, '宜昌市', 18, '湖北省', 20, '443711', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40793, 287, 511800, '雅安市', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40795, 351, 632200, '海北藏族自治州', 2, 30, '青海省', NULL, NULL, 20, '0', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40797, 2002, 420582, '当阳市', 3, 208, '宜昌市', 18, '湖北省', 20, '444100', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40799, 2663, 511827, '宝兴县', 3, 287, '雅安市', 24, '四川省', 20, '625700', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40801, 1998, 420527, '秭归县', 3, 208, '宜昌市', 18, '湖北省', 20, '443600', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40803, 3223, 632223, '海晏县', 3, 351, '海北藏族自治州', 30, '青海省', 20, '812200', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40805, 1999, 420528, '长阳土家族自治县', 3, 208, '宜昌市', 18, '湖北省', 20, '443500', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40807, 3221, 632221, '门源回族自治县', 3, 351, '海北藏族自治州', 30, '青海省', 20, '810300', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40809, 2658, 511822, '荥经县', 3, 287, '雅安市', 24, '四川省', 20, '625200', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40811, 1993, 420504, '点军区', 3, 208, '宜昌市', 18, '湖北省', 20, '443006', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40813, 3224, 632224, '刚察县', 3, 351, '海北藏族自治州', 30, '青海省', 20, '812300', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40815, 2660, 511824, '石棉县', 3, 287, '雅安市', 24, '四川省', 20, '625400', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40817, 1994, 420505, '猇亭区', 3, 208, '宜昌市', 18, '湖北省', 20, '443007', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40819, 3222, 632222, '祁连县', 3, 351, '海北藏族自治州', 30, '青海省', 20, '810400', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40821, 2659, 511823, '汉源县', 3, 287, '雅安市', 24, '四川省', 20, '625300', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40823, 1992, 420503, '伍家岗区', 3, 208, '宜昌市', 18, '湖北省', 20, '443001', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40825, 2661, 511825, '天全县', 3, 287, '雅安市', 24, '四川省', 20, '625500', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40827, 23, 500000, '重庆市', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40829, 2001, 420581, '宜都市', 3, 208, '宜昌市', 18, '湖北省', 20, '443300', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40831, 2656, 511802, '雨城区', 3, 287, '雅安市', 24, '四川省', 20, '625000', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40833, 3469, 500200, '重庆郊县', 2, 23, '重庆市', NULL, NULL, 20, NULL, '2020-08-04 00:58:26', '2020-08-06 22:39:19', 0);
INSERT INTO `t_areas` VALUES (40835, 2662, 511826, '芦山县', 3, 287, '雅安市', 24, '四川省', 20, '625600', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40837, 2000, 420529, '五峰土家族自治县', 3, 208, '宜昌市', 18, '湖北省', 20, '443400', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40839, 2521, 500236, '奉节县', 3, 3469, '重庆郊县', 23, '重庆市', 20, '404600', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40841, 2657, 511803, '名山区', 3, 287, '雅安市', 24, '四川省', 20, '625100', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40843, 2523, 500238, '巫溪县', 3, 3469, '重庆郊县', 23, '重庆市', 20, '405800', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40845, 2003, 420583, '枝江市', 3, 208, '宜昌市', 18, '湖北省', 20, '443200', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40847, 283, 511400, '眉山市', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40849, 2514, 500229, '城口县', 3, 3469, '重庆郊县', 23, '重庆市', 20, '405900', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40851, 1995, 420506, '夷陵区', 3, 208, '宜昌市', 18, '湖北省', 20, '443100', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40853, 2631, 511423, '洪雅县', 3, 283, '眉山市', 24, '四川省', 20, '620360', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40855, 2515, 500230, '丰都县', 3, 3469, '重庆郊县', 23, '重庆市', 20, '408200', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40857, 1991, 420502, '西陵区', 3, 208, '宜昌市', 18, '湖北省', 20, '443000', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40859, 2632, 511424, '丹棱县', 3, 283, '眉山市', 24, '四川省', 20, '620200', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40861, 2527, 500243, '彭水苗族土家族自治县', 3, 3469, '重庆郊县', 23, '重庆市', 20, '409600', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40863, 211, 420800, '荆门市', 2, 18, '湖北省', NULL, NULL, 20, '0', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40865, 2629, 511421, '仁寿县', 3, 283, '眉山市', 24, '四川省', 20, '620500', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40867, 2525, 500241, '秀山土家族苗族自治县', 3, 3469, '重庆郊县', 23, '重庆市', 20, '409900', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40869, 2630, 511403, '彭山区', 3, 283, '眉山市', 24, '四川省', 20, '620860', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40871, 2520, 500235, '云阳县', 3, 3469, '重庆郊县', 23, '重庆市', 20, '404500', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40873, 2017, 420802, '东宝区', 3, 211, '荆门市', 18, '湖北省', 20, '448004', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40875, 2522, 500237, '巫山县', 3, 3469, '重庆郊县', 23, '重庆市', 20, '404700', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40877, 2021, 420881, '钟祥市', 3, 211, '荆门市', 18, '湖北省', 20, '431900', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40879, 2633, 511425, '青神县', 3, 283, '眉山市', 24, '四川省', 20, '620460', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40881, 2526, 500242, '酉阳土家族苗族自治县', 3, 3469, '重庆郊县', 23, '重庆市', 20, '409800', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40883, 2019, 420882, '京山市', 3, 211, '荆门市', 18, '湖北省', 20, '431800', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40885, 2628, 511402, '东坡区', 3, 283, '眉山市', 24, '四川省', 20, '620010', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40887, 2516, 500231, '垫江县', 3, 3469, '重庆郊县', 23, '重庆市', 20, '408300', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40889, 2018, 420804, '掇刀区', 3, 211, '荆门市', 18, '湖北省', 20, '448124', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40891, 281, 511100, '乐山市', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40893, 2518, 500233, '忠县', 3, 3469, '重庆郊县', 23, '重庆市', 20, '404300', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40895, 2609, 511111, '沙湾区', 3, 281, '乐山市', 24, '四川省', 20, '614900', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40897, 2020, 420822, '沙洋县', 3, 211, '荆门市', 18, '湖北省', 20, '448200', '2020-08-04 00:58:26', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40899, 2524, 500240, '石柱土家族自治县', 3, 3469, '重庆郊县', 23, '重庆市', 20, '409100', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40901, 214, 421100, '黄冈市', 2, 18, '湖北省', NULL, NULL, 20, '0', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40903, 2614, 511126, '夹江县', 3, 281, '乐山市', 24, '四川省', 20, '614100', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40905, 271, 500100, '重庆城区', 2, 23, '重庆市', NULL, NULL, 20, '0', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40907, 2045, 421181, '麻城市', 3, 214, '黄冈市', 18, '湖北省', 20, '438300', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40909, 2613, 511124, '井研县', 3, 281, '乐山市', 24, '四川省', 20, '613100', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40911, 2530, 500117, '合川区', 3, 271, '重庆城区', 23, '重庆市', 20, '401520', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40913, 2611, 511113, '金口河区', 3, 281, '乐山市', 24, '四川省', 20, '614700', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40915, 2038, 421121, '团风县', 3, 214, '黄冈市', 18, '湖北省', 20, '438000', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40917, 2508, 500152, '潼南区', 3, 271, '重庆城区', 23, '重庆市', 20, '402660', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40919, 2037, 421102, '黄州区', 3, 214, '黄冈市', 18, '湖北省', 20, '438000', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40921, 2612, 511123, '犍为县', 3, 281, '乐山市', 24, '四川省', 20, '614400', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40923, 2509, 500151, '铜梁区', 3, 271, '重庆城区', 23, '重庆市', 20, '402560', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40925, 2043, 421126, '蕲春县', 3, 214, '黄冈市', 18, '湖北省', 20, '435300', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40927, 2610, 511112, '五通桥区', 3, 281, '乐山市', 24, '四川省', 20, '614800', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40929, 2506, 500115, '长寿区', 3, 271, '重庆城区', 23, '重庆市', 20, '401220', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40931, 2042, 421125, '浠水县', 3, 214, '黄冈市', 18, '湖北省', 20, '438200', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40933, 2615, 511129, '沐川县', 3, 281, '乐山市', 24, '四川省', 20, '614500', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40935, 2512, 500120, '璧山区', 3, 271, '重庆城区', 23, '重庆市', 20, '402760', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40937, 2041, 421124, '英山县', 3, 214, '黄冈市', 18, '湖北省', 20, '438700', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40939, 2616, 511132, '峨边彝族自治县', 3, 281, '乐山市', 24, '四川省', 20, '614300', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40941, 2039, 421122, '红安县', 3, 214, '黄冈市', 18, '湖北省', 20, '438401', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40943, 2510, 500111, '大足区', 3, 271, '重庆城区', 23, '重庆市', 20, '402360', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40945, 2617, 511133, '马边彝族自治县', 3, 281, '乐山市', 24, '四川省', 20, '614600', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40947, 2044, 421127, '黄梅县', 3, 214, '黄冈市', 18, '湖北省', 20, '435500', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40949, 2511, 500153, '荣昌区', 3, 271, '重庆城区', 23, '重庆市', 20, '402460', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40951, 2531, 500118, '永川区', 3, 271, '重庆城区', 23, '重庆市', 20, '402160', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40953, 2618, 511181, '峨眉山市', 3, 281, '乐山市', 24, '四川省', 20, '614200', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40955, 2046, 421182, '武穴市', 3, 214, '黄冈市', 18, '湖北省', 20, '435400', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40957, 274, 510400, '攀枝花市', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40959, 2494, 500103, '渝中区', 3, 271, '重庆城区', 23, '重庆市', 20, '400010', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40961, 2040, 421123, '罗田县', 3, 214, '黄冈市', 18, '湖北省', 20, '438600', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40963, 2517, 500156, '武隆区', 3, 271, '重庆城区', 23, '重庆市', 20, '408500', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40965, 2563, 510421, '米易县', 3, 274, '攀枝花市', 24, '四川省', 20, '617200', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40967, 2065, 429006, '天门市', 2, 18, '湖北省', NULL, NULL, 20, '431700', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40969, 2532, 500119, '南川区', 3, 271, '重庆城区', 23, '重庆市', 20, '408400', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40971, 2561, 510403, '西区', 3, 274, '攀枝花市', 24, '四川省', 20, '617068', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40973, 212, 420900, '孝感市', 2, 18, '湖北省', NULL, NULL, 20, '0', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40975, 2498, 500107, '九龙坡区', 3, 271, '重庆城区', 23, '重庆市', 20, '400050', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40977, 2564, 510422, '盐边县', 3, 274, '攀枝花市', 24, '四川省', 20, '617100', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40979, 2025, 420923, '云梦县', 3, 212, '孝感市', 18, '湖北省', 20, '432500', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40981, 2495, 500104, '大渡口区', 3, 271, '重庆城区', 23, '重庆市', 20, '400080', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40983, 2492, 500101, '万州区', 3, 271, '重庆城区', 23, '重庆市', 20, '404100', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40985, 2026, 420981, '应城市', 3, 212, '孝感市', 18, '湖北省', 20, '432400', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40987, 2562, 510411, '仁和区', 3, 274, '攀枝花市', 24, '四川省', 20, '617061', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40989, 2022, 420902, '孝南区', 3, 212, '孝感市', 18, '湖北省', 20, '432100', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40991, 2560, 510402, '东区', 3, 274, '攀枝花市', 24, '四川省', 20, '617067', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40993, 2493, 500102, '涪陵区', 3, 271, '重庆城区', 23, '重庆市', 20, '408000', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40995, 2028, 420984, '汉川市', 3, 212, '孝感市', 18, '湖北省', 20, '432300', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40997, 292, 513400, '凉山彝族自治州', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (40999, 2507, 500110, '綦江区', 3, 271, '重庆城区', 23, '重庆市', 20, '401420', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41001, 2707, 513425, '会理县', 3, 292, '凉山彝族自治州', 24, '四川省', 20, '201600', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41003, 2513, 500155, '梁平区', 3, 271, '重庆城区', 23, '重庆市', 20, '405200', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41005, 2023, 420921, '孝昌县', 3, 212, '孝感市', 18, '湖北省', 20, '432900', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41007, 3419, 500154, '开州区', 3, 271, '重庆城区', 23, '重庆市', 20, '405400', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41009, 2024, 420922, '大悟县', 3, 212, '孝感市', 18, '湖北省', 20, '432800', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41011, 2719, 513437, '雷波县', 3, 292, '凉山彝族自治州', 24, '四川省', 20, '616550', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41013, 2529, 500116, '江津区', 3, 271, '重庆城区', 23, '重庆市', 20, '402260', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41015, 2027, 420982, '安陆市', 3, 212, '孝感市', 18, '湖北省', 20, '432600', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41017, 2714, 513432, '喜德县', 3, 292, '凉山彝族自治州', 24, '四川省', 20, '616750', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41019, 2505, 500114, '黔江区', 3, 271, '重庆城区', 23, '重庆市', 20, '409700', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41021, 2713, 513431, '昭觉县', 3, 292, '凉山彝族自治州', 24, '四川省', 20, '202150', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41023, 2064, 429005, '潜江市', 2, 18, '湖北省', NULL, NULL, 20, '433100', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41025, 2499, 500108, '南岸区', 3, 271, '重庆城区', 23, '重庆市', 20, '400064', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41027, 2711, 513429, '布拖县', 3, 292, '凉山彝族自治州', 24, '四川省', 20, '201500', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41029, 217, 422800, '恩施土家族苗族自治州', 2, 18, '湖北省', NULL, NULL, 20, '0', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41031, 2504, 500113, '巴南区', 3, 271, '重庆城区', 23, '重庆市', 20, '401320', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41033, 2703, 513401, '西昌市', 3, 292, '凉山彝族自治州', 24, '四川省', 20, '200000', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41035, 2057, 422822, '建始县', 3, 217, '恩施土家族苗族自治州', 18, '湖北省', 20, '445300', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41037, 2497, 500106, '沙坪坝区', 3, 271, '重庆城区', 23, '重庆市', 20, '400030', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41039, 2710, 513428, '普格县', 3, 292, '凉山彝族自治州', 24, '四川省', 20, '201700', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41041, 2055, 422801, '恩施市', 3, 217, '恩施土家族苗族自治州', 18, '湖北省', 20, '445000', '2020-08-04 00:58:27', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41043, 2500, 500109, '北碚区', 3, 271, '重庆城区', 23, '重庆市', 20, '400700', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41045, 2704, 513422, '木里藏族自治县', 3, 292, '凉山彝族自治州', 24, '四川省', 20, '200000', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41047, 2056, 422802, '利川市', 3, 217, '恩施土家族苗族自治州', 18, '湖北省', 20, '445400', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41049, 2503, 500112, '渝北区', 3, 271, '重庆城区', 23, '重庆市', 20, '401120', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41051, 2715, 513433, '冕宁县', 3, 292, '凉山彝族自治州', 24, '四川省', 20, '615600', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41053, 2062, 422828, '鹤峰县', 3, 217, '恩施土家族苗族自治州', 18, '湖北省', 20, '445800', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41055, 27, 540000, '西藏自治区', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41057, 2061, 422827, '来凤县', 3, 217, '恩施土家族苗族自治州', 18, '湖北省', 20, '445700', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41059, 2708, 513426, '会东县', 3, 292, '凉山彝族自治州', 24, '四川省', 20, '201800', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41061, 2058, 422823, '巴东县', 3, 217, '恩施土家族苗族自治州', 18, '湖北省', 20, '444300', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41063, 321, 540200, '日喀则市', 2, 27, '西藏自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41065, 2716, 513434, '越西县', 3, 292, '凉山彝族自治州', 24, '四川省', 20, '616650', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41067, 2059, 422825, '宣恩县', 3, 217, '恩施土家族苗族自治州', 18, '湖北省', 20, '445500', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41069, 2981, 540232, '仲巴县', 3, 321, '日喀则市', 27, '西藏自治区', 20, '858800', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41071, 2717, 513435, '甘洛县', 3, 292, '凉山彝族自治州', 24, '四川省', 20, '616850', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41073, 2060, 422826, '咸丰县', 3, 217, '恩施土家族苗族自治州', 18, '湖北省', 20, '445600', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41075, 2975, 540226, '昂仁县', 3, 321, '日喀则市', 27, '西藏自治区', 20, '858500', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41077, 2718, 513436, '美姑县', 3, 292, '凉山彝族自治州', 24, '四川省', 20, '616450', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41079, 205, 420100, '武汉市', 2, 18, '湖北省', NULL, NULL, 20, '0', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41081, 2976, 540227, '谢通门县', 3, 321, '日喀则市', 27, '西藏自治区', 20, '858900', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41083, 2705, 513423, '盐源县', 3, 292, '凉山彝族自治州', 24, '四川省', 20, '200000', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41085, 1975, 420116, '黄陂区', 3, 205, '武汉市', 18, '湖北省', 20, '432200', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41087, 2712, 513430, '金阳县', 3, 292, '凉山彝族自治州', 24, '四川省', 20, '201400', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41089, 2985, 540236, '萨嘎县', 3, 321, '日喀则市', 27, '西藏自治区', 20, '857800', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41091, 1976, 420117, '新洲区', 3, 205, '武汉市', 18, '湖北省', 20, '431400', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41093, 2706, 513424, '德昌县', 3, 292, '凉山彝族自治州', 24, '四川省', 20, '201300', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41095, 2970, 540221, '南木林县', 3, 321, '日喀则市', 27, '西藏自治区', 20, '857100', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41097, 1973, 420114, '蔡甸区', 3, 205, '武汉市', 18, '湖北省', 20, '430100', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41099, 3434, 540202, '桑珠孜区', 3, 321, '日喀则市', 27, '西藏自治区', 20, '540202', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41101, 2709, 513427, '宁南县', 3, 292, '凉山彝族自治州', 24, '四川省', 20, '201900', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41103, 1972, 420113, '汉南区', 3, 205, '武汉市', 18, '湖北省', 20, '430090', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41105, 2974, 540225, '拉孜县', 3, 321, '日喀则市', 27, '西藏自治区', 20, '858100', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41107, 291, 513300, '甘孜藏族自治州', 2, 24, '四川省', NULL, NULL, 20, '0', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41109, 1968, 420106, '武昌区', 3, 205, '武汉市', 18, '湖北省', 20, '430061', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41111, 2692, 513328, '甘孜县', 3, 291, '甘孜藏族自治州', 24, '四川省', 20, '626700', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41113, 2978, 540229, '仁布县', 3, 321, '日喀则市', 27, '西藏自治区', 20, '857200', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41115, 1974, 420115, '江夏区', 3, 205, '武汉市', 18, '湖北省', 20, '430200', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41117, 2696, 513332, '石渠县', 3, 291, '甘孜藏族自治州', 24, '四川省', 20, '200000', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41119, 2973, 540224, '萨迦县', 3, 321, '日喀则市', 27, '西藏自治区', 20, '857800', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41121, 1971, 420112, '东西湖区', 3, 205, '武汉市', 18, '湖北省', 20, '430040', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41123, 1966, 420104, '硚口区', 3, 205, '武汉市', 18, '湖北省', 20, '430033', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41125, 2701, 513337, '稻城县', 3, 291, '甘孜藏族自治州', 24, '四川省', 20, '200000', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41127, 2983, 540234, '吉隆县', 3, 321, '日喀则市', 27, '西藏自治区', 20, '858700', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41129, 1967, 420105, '汉阳区', 3, 205, '武汉市', 18, '湖北省', 20, '430050', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41131, 2693, 513329, '新龙县', 3, 291, '甘孜藏族自治州', 24, '四川省', 20, '626800', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41133, 2977, 540228, '白朗县', 3, 321, '日喀则市', 27, '西藏自治区', 20, '857300', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41135, 2694, 513330, '德格县', 3, 291, '甘孜藏族自治州', 24, '四川省', 20, '627250', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41137, 1965, 420103, '江汉区', 3, 205, '武汉市', 18, '湖北省', 20, '430021', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41139, 2971, 540222, '江孜县', 3, 321, '日喀则市', 27, '西藏自治区', 20, '857400', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41141, 1964, 420102, '江岸区', 3, 205, '武汉市', 18, '湖北省', 20, '430014', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41143, 2689, 513325, '雅江县', 3, 291, '甘孜藏族自治州', 24, '四川省', 20, '627450', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41145, 2972, 540223, '定日县', 3, 321, '日喀则市', 27, '西藏自治区', 20, '858200', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41147, 1969, 420107, '青山区', 3, 205, '武汉市', 18, '湖北省', 20, '014030', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41149, 2695, 513331, '白玉县', 3, 291, '甘孜藏族自治州', 24, '四川省', 20, '200000', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41151, 2984, 540235, '聂拉木县', 3, 321, '日喀则市', 27, '西藏自治区', 20, '858300', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41153, 1970, 420111, '洪山区', 3, 205, '武汉市', 18, '湖北省', 20, '430070', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41155, 2690, 513326, '道孚县', 3, 291, '甘孜藏族自治州', 24, '四川省', 20, '626400', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41157, 2982, 540233, '亚东县', 3, 321, '日喀则市', 27, '西藏自治区', 20, '857600', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41159, 2699, 513335, '巴塘县', 3, 291, '甘孜藏族自治州', 24, '四川省', 20, '200120', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41161, 2063, 429004, '仙桃市', 2, 18, '湖北省', NULL, NULL, 20, '433000', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41163, 2986, 540237, '岗巴县', 3, 321, '日喀则市', 27, '西藏自治区', 20, '857700', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41165, 2691, 513327, '炉霍县', 3, 291, '甘孜藏族自治州', 24, '四川省', 20, '626500', '2020-08-04 00:58:28', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41167, 213, 421000, '荆州市', 2, 18, '湖北省', NULL, NULL, 20, '0', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41169, 2979, 540230, '康马县', 3, 321, '日喀则市', 27, '西藏自治区', 20, '857500', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41171, 2685, 513301, '康定市', 3, 291, '甘孜藏族自治州', 24, '四川省', 20, '626000', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41173, 2033, 421024, '江陵县', 3, 213, '荆州市', 18, '湖北省', 20, '434101', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41175, 2980, 540231, '定结县', 3, 321, '日喀则市', 27, '西藏自治区', 20, '857900', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41177, 2698, 513334, '理塘县', 3, 291, '甘孜藏族自治州', 24, '四川省', 20, '200000', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41179, 320, 540500, '山南市', 2, 27, '西藏自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41181, 2032, 421023, '监利县', 3, 213, '荆州市', 18, '湖北省', 20, '433300', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41183, 2700, 513336, '乡城县', 3, 291, '甘孜藏族自治州', 24, '四川省', 20, '200000', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41185, 2035, 421083, '洪湖市', 3, 213, '荆州市', 18, '湖北省', 20, '433200', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41187, 2960, 540523, '桑日县', 3, 320, '山南市', 27, '西藏自治区', 20, '856200', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41189, 2688, 513324, '九龙县', 3, 291, '甘孜藏族自治州', 24, '四川省', 20, '626200', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41191, 2034, 421081, '石首市', 3, 213, '荆州市', 18, '湖北省', 20, '434400', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41193, 2958, 540521, '扎囊县', 3, 320, '山南市', 27, '西藏自治区', 20, '850800', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41195, 2702, 513338, '得荣县', 3, 291, '甘孜藏族自治州', 24, '四川省', 20, '200000', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41197, 2036, 421087, '松滋市', 3, 213, '荆州市', 18, '湖北省', 20, '434200', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41199, 2957, 540502, '乃东区', 3, 320, '山南市', 27, '西藏自治区', 20, '856100', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41201, 2697, 513333, '色达县', 3, 291, '甘孜藏族自治州', 24, '四川省', 20, '201100', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41203, 2965, 540528, '加查县', 3, 320, '山南市', 27, '西藏自治区', 20, '856400', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41205, 2029, 421002, '沙市区', 3, 213, '荆州市', 18, '湖北省', 20, '434000', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41207, 2031, 421022, '公安县', 3, 213, '荆州市', 18, '湖北省', 20, '434300', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41209, 2961, 540524, '琼结县', 3, 320, '山南市', 27, '西藏自治区', 20, '856800', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41211, 2687, 513323, '丹巴县', 3, 291, '甘孜藏族自治州', 24, '四川省', 20, '626300', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41213, 2030, 421003, '荆州区', 3, 213, '荆州市', 18, '湖北省', 20, '434020', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41215, 2959, 540522, '贡嘎县', 3, 320, '山南市', 27, '西藏自治区', 20, '850700', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41217, 2686, 513322, '泸定县', 3, 291, '甘孜藏族自治州', 24, '四川省', 20, '626100', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41219, 216, 421300, '随州市', 2, 18, '湖北省', NULL, NULL, 20, '0', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41221, 2968, 540531, '浪卡子县', 3, 320, '山南市', 27, '西藏自治区', 20, '851000', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41223, 17, 410000, '河南省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41225, 189, 410300, '洛阳市', 2, 17, '河南省', NULL, NULL, 20, '0', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41227, 2962, 540525, '曲松县', 3, 320, '山南市', 27, '西藏自治区', 20, '856300', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41229, 2053, 421303, '曾都区', 3, 216, '随州市', 18, '湖北省', 20, '441300', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41231, 2963, 540526, '措美县', 3, 320, '山南市', 27, '西藏自治区', 20, '856900', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41233, 1832, 410323, '新安县', 3, 189, '洛阳市', 17, '河南省', 20, '471800', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41235, 3407, 421321, '随县', 3, 216, '随州市', 18, '湖北省', 20, '431500', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41237, 1833, 410324, '栾川县', 3, 189, '洛阳市', 17, '河南省', 20, '471500', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41239, 2967, 540530, '错那县', 3, 320, '山南市', 27, '西藏自治区', 20, '856700', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41241, 2054, 421381, '广水市', 3, 216, '随州市', 18, '湖北省', 20, '432700', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41243, 1838, 410329, '伊川县', 3, 189, '洛阳市', 17, '河南省', 20, '471300', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41245, 2066, 429021, '神农架林区', 2, 18, '湖北省', NULL, NULL, 20, '442400', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41247, 2966, 540529, '隆子县', 3, 320, '山南市', 27, '西藏自治区', 20, '856600', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41249, 1829, 410306, '吉利区', 3, 189, '洛阳市', 17, '河南省', 20, '471012', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41251, 2964, 540527, '洛扎县', 3, 320, '山南市', 27, '西藏自治区', 20, '851200', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41253, 1837, 410328, '洛宁县', 3, 189, '洛阳市', 17, '河南省', 20, '471700', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41255, 215, 421200, '咸宁市', 2, 18, '湖北省', NULL, NULL, 20, '0', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41257, 322, 540600, '那曲市', 2, 27, '西藏自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41259, 1839, 410381, '偃师市', 3, 189, '洛阳市', 17, '河南省', 20, '471900', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41261, 2048, 421221, '嘉鱼县', 3, 215, '咸宁市', 18, '湖北省', 20, '437200', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41263, 2991, 540624, '安多县', 3, 322, '那曲市', 27, '西藏自治区', 20, '852600', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41265, 1827, 410304, '瀍河回族区', 3, 189, '洛阳市', 17, '河南省', 20, '471002', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41267, 2990, 540623, '聂荣县', 3, 322, '那曲市', 27, '西藏自治区', 20, '853500', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41269, 2051, 421224, '通山县', 3, 215, '咸宁市', 18, '湖北省', 20, '437600', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41271, 1825, 410302, '老城区', 3, 189, '洛阳市', 17, '河南省', 20, '471002', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41273, 2995, 540628, '巴青县', 3, 322, '那曲市', 27, '西藏自治区', 20, '852100', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41275, 2047, 421202, '咸安区', 3, 215, '咸宁市', 18, '湖北省', 20, '437000', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41277, 1826, 410303, '西工区', 3, 189, '洛阳市', 17, '河南省', 20, '471000', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41279, 2992, 540625, '申扎县', 3, 322, '那曲市', 27, '西藏自治区', 20, '853100', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41281, 2050, 421223, '崇阳县', 3, 215, '咸宁市', 18, '湖北省', 20, '437500', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41283, 1831, 410322, '孟津县', 3, 189, '洛阳市', 17, '河南省', 20, '471100', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41285, 2994, 540627, '班戈县', 3, 322, '那曲市', 27, '西藏自治区', 20, '852500', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41287, 2989, 540622, '比如县', 3, 322, '那曲市', 27, '西藏自治区', 20, '852300', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41289, 1830, 410311, '洛龙区', 3, 189, '洛阳市', 17, '河南省', 20, '471000', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41291, 2052, 421281, '赤壁市', 3, 215, '咸宁市', 18, '湖北省', 20, '437300', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41293, 2993, 540626, '索县', 3, 322, '那曲市', 27, '西藏自治区', 20, '852200', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41295, 2049, 421222, '通城县', 3, 215, '咸宁市', 18, '湖北省', 20, '437400', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41297, 1828, 410305, '涧西区', 3, 189, '洛阳市', 17, '河南省', 20, '471003', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41299, 2988, 540621, '嘉黎县', 3, 322, '那曲市', 27, '西藏自治区', 20, '852400', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41301, 210, 420700, '鄂州市', 2, 18, '湖北省', NULL, NULL, 20, '0', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41303, 1836, 410327, '宜阳县', 3, 189, '洛阳市', 17, '河南省', 20, '471600', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41305, 3437, 540602, '色尼区', 3, 322, '那曲市', 27, '西藏自治区', 20, '540602', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41307, 2015, 420703, '华容区', 3, 210, '鄂州市', 18, '湖北省', 20, '436030', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41309, 2996, 540629, '尼玛县', 3, 322, '那曲市', 27, '西藏自治区', 20, '853200', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41311, 1835, 410326, '汝阳县', 3, 189, '洛阳市', 17, '河南省', 20, '471200', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41313, 2016, 420704, '鄂城区', 3, 210, '鄂州市', 18, '湖北省', 20, '436000', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41315, 3438, 540630, '双湖县', 3, 322, '那曲市', 27, '西藏自治区', 20, '540630', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41317, 1834, 410325, '嵩县', 3, 189, '洛阳市', 17, '河南省', 20, '471400', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41319, 2014, 420702, '梁子湖区', 3, 210, '鄂州市', 18, '湖北省', 20, '436064', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41321, 319, 540300, '昌都市', 2, 27, '西藏自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41323, 199, 411200, '三门峡市', 2, 17, '河南省', NULL, NULL, 20, '0', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41325, 206, 420200, '黄石市', 2, 18, '湖北省', NULL, NULL, 20, '0', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41327, 2950, 540324, '丁青县', 3, 319, '昌都市', 27, '西藏自治区', 20, '855700', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41329, 1906, 411202, '湖滨区', 3, 199, '三门峡市', 17, '河南省', 20, '472000', '2020-08-04 00:58:29', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41331, 1980, 420205, '铁山区', 3, 206, '黄石市', 18, '湖北省', 20, '435006', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41333, 3435, 540302, '卡若区', 3, 319, '昌都市', 27, '西藏自治区', 20, '540302', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41335, 1909, 411224, '卢氏县', 3, 199, '三门峡市', 17, '河南省', 20, '472200', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41337, 1978, 420203, '西塞山区', 3, 206, '黄石市', 18, '湖北省', 20, '435001', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41339, 2947, 540321, '江达县', 3, 319, '昌都市', 27, '西藏自治区', 20, '854100', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41341, 1907, 411221, '渑池县', 3, 199, '三门峡市', 17, '河南省', 20, '472400', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41343, 2949, 540323, '类乌齐县', 3, 319, '昌都市', 27, '西藏自治区', 20, '855600', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41345, 1979, 420204, '下陆区', 3, 206, '黄石市', 18, '湖北省', 20, '435005', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41347, 1911, 411282, '灵宝市', 3, 199, '三门峡市', 17, '河南省', 20, '472500', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41349, 2956, 540330, '边坝县', 3, 319, '昌都市', 27, '西藏自治区', 20, '855500', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41351, 1982, 420281, '大冶市', 3, 206, '黄石市', 18, '湖北省', 20, '435100', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41353, 2948, 540322, '贡觉县', 3, 319, '昌都市', 27, '西藏自治区', 20, '854200', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41355, 3404, 411203, '陕州区', 3, 199, '三门峡市', 17, '河南省', 20, '472100', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41357, 1910, 411281, '义马市', 3, 199, '三门峡市', 17, '河南省', 20, '472300', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41359, 1981, 420222, '阳新县', 3, 206, '黄石市', 18, '湖北省', 20, '435200', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41361, 2955, 540329, '洛隆县', 3, 319, '昌都市', 27, '西藏自治区', 20, '855400', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41363, 1977, 420202, '黄石港区', 3, 206, '黄石市', 18, '湖北省', 20, '435000', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41365, 198, 411100, '漯河市', 2, 17, '河南省', NULL, NULL, 20, '0', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41367, 2951, 540325, '察雅县', 3, 319, '昌都市', 27, '西藏自治区', 20, '854300', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41369, 28, 610000, '陕西省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41371, 1903, 411104, '召陵区', 3, 198, '漯河市', 17, '河南省', 20, '462300', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41373, 2952, 540326, '八宿县', 3, 319, '昌都市', 27, '西藏自治区', 20, '854600', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41375, 334, 611000, '商洛市', 2, 28, '陕西省', NULL, NULL, 20, '0', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41377, 1905, 411122, '临颍县', 3, 198, '漯河市', 17, '河南省', 20, '462600', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41379, 2953, 540327, '左贡县', 3, 319, '昌都市', 27, '西藏自治区', 20, '854400', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41381, 3116, 611022, '丹凤县', 3, 334, '商洛市', 28, '陕西省', 20, '726200', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41383, 1901, 411102, '源汇区', 3, 198, '漯河市', 17, '河南省', 20, '462000', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41385, 2954, 540328, '芒康县', 3, 319, '昌都市', 27, '西藏自治区', 20, '854500', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41387, 3119, 611025, '镇安县', 3, 334, '商洛市', 28, '陕西省', 20, '711500', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41389, 1902, 411103, '郾城区', 3, 198, '漯河市', 17, '河南省', 20, '462300', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41391, 318, 540100, '拉萨市', 2, 27, '西藏自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41393, 3120, 611026, '柞水县', 3, 334, '商洛市', 28, '陕西省', 20, '674100', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41395, 1904, 411121, '舞阳县', 3, 198, '漯河市', 17, '河南省', 20, '462400', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41397, 3117, 611023, '商南县', 3, 334, '商洛市', 28, '陕西省', 20, '726300', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41399, 197, 411000, '许昌市', 2, 17, '河南省', NULL, NULL, 20, '0', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41401, 2940, 540122, '当雄县', 3, 318, '拉萨市', 27, '西藏自治区', 20, '851500', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41403, 3115, 611021, '洛南县', 3, 334, '商洛市', 28, '陕西省', 20, '726100', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41405, 3373, 411003, '建安区', 3, 197, '许昌市', 17, '河南省', 20, '461000', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41407, 2939, 540121, '林周县', 3, 318, '拉萨市', 27, '西藏自治区', 20, '852000', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41409, 3114, 611002, '商州区', 3, 334, '商洛市', 28, '陕西省', 20, '726000', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41411, 2941, 540123, '尼木县', 3, 318, '拉萨市', 27, '西藏自治区', 20, '851300', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41413, 3118, 611024, '山阳县', 3, 334, '商洛市', 28, '陕西省', 20, '726400', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41415, 1895, 411002, '魏都区', 3, 197, '许昌市', 17, '河南省', 20, '461000', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41417, 2944, 540104, '达孜区', 3, 318, '拉萨市', 27, '西藏自治区', 20, '850100', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41419, 326, 610200, '铜川市', 2, 28, '陕西省', NULL, NULL, 20, '0', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41421, 1900, 411082, '长葛市', 3, 197, '许昌市', 17, '河南省', 20, '461500', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41423, 2945, 540127, '墨竹工卡县', 3, 318, '拉萨市', 27, '西藏自治区', 20, '850200', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41425, 3028, 610222, '宜君县', 3, 326, '铜川市', 28, '陕西省', 20, '727200', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41427, 1899, 411081, '禹州市', 3, 197, '许昌市', 17, '河南省', 20, '461670', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41429, 1897, 411024, '鄢陵县', 3, 197, '许昌市', 17, '河南省', 20, '461200', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41431, 3025, 610202, '王益区', 3, 326, '铜川市', 28, '陕西省', 20, '727000', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41433, 2943, 540103, '堆龙德庆区', 3, 318, '拉萨市', 27, '西藏自治区', 20, '851400', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41435, 1898, 411025, '襄城县', 3, 197, '许昌市', 17, '河南省', 20, '461700', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41437, 3027, 610204, '耀州区', 3, 326, '铜川市', 28, '陕西省', 20, '727100', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41439, 2942, 540124, '曲水县', 3, 318, '拉萨市', 27, '西藏自治区', 20, '850600', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41441, 200, 411300, '南阳市', 2, 17, '河南省', NULL, NULL, 20, '0', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41443, 324, 540400, '林芝市', 2, 27, '西藏自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41445, 3026, 610203, '印台区', 3, 326, '铜川市', 28, '陕西省', 20, '727007', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41447, 3008, 540424, '波密县', 3, 324, '林芝市', 27, '西藏自治区', 20, '855200', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41449, 1916, 411323, '西峡县', 3, 200, '南阳市', 17, '河南省', 20, '474550', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41451, 325, 610100, '西安市', 2, 28, '陕西省', NULL, NULL, 20, '0', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41453, 3005, 540421, '工布江达县', 3, 324, '林芝市', 27, '西藏自治区', 20, '850300', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41455, 1920, 411327, '社旗县', 3, 200, '南阳市', 17, '河南省', 20, '473300', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41457, 3018, 610115, '临潼区', 3, 325, '西安市', 28, '陕西省', 20, '710600', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41459, 3007, 540423, '墨脱县', 3, 324, '林芝市', 27, '西藏自治区', 20, '855300', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41461, 1923, 411330, '桐柏县', 3, 200, '南阳市', 17, '河南省', 20, '474750', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41463, 3023, 610117, '高陵区', 3, 325, '西安市', 28, '陕西省', 20, '710200', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41465, 1913, 411303, '卧龙区', 3, 200, '南阳市', 17, '河南省', 20, '473003', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41467, 3020, 610122, '蓝田县', 3, 325, '西安市', 28, '陕西省', 20, '710500', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41469, 3436, 540402, '巴宜区', 3, 324, '林芝市', 27, '西藏自治区', 20, '540402', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41471, 1914, 411321, '南召县', 3, 200, '南阳市', 17, '河南省', 20, '474650', '2020-08-04 00:58:30', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41473, 3439, 610118, '鄠邑区', 3, 325, '西安市', 28, '陕西省', 20, '610118', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41475, 1921, 411328, '唐河县', 3, 200, '南阳市', 17, '河南省', 20, '473400', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41477, 3006, 540422, '米林县', 3, 324, '林芝市', 27, '西藏自治区', 20, '860500', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41479, 1915, 411322, '方城县', 3, 200, '南阳市', 17, '河南省', 20, '473200', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41481, 3013, 610104, '莲湖区', 3, 325, '西安市', 28, '陕西省', 20, '710003', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41483, 3009, 540425, '察隅县', 3, 324, '林芝市', 27, '西藏自治区', 20, '855100', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41485, 1912, 411302, '宛城区', 3, 200, '南阳市', 17, '河南省', 20, '473001', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41487, 3014, 610111, '灞桥区', 3, 325, '西安市', 28, '陕西省', 20, '710038', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41489, 3010, 540426, '朗县', 3, 324, '林芝市', 27, '西藏自治区', 20, '856500', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41491, 3011, 610102, '新城区', 3, 325, '西安市', 28, '陕西省', 20, '010030', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41493, 1922, 411329, '新野县', 3, 200, '南阳市', 17, '河南省', 20, '473500', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41495, 323, 542500, '阿里地区', 2, 27, '西藏自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41497, 3012, 610103, '碑林区', 3, 325, '西安市', 28, '陕西省', 20, '710001', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41499, 1917, 411324, '镇平县', 3, 200, '南阳市', 17, '河南省', 20, '474250', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41501, 3002, 542526, '改则县', 3, 323, '阿里地区', 27, '西藏自治区', 20, '859200', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41503, 3021, 610124, '周至县', 3, 325, '西安市', 28, '陕西省', 20, '710400', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41505, 2998, 542522, '札达县', 3, 323, '阿里地区', 27, '西藏自治区', 20, '859600', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41507, 1919, 411326, '淅川县', 3, 200, '南阳市', 17, '河南省', 20, '474450', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41509, 3016, 610113, '雁塔区', 3, 325, '西安市', 28, '陕西省', 20, '710061', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41511, 3003, 542527, '措勤县', 3, 323, '阿里地区', 27, '西藏自治区', 20, '859300', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41513, 1924, 411381, '邓州市', 3, 200, '南阳市', 17, '河南省', 20, '474150', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41515, 3017, 610114, '阎良区', 3, 325, '西安市', 28, '陕西省', 20, '710087', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41517, 1918, 411325, '内乡县', 3, 200, '南阳市', 17, '河南省', 20, '474350', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41519, 2997, 542521, '普兰县', 3, 323, '阿里地区', 27, '西藏自治区', 20, '116200', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41521, 3015, 610112, '未央区', 3, 325, '西安市', 28, '陕西省', 20, '710014', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41523, 331, 610700, '汉中市', 2, 28, '陕西省', NULL, NULL, 20, '0', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41525, 202, 411500, '信阳市', 2, 17, '河南省', NULL, NULL, 20, '0', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41527, 2999, 542523, '噶尔县', 3, 323, '阿里地区', 27, '西藏自治区', 20, '859400', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41529, 3001, 542525, '革吉县', 3, 323, '阿里地区', 27, '西藏自治区', 20, '859100', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41531, 1941, 411526, '潢川县', 3, 202, '信阳市', 17, '河南省', 20, '465150', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41533, 3090, 610730, '佛坪县', 3, 331, '汉中市', 28, '陕西省', 20, '723400', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41535, 3000, 542524, '日土县', 3, 323, '阿里地区', 27, '西藏自治区', 20, '859700', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41537, 1942, 411527, '淮滨县', 3, 202, '信阳市', 17, '河南省', 20, '464400', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41539, 3083, 610723, '洋县', 3, 331, '汉中市', 28, '陕西省', 20, '723300', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41541, 9, 230000, '黑龙江省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41543, 1936, 411521, '罗山县', 3, 202, '信阳市', 17, '河南省', 20, '464200', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41545, 3089, 610729, '留坝县', 3, 331, '汉中市', 28, '陕西省', 20, '724100', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41547, 103, 230900, '七台河市', 2, 9, '黑龙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41549, 3087, 610727, '略阳县', 3, 331, '汉中市', 28, '陕西省', 20, '724300', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41551, 1937, 411522, '光山县', 3, 202, '信阳市', 17, '河南省', 20, '465450', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41553, 3084, 610724, '西乡县', 3, 331, '汉中市', 28, '陕西省', 20, '723500', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41555, 1938, 411523, '新县', 3, 202, '信阳市', 17, '河南省', 20, '465550', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41557, 1086, 230903, '桃山区', 3, 103, '七台河市', 9, '黑龙江省', 20, '154600', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41559, 3086, 610726, '宁强县', 3, 331, '汉中市', 28, '陕西省', 20, '724400', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41561, 1934, 411502, '浉河区', 3, 202, '信阳市', 17, '河南省', 20, '464000', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41563, 1088, 230921, '勃利县', 3, 103, '七台河市', 9, '黑龙江省', 20, '154500', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41565, 1940, 411525, '固始县', 3, 202, '信阳市', 17, '河南省', 20, '465250', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41567, 3085, 610725, '勉县', 3, 331, '汉中市', 28, '陕西省', 20, '724200', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41569, 1939, 411524, '商城县', 3, 202, '信阳市', 17, '河南省', 20, '465350', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41571, 1085, 230902, '新兴区', 3, 103, '七台河市', 9, '黑龙江省', 20, '154604', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41573, 3081, 610703, '南郑区', 3, 331, '汉中市', 28, '陕西省', 20, '723100', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41575, 1943, 411528, '息县', 3, 202, '信阳市', 17, '河南省', 20, '464300', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41577, 3080, 610702, '汉台区', 3, 331, '汉中市', 28, '陕西省', 20, '723000', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41579, 1087, 230904, '茄子河区', 3, 103, '七台河市', 9, '黑龙江省', 20, '154622', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41581, 1935, 411503, '平桥区', 3, 202, '信阳市', 17, '河南省', 20, '464100', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41583, 3082, 610722, '城固县', 3, 331, '汉中市', 28, '陕西省', 20, '723200', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41585, 98, 230400, '鹤岗市', 2, 9, '黑龙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41587, 195, 419001, '济源市', 2, 17, '河南省', NULL, NULL, 20, '0', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41589, 3088, 610728, '镇巴县', 3, 331, '汉中市', 28, '陕西省', 20, '723600', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41591, 1040, 230422, '绥滨县', 3, 98, '鹤岗市', 9, '黑龙江省', 20, '156200', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41593, 204, 411700, '驻马店市', 2, 17, '河南省', NULL, NULL, 20, '0', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41595, 332, 610800, '榆林市', 2, 28, '陕西省', NULL, NULL, 20, '0', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41597, 1956, 411722, '上蔡县', 3, 204, '驻马店市', 17, '河南省', 20, '463800', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41599, 1034, 230403, '工农区', 3, 98, '鹤岗市', 9, '黑龙江省', 20, '154101', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41601, 3092, 610802, '榆阳区', 3, 332, '榆林市', 28, '陕西省', 20, '719000', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41603, 1038, 230407, '兴山区', 3, 98, '鹤岗市', 9, '黑龙江省', 20, '154105', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41605, 1955, 411721, '西平县', 3, 204, '驻马店市', 17, '河南省', 20, '463900', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41607, 3099, 610827, '米脂县', 3, 332, '榆林市', 28, '陕西省', 20, '718100', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41609, 1033, 230402, '向阳区', 3, 98, '鹤岗市', 9, '黑龙江省', 20, '154100', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41611, 1963, 411729, '新蔡县', 3, 204, '驻马店市', 17, '河南省', 20, '463500', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41613, 3100, 610828, '佳县', 3, 332, '榆林市', 28, '陕西省', 20, '719200', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41615, 1035, 230404, '南山区', 3, 98, '鹤岗市', 9, '黑龙江省', 20, '154104', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41617, 1960, 411726, '泌阳县', 3, 204, '驻马店市', 17, '河南省', 20, '463700', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41619, 3094, 610822, '府谷县', 3, 332, '榆林市', 28, '陕西省', 20, '719400', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41621, 1039, 230421, '萝北县', 3, 98, '鹤岗市', 9, '黑龙江省', 20, '154200', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41623, 1954, 411702, '驿城区', 3, 204, '驻马店市', 17, '河南省', 20, '463000', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41625, 3095, 610803, '横山区', 3, 332, '榆林市', 28, '陕西省', 20, '719100', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41627, 1036, 230405, '兴安区', 3, 98, '鹤岗市', 9, '黑龙江省', 20, '154102', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41629, 1959, 411725, '确山县', 3, 204, '驻马店市', 17, '河南省', 20, '463200', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41631, 3093, 610881, '神木市', 3, 332, '榆林市', 28, '陕西省', 20, '719300', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41633, 1037, 230406, '东山区', 3, 98, '鹤岗市', 9, '黑龙江省', 20, '154106', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41635, 1958, 411724, '正阳县', 3, 204, '驻马店市', 17, '河南省', 20, '463600', '2020-08-04 00:58:31', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41637, 3096, 610824, '靖边县', 3, 332, '榆林市', 28, '陕西省', 20, '718500', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41639, 101, 230700, '伊春市', 2, 9, '黑龙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41641, 1962, 411728, '遂平县', 3, 204, '驻马店市', 17, '河南省', 20, '463100', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41643, 3103, 610831, '子洲县', 3, 332, '榆林市', 28, '陕西省', 20, '718400', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41645, 1961, 411727, '汝南县', 3, 204, '驻马店市', 17, '河南省', 20, '463300', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41647, 1073, 230722, '嘉荫县', 3, 101, '伊春市', 9, '黑龙江省', 20, '153200', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41649, 3102, 610830, '清涧县', 3, 332, '榆林市', 28, '陕西省', 20, '718300', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41651, 1957, 411723, '平舆县', 3, 204, '驻马店市', 17, '河南省', 20, '463400', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41653, 1059, 230726, '南岔县', 3, 101, '伊春市', 9, '黑龙江省', 20, '153100', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41655, 3101, 610829, '吴堡县', 3, 332, '榆林市', 28, '陕西省', 20, '718200', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41657, 196, 410900, '濮阳市', 2, 17, '河南省', NULL, NULL, 20, '0', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41659, 3470, 230718, '乌翠区', 3, 101, '伊春市', 9, '黑龙江省', 20, NULL, '2020-08-04 00:58:32', '2020-08-06 22:39:19', 0);
INSERT INTO `t_areas` VALUES (41661, 3098, 610826, '绥德县', 3, 332, '榆林市', 28, '陕西省', 20, '718000', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41663, 1893, 410927, '台前县', 3, 196, '濮阳市', 17, '河南省', 20, '457600', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41665, 3097, 610825, '定边县', 3, 332, '榆林市', 28, '陕西省', 20, '718600', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41667, 3471, 230717, '伊美区', 3, 101, '伊春市', 9, '黑龙江省', 20, NULL, '2020-08-04 00:58:32', '2020-08-04 01:20:07', 0);
INSERT INTO `t_areas` VALUES (41669, 1891, 410923, '南乐县', 3, 196, '濮阳市', 17, '河南省', 20, '457400', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41671, 1060, 230719, '友好区', 3, 101, '伊春市', 9, '黑龙江省', 20, '153031', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41673, 1892, 410926, '范县', 3, 196, '濮阳市', 17, '河南省', 20, '457500', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41675, 330, 610600, '延安市', 2, 28, '陕西省', NULL, NULL, 20, '0', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41677, 3472, 230751, '金林区', 3, 101, '伊春市', 9, '黑龙江省', 20, NULL, '2020-08-04 00:58:32', '2020-08-06 22:39:19', 0);
INSERT INTO `t_areas` VALUES (41679, 1889, 410902, '华龙区', 3, 196, '濮阳市', 17, '河南省', 20, '457001', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41681, 1890, 410922, '清丰县', 3, 196, '濮阳市', 17, '河南省', 20, '457300', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41683, 1068, 230723, '汤旺县', 3, 101, '伊春市', 9, '黑龙江省', 20, '153037', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41685, 3071, 610603, '安塞区', 3, 330, '延安市', 28, '陕西省', 20, '717400', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41687, 1894, 410928, '濮阳县', 3, 196, '濮阳市', 17, '河南省', 20, '457100', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41689, 3442, 610626, '吴起县', 3, 330, '延安市', 28, '陕西省', 20, '610626', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41691, 3473, 230724, '丰林县', 3, 101, '伊春市', 9, '黑龙江省', 20, NULL, '2020-08-04 00:58:32', '2020-08-06 22:39:19', 0);
INSERT INTO `t_areas` VALUES (41693, 1074, 230781, '铁力市', 3, 101, '伊春市', 9, '黑龙江省', 20, '152500', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41695, 3072, 610625, '志丹县', 3, 330, '延安市', 28, '陕西省', 20, '717500', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41697, 194, 410800, '焦作市', 2, 17, '河南省', NULL, NULL, 20, '0', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41699, 3069, 610622, '延川县', 3, 330, '延安市', 28, '陕西省', 20, '717200', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41701, 3474, 230725, '大箐山县', 3, 101, '伊春市', 9, '黑龙江省', 20, NULL, '2020-08-04 00:58:32', '2020-08-06 22:39:19', 0);
INSERT INTO `t_areas` VALUES (41703, 1887, 410883, '孟州市', 3, 194, '焦作市', 17, '河南省', 20, '454750', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41705, 3067, 610602, '宝塔区', 3, 330, '延安市', 28, '陕西省', 20, '716000', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41707, 107, 232700, '大兴安岭地区', 2, 9, '黑龙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41709, 1885, 410825, '温县', 3, 194, '焦作市', 17, '河南省', 20, '454850', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41711, 3070, 610681, '子长市', 3, 330, '延安市', 28, '陕西省', 20, '717300', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41713, 1117, 232701, '漠河市', 3, 107, '大兴安岭地区', 9, '黑龙江省', 20, '165300', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41715, 3068, 610621, '延长县', 3, 330, '延安市', 28, '陕西省', 20, '717100', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41717, 1886, 410882, '沁阳市', 3, 194, '焦作市', 17, '河南省', 20, '454550', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41719, 1116, 232722, '塔河县', 3, 107, '大兴安岭地区', 9, '黑龙江省', 20, '165200', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41721, 3076, 610629, '洛川县', 3, 330, '延安市', 28, '陕西省', 20, '727400', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41723, 1880, 410804, '马村区', 3, 194, '焦作市', 17, '河南省', 20, '454171', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41725, 1115, 232721, '呼玛县', 3, 107, '大兴安岭地区', 9, '黑龙江省', 20, '165100', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41727, 3079, 610632, '黄陵县', 3, 330, '延安市', 28, '陕西省', 20, '727300', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41729, 1884, 410823, '武陟县', 3, 194, '焦作市', 17, '河南省', 20, '454950', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41731, 1118, 232718, '加格达奇区', 3, 107, '大兴安岭地区', 9, '黑龙江省', 20, '165000', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41733, 3077, 610630, '宜川县', 3, 330, '延安市', 28, '陕西省', 20, '716200', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41735, 1883, 410822, '博爱县', 3, 194, '焦作市', 17, '河南省', 20, '454450', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41737, 106, 231200, '绥化市', 2, 9, '黑龙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41739, 3074, 610627, '甘泉县', 3, 330, '延安市', 28, '陕西省', 20, '716100', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41741, 1111, 231226, '绥棱县', 3, 106, '绥化市', 9, '黑龙江省', 20, '152200', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41743, 1882, 410821, '修武县', 3, 194, '焦作市', 17, '河南省', 20, '454350', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41745, 3075, 610628, '富县', 3, 330, '延安市', 28, '陕西省', 20, '727500', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41747, 1878, 410802, '解放区', 3, 194, '焦作市', 17, '河南省', 20, '454000', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41749, 1114, 231283, '海伦市', 3, 106, '绥化市', 9, '黑龙江省', 20, '152300', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41751, 3078, 610631, '黄龙县', 3, 330, '延安市', 28, '陕西省', 20, '715700', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41753, 1109, 231224, '庆安县', 3, 106, '绥化市', 9, '黑龙江省', 20, '152400', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41755, 1881, 410811, '山阳区', 3, 194, '焦作市', 17, '河南省', 20, '454002', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41757, 327, 610300, '宝鸡市', 2, 28, '陕西省', NULL, NULL, 20, '0', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41759, 1106, 231221, '望奎县', 3, 106, '绥化市', 9, '黑龙江省', 20, '152100', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41761, 1879, 410803, '中站区', 3, 194, '焦作市', 17, '河南省', 20, '454191', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41763, 3039, 610329, '麟游县', 3, 327, '宝鸡市', 28, '陕西省', 20, '721500', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41765, 1105, 231202, '北林区', 3, 106, '绥化市', 9, '黑龙江省', 20, '152000', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41767, 187, 410100, '郑州市', 2, 17, '河南省', NULL, NULL, 20, '0', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41769, 3037, 610327, '陇县', 3, 327, '宝鸡市', 28, '陕西省', 20, '721200', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41771, 1108, 231223, '青冈县', 3, 106, '绥化市', 9, '黑龙江省', 20, '151600', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41773, 1809, 410185, '登封市', 3, 187, '郑州市', 17, '河南省', 20, '450000', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41775, 3038, 610328, '千阳县', 3, 327, '宝鸡市', 28, '陕西省', 20, '721100', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41777, 1107, 231222, '兰西县', 3, 106, '绥化市', 9, '黑龙江省', 20, '151500', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41779, 1799, 410102, '中原区', 3, 187, '郑州市', 17, '河南省', 20, '450000', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41781, 3031, 610303, '金台区', 3, 327, '宝鸡市', 28, '陕西省', 20, '721000', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41783, 1110, 231225, '明水县', 3, 106, '绥化市', 9, '黑龙江省', 20, '151700', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41785, 1807, 410183, '新密市', 3, 187, '郑州市', 17, '河南省', 20, '450000', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41787, 3040, 610330, '凤县', 3, 327, '宝鸡市', 28, '陕西省', 20, '721700', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41789, 1113, 231282, '肇东市', 3, 106, '绥化市', 9, '黑龙江省', 20, '151100', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41791, 1808, 410184, '新郑市', 3, 187, '郑州市', 17, '河南省', 20, '450000', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41793, 3034, 610323, '岐山县', 3, 327, '宝鸡市', 28, '陕西省', 20, '722400', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41795, 1112, 231281, '安达市', 3, 106, '绥化市', 9, '黑龙江省', 20, '151400', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41797, 1805, 410181, '巩义市', 3, 187, '郑州市', 17, '河南省', 20, '450000', '2020-08-04 00:58:32', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41799, 95, 230100, '哈尔滨市', 2, 9, '黑龙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41801, 3030, 610302, '渭滨区', 3, 327, '宝鸡市', 28, '陕西省', 20, '721000', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41803, 1806, 410182, '荥阳市', 3, 187, '郑州市', 17, '河南省', 20, '450000', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41805, 1000, 230126, '巴彦县', 3, 95, '哈尔滨市', 9, '黑龙江省', 20, '151800', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41807, 3041, 610331, '太白县', 3, 327, '宝鸡市', 28, '陕西省', 20, '721600', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41809, 1803, 410106, '上街区', 3, 187, '郑州市', 17, '河南省', 20, '450000', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41811, 997, 230123, '依兰县', 3, 95, '哈尔滨市', 9, '黑龙江省', 20, '154800', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41813, 3032, 610304, '陈仓区', 3, 327, '宝鸡市', 28, '陕西省', 20, '721300', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41815, 1800, 410103, '二七区', 3, 187, '郑州市', 17, '河南省', 20, '450000', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41817, 1002, 230128, '通河县', 3, 95, '哈尔滨市', 9, '黑龙江省', 20, '150900', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41819, 3033, 610322, '凤翔县', 3, 327, '宝鸡市', 28, '陕西省', 20, '721400', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41821, 3035, 610324, '扶风县', 3, 327, '宝鸡市', 28, '陕西省', 20, '722200', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41823, 1001, 230127, '木兰县', 3, 95, '哈尔滨市', 9, '黑龙江省', 20, '151900', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41825, 1802, 410105, '金水区', 3, 187, '郑州市', 17, '河南省', 20, '450000', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41827, 3036, 610326, '眉县', 3, 327, '宝鸡市', 28, '陕西省', 20, '722300', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41829, 999, 230125, '宾县', 3, 95, '哈尔滨市', 9, '黑龙江省', 20, '150400', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41831, 1811, 410108, '惠济区', 3, 187, '郑州市', 17, '河南省', 20, '450000', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41833, 329, 610500, '渭南市', 2, 28, '陕西省', NULL, NULL, 20, '0', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41835, 1804, 410122, '中牟县', 3, 187, '郑州市', 17, '河南省', 20, '450000', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41837, 998, 230124, '方正县', 3, 95, '哈尔滨市', 9, '黑龙江省', 20, '150800', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41839, 3063, 610527, '白水县', 3, 329, '渭南市', 28, '陕西省', 20, '715600', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41841, 994, 230108, '平房区', 3, 95, '哈尔滨市', 9, '黑龙江省', 20, '150060', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41843, 3065, 610581, '韩城市', 3, 329, '渭南市', 28, '陕西省', 20, '715400', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41845, 1801, 410104, '管城回族区', 3, 187, '郑州市', 17, '河南省', 20, '450000', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41847, 3059, 610523, '大荔县', 3, 329, '渭南市', 28, '陕西省', 20, '715100', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41849, 1003, 230129, '延寿县', 3, 95, '哈尔滨市', 9, '黑龙江省', 20, '150700', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41851, 191, 410500, '安阳市', 2, 17, '河南省', NULL, NULL, 20, '0', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41853, 1857, 410523, '汤阴县', 3, 191, '安阳市', 17, '河南省', 20, '456150', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41855, 1006, 230183, '尚志市', 3, 95, '哈尔滨市', 9, '黑龙江省', 20, '150600', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41857, 3066, 610582, '华阴市', 3, 329, '渭南市', 28, '陕西省', 20, '714200', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41859, 1854, 410505, '殷都区', 3, 191, '安阳市', 17, '河南省', 20, '455004', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41861, 3441, 610503, '华州区', 3, 329, '渭南市', 28, '陕西省', 20, '610503', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41863, 1005, 230113, '双城区', 3, 95, '哈尔滨市', 9, '黑龙江省', 20, '150100', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41865, 1860, 410581, '林州市', 3, 191, '安阳市', 17, '河南省', 20, '456500', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41867, 3058, 610522, '潼关县', 3, 329, '渭南市', 28, '陕西省', 20, '714300', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41869, 1855, 410506, '龙安区', 3, 191, '安阳市', 17, '河南省', 20, '455001', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41871, 992, 230110, '香坊区', 3, 95, '哈尔滨市', 9, '黑龙江省', 20, '150036', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41873, 3061, 610525, '澄城县', 3, 329, '渭南市', 28, '陕西省', 20, '715200', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41875, 989, 230102, '道里区', 3, 95, '哈尔滨市', 9, '黑龙江省', 20, '150010', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41877, 1859, 410527, '内黄县', 3, 191, '安阳市', 17, '河南省', 20, '456350', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41879, 3062, 610526, '蒲城县', 3, 329, '渭南市', 28, '陕西省', 20, '715500', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41881, 1007, 230184, '五常市', 3, 95, '哈尔滨市', 9, '黑龙江省', 20, '150200', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41883, 1853, 410503, '北关区', 3, 191, '安阳市', 17, '河南省', 20, '455001', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41885, 1856, 410522, '安阳县', 3, 191, '安阳市', 17, '河南省', 20, '455000', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41887, 3056, 610502, '临渭区', 3, 329, '渭南市', 28, '陕西省', 20, '714000', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41889, 1004, 230112, '阿城区', 3, 95, '哈尔滨市', 9, '黑龙江省', 20, '150300', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41891, 996, 230111, '呼兰区', 3, 95, '哈尔滨市', 9, '黑龙江省', 20, '150500', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41893, 3060, 610524, '合阳县', 3, 329, '渭南市', 28, '陕西省', 20, '715300', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41895, 1852, 410502, '文峰区', 3, 191, '安阳市', 17, '河南省', 20, '455000', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41897, 995, 230109, '松北区', 3, 95, '哈尔滨市', 9, '黑龙江省', 20, '150028', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41899, 3064, 610528, '富平县', 3, 329, '渭南市', 28, '陕西省', 20, '711700', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41901, 328, 610400, '咸阳市', 2, 28, '陕西省', NULL, NULL, 20, '0', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41903, 1858, 410526, '滑县', 3, 191, '安阳市', 17, '河南省', 20, '456400', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41905, 990, 230103, '南岗区', 3, 95, '哈尔滨市', 9, '黑龙江省', 20, '150006', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41907, 193, 410700, '新乡市', 2, 17, '河南省', NULL, NULL, 20, '0', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41909, 991, 230104, '道外区', 3, 95, '哈尔滨市', 9, '黑龙江省', 20, '150020', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41911, 3053, 610429, '旬邑县', 3, 328, '咸阳市', 28, '陕西省', 20, '711300', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41913, 96, 230200, '齐齐哈尔市', 2, 9, '黑龙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41915, 1877, 410782, '辉县市', 3, 193, '新乡市', 17, '河南省', 20, '453600', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41917, 3440, 610482, '彬州市', 3, 328, '咸阳市', 28, '陕西省', 20, '610482', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41919, 1023, 230281, '讷河市', 3, 96, '齐齐哈尔市', 9, '黑龙江省', 20, '161300', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41921, 3048, 610424, '乾县', 3, 328, '咸阳市', 28, '陕西省', 20, '713300', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41923, 1868, 410704, '凤泉区', 3, 193, '新乡市', 17, '河南省', 20, '453011', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41925, 3050, 610426, '永寿县', 3, 328, '咸阳市', 28, '陕西省', 20, '713400', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41927, 1018, 230225, '甘南县', 3, 96, '齐齐哈尔市', 9, '黑龙江省', 20, '162100', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41929, 1875, 410783, '长垣市', 3, 193, '新乡市', 17, '河南省', 20, '453400', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41931, 3043, 610404, '渭城区', 3, 328, '咸阳市', 28, '陕西省', 20, '712000', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41933, 1020, 230229, '克山县', 3, 96, '齐齐哈尔市', 9, '黑龙江省', 20, '161600', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41935, 1869, 410711, '牧野区', 3, 193, '新乡市', 17, '河南省', 20, '453002', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41937, 3055, 610431, '武功县', 3, 328, '咸阳市', 28, '陕西省', 20, '712200', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41939, 1021, 230230, '克东县', 3, 96, '齐齐哈尔市', 9, '黑龙江省', 20, '164800', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41941, 1867, 410703, '卫滨区', 3, 193, '新乡市', 17, '河南省', 20, '453000', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41943, 1016, 230223, '依安县', 3, 96, '齐齐哈尔市', 9, '黑龙江省', 20, '161500', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41945, 3046, 610423, '泾阳县', 3, 328, '咸阳市', 28, '陕西省', 20, '713700', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41947, 1871, 410724, '获嘉县', 3, 193, '新乡市', 17, '河南省', 20, '453800', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41949, 1019, 230227, '富裕县', 3, 96, '齐齐哈尔市', 9, '黑龙江省', 20, '161200', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41951, 3052, 610428, '长武县', 3, 328, '咸阳市', 28, '陕西省', 20, '713600', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41953, 1870, 410721, '新乡县', 3, 193, '新乡市', 17, '河南省', 20, '453700', '2020-08-04 00:58:33', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41955, 1013, 230207, '碾子山区', 3, 96, '齐齐哈尔市', 9, '黑龙江省', 20, '161046', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41957, 3047, 610481, '兴平市', 3, 328, '咸阳市', 28, '陕西省', 20, '713100', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41959, 1874, 410727, '封丘县', 3, 193, '新乡市', 17, '河南省', 20, '453300', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41961, 3044, 610403, '杨陵区', 3, 328, '咸阳市', 28, '陕西省', 20, '712100', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41963, 1010, 230204, '铁锋区', 3, 96, '齐齐哈尔市', 9, '黑龙江省', 20, '161000', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41965, 1872, 410725, '原阳县', 3, 193, '新乡市', 17, '河南省', 20, '453500', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41967, 3045, 610422, '三原县', 3, 328, '咸阳市', 28, '陕西省', 20, '713800', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41969, 1009, 230203, '建华区', 3, 96, '齐齐哈尔市', 9, '黑龙江省', 20, '161006', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41971, 1873, 410726, '延津县', 3, 193, '新乡市', 17, '河南省', 20, '453200', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41973, 1014, 230208, '梅里斯达斡尔族区', 3, 96, '齐齐哈尔市', 9, '黑龙江省', 20, '161021', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41975, 3054, 610430, '淳化县', 3, 328, '咸阳市', 28, '陕西省', 20, '711200', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41977, 1876, 410781, '卫辉市', 3, 193, '新乡市', 17, '河南省', 20, '453100', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41979, 1015, 230221, '龙江县', 3, 96, '齐齐哈尔市', 9, '黑龙江省', 20, '161100', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41981, 3042, 610402, '秦都区', 3, 328, '咸阳市', 28, '陕西省', 20, '712000', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41983, 1866, 410702, '红旗区', 3, 193, '新乡市', 17, '河南省', 20, '453000', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41985, 1008, 230202, '龙沙区', 3, 96, '齐齐哈尔市', 9, '黑龙江省', 20, '161000', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41987, 3049, 610425, '礼泉县', 3, 328, '咸阳市', 28, '陕西省', 20, '713200', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41989, 192, 410600, '鹤壁市', 2, 17, '河南省', NULL, NULL, 20, '0', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41991, 1012, 230206, '富拉尔基区', 3, 96, '齐齐哈尔市', 9, '黑龙江省', 20, '161041', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41993, 333, 610900, '安康市', 2, 28, '陕西省', NULL, NULL, 20, '0', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41995, 1861, 410602, '鹤山区', 3, 192, '鹤壁市', 17, '河南省', 20, '458010', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41997, 1011, 230205, '昂昂溪区', 3, 96, '齐齐哈尔市', 9, '黑龙江省', 20, '161031', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (41999, 3107, 610923, '宁陕县', 3, 333, '安康市', 28, '陕西省', 20, '711600', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42001, 1022, 230231, '拜泉县', 3, 96, '齐齐哈尔市', 9, '黑龙江省', 20, '164700', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42003, 1862, 410603, '山城区', 3, 192, '鹤壁市', 17, '河南省', 20, '458000', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42005, 3105, 610921, '汉阴县', 3, 333, '安康市', 28, '陕西省', 20, '725100', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42007, 1017, 230224, '泰来县', 3, 96, '齐齐哈尔市', 9, '黑龙江省', 20, '162400', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42009, 1865, 410622, '淇县', 3, 192, '鹤壁市', 17, '河南省', 20, '456750', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42011, 1863, 410611, '淇滨区', 3, 192, '鹤壁市', 17, '河南省', 20, '458000', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42013, 3106, 610922, '石泉县', 3, 333, '安康市', 28, '陕西省', 20, '725200', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42015, 105, 231100, '黑河市', 2, 9, '黑龙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42017, 1864, 410621, '浚县', 3, 192, '鹤壁市', 17, '河南省', 20, '456250', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42019, 3108, 610924, '紫阳县', 3, 333, '安康市', 28, '陕西省', 20, '725300', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42021, 1100, 231183, '嫩江市', 3, 105, '黑河市', 9, '黑龙江省', 20, '161400', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42023, 188, 410200, '开封市', 2, 17, '河南省', NULL, NULL, 20, '0', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42025, 3104, 610902, '汉滨区', 3, 333, '安康市', 28, '陕西省', 20, '725000', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42027, 1099, 231102, '爱辉区', 3, 105, '黑河市', 9, '黑龙江省', 20, '164300', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42029, 1816, 410203, '顺河回族区', 3, 188, '开封市', 17, '河南省', 20, '475000', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42031, 1103, 231181, '北安市', 3, 105, '黑河市', 9, '黑龙江省', 20, '164000', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42033, 3112, 610928, '旬阳县', 3, 333, '安康市', 28, '陕西省', 20, '725700', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42035, 3403, 410212, '祥符区', 3, 188, '开封市', 17, '河南省', 20, '475100', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42037, 1102, 231124, '孙吴县', 3, 105, '黑河市', 9, '黑龙江省', 20, '164200', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42039, 1101, 231123, '逊克县', 3, 105, '黑河市', 9, '黑龙江省', 20, '164400', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42041, 1824, 410205, '禹王台区', 3, 188, '开封市', 17, '河南省', 20, '475003', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42043, 3110, 610926, '平利县', 3, 333, '安康市', 28, '陕西省', 20, '725500', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42045, 1815, 410202, '龙亭区', 3, 188, '开封市', 17, '河南省', 20, '475100', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42047, 1104, 231182, '五大连池市', 3, 105, '黑河市', 9, '黑龙江省', 20, '164100', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42049, 3113, 610929, '白河县', 3, 333, '安康市', 28, '陕西省', 20, '725800', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42051, 104, 231000, '牡丹江市', 2, 9, '黑龙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42053, 3109, 610925, '岚皋县', 3, 333, '安康市', 28, '陕西省', 20, '725400', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42055, 1820, 410223, '尉氏县', 3, 188, '开封市', 17, '河南省', 20, '475500', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42057, 1822, 410225, '兰考县', 3, 188, '开封市', 17, '河南省', 20, '475300', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42059, 3111, 610927, '镇坪县', 3, 333, '安康市', 28, '陕西省', 20, '725600', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42061, 1090, 231004, '爱民区', 3, 104, '牡丹江市', 9, '黑龙江省', 20, '157009', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42063, 1818, 410221, '杞县', 3, 188, '开封市', 17, '河南省', 20, '475200', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42065, 1095, 231081, '绥芬河市', 3, 104, '牡丹江市', 9, '黑龙江省', 20, '157300', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42067, 1089, 231002, '东安区', 3, 104, '牡丹江市', 9, '黑龙江省', 20, '157000', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42069, 1819, 410222, '通许县', 3, 188, '开封市', 17, '河南省', 20, '475400', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42071, 203, 411600, '周口市', 2, 17, '河南省', NULL, NULL, 20, '0', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42073, 1097, 231084, '宁安市', 3, 104, '牡丹江市', 9, '黑龙江省', 20, '157400', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42075, 1948, 411624, '沈丘县', 3, 203, '周口市', 17, '河南省', 20, '466300', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42077, 1093, 231086, '东宁市', 3, 104, '牡丹江市', 9, '黑龙江省', 20, '157200', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42079, 1953, 411681, '项城市', 3, 203, '周口市', 17, '河南省', 20, '466200', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42081, 1944, 411602, '川汇区', 3, 203, '周口市', 17, '河南省', 20, '466000', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42083, 1091, 231003, '阳明区', 3, 104, '牡丹江市', 9, '黑龙江省', 20, '157013', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42085, 1094, 231025, '林口县', 3, 104, '牡丹江市', 9, '黑龙江省', 20, '157600', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42087, 1947, 411623, '商水县', 3, 203, '周口市', 17, '河南省', 20, '466100', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42089, 1098, 231085, '穆棱市', 3, 104, '牡丹江市', 9, '黑龙江省', 20, '157500', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42091, 1952, 411628, '鹿邑县', 3, 203, '周口市', 17, '河南省', 20, '477200', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42093, 1096, 231083, '海林市', 3, 104, '牡丹江市', 9, '黑龙江省', 20, '157100', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42095, 1949, 411625, '郸城县', 3, 203, '周口市', 17, '河南省', 20, '477150', '2020-08-04 00:58:34', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42097, 97, 230300, '鸡西市', 2, 9, '黑龙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42099, 1950, 411603, '淮阳区', 3, 203, '周口市', 17, '河南省', 20, '466700', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42101, 1946, 411622, '西华县', 3, 203, '周口市', 17, '河南省', 20, '466600', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42103, 1028, 230306, '城子河区', 3, 97, '鸡西市', 9, '黑龙江省', 20, '158170', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42105, 1945, 411621, '扶沟县', 3, 203, '周口市', 17, '河南省', 20, '461300', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42107, 1026, 230304, '滴道区', 3, 97, '鸡西市', 9, '黑龙江省', 20, '158150', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42109, 1027, 230305, '梨树区', 3, 97, '鸡西市', 9, '黑龙江省', 20, '158160', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42111, 1951, 411627, '太康县', 3, 203, '周口市', 17, '河南省', 20, '461400', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42113, 1025, 230303, '恒山区', 3, 97, '鸡西市', 9, '黑龙江省', 20, '158130', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42115, 190, 410400, '平顶山市', 2, 17, '河南省', NULL, NULL, 20, '0', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42117, 1024, 230302, '鸡冠区', 3, 97, '鸡西市', 9, '黑龙江省', 20, '158100', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42119, 1844, 410404, '石龙区', 3, 190, '平顶山市', 17, '河南省', 20, '467045', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42121, 1029, 230307, '麻山区', 3, 97, '鸡西市', 9, '黑龙江省', 20, '158180', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42123, 1843, 410403, '卫东区', 3, 190, '平顶山市', 17, '河南省', 20, '467021', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42125, 1032, 230382, '密山市', 3, 97, '鸡西市', 9, '黑龙江省', 20, '158300', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42127, 1848, 410423, '鲁山县', 3, 190, '平顶山市', 17, '河南省', 20, '467300', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42129, 1845, 410411, '湛河区', 3, 190, '平顶山市', 17, '河南省', 20, '467000', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42131, 1030, 230321, '鸡东县', 3, 97, '鸡西市', 9, '黑龙江省', 20, '158200', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42133, 1850, 410481, '舞钢市', 3, 190, '平顶山市', 17, '河南省', 20, '462500', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42135, 1031, 230381, '虎林市', 3, 97, '鸡西市', 9, '黑龙江省', 20, '158400', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42137, 1849, 410425, '郏县', 3, 190, '平顶山市', 17, '河南省', 20, '467100', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42139, 102, 230800, '佳木斯市', 2, 9, '黑龙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42141, 1847, 410422, '叶县', 3, 190, '平顶山市', 17, '河南省', 20, '467200', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42143, 1083, 230881, '同江市', 3, 102, '佳木斯市', 9, '黑龙江省', 20, '156400', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42145, 1846, 410421, '宝丰县', 3, 190, '平顶山市', 17, '河南省', 20, '467400', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42147, 1080, 230826, '桦川县', 3, 102, '佳木斯市', 9, '黑龙江省', 20, '154300', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42149, 1851, 410482, '汝州市', 3, 190, '平顶山市', 17, '河南省', 20, '467500', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42151, 1081, 230828, '汤原县', 3, 102, '佳木斯市', 9, '黑龙江省', 20, '154700', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42153, 201, 411400, '商丘市', 2, 17, '河南省', NULL, NULL, 20, '0', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42155, 1077, 230805, '东风区', 3, 102, '佳木斯市', 9, '黑龙江省', 20, '154005', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42157, 1929, 411423, '宁陵县', 3, 201, '商丘市', 17, '河南省', 20, '476700', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42159, 1925, 411402, '梁园区', 3, 201, '商丘市', 17, '河南省', 20, '476000', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42161, 1076, 230804, '前进区', 3, 102, '佳木斯市', 9, '黑龙江省', 20, '154002', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42163, 1933, 411481, '永城市', 3, 201, '商丘市', 17, '河南省', 20, '476600', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42165, 1079, 230822, '桦南县', 3, 102, '佳木斯市', 9, '黑龙江省', 20, '154400', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42167, 1082, 230883, '抚远市', 3, 102, '佳木斯市', 9, '黑龙江省', 20, '156500', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42169, 1926, 411403, '睢阳区', 3, 201, '商丘市', 17, '河南省', 20, '476100', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42171, 1928, 411422, '睢县', 3, 201, '商丘市', 17, '河南省', 20, '476900', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42173, 1084, 230882, '富锦市', 3, 102, '佳木斯市', 9, '黑龙江省', 20, '156100', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42175, 100, 230600, '大庆市', 2, 9, '黑龙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42177, 1932, 411426, '夏邑县', 3, 201, '商丘市', 17, '河南省', 20, '476400', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42179, 1931, 411425, '虞城县', 3, 201, '商丘市', 17, '河南省', 20, '476300', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42181, 1051, 230604, '让胡路区', 3, 100, '大庆市', 9, '黑龙江省', 20, '163712', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42183, 1927, 411421, '民权县', 3, 201, '商丘市', 17, '河南省', 20, '476800', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42185, 1052, 230605, '红岗区', 3, 100, '大庆市', 9, '黑龙江省', 20, '163511', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42187, 1055, 230622, '肇源县', 3, 100, '大庆市', 9, '黑龙江省', 20, '166500', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42189, 1930, 411424, '柘城县', 3, 201, '商丘市', 17, '河南省', 20, '476200', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42191, 6, 150000, '内蒙古自治区', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42193, 1053, 230606, '大同区', 3, 100, '大庆市', 9, '黑龙江省', 20, '037300', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42195, 65, 150600, '鄂尔多斯市', 2, 6, '内蒙古自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42197, 1056, 230623, '林甸县', 3, 100, '大庆市', 9, '黑龙江省', 20, '166300', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42199, 761, 150621, '达拉特旗', 3, 65, '鄂尔多斯市', 6, '内蒙古自治区', 20, '014300', '2020-08-04 00:58:35', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42201, 1057, 230624, '杜尔伯特蒙古族自治县', 3, 100, '大庆市', 9, '黑龙江省', 20, '166200', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42203, 764, 150624, '鄂托克旗', 3, 65, '鄂尔多斯市', 6, '内蒙古自治区', 20, '016100', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42205, 762, 150622, '准格尔旗', 3, 65, '鄂尔多斯市', 6, '内蒙古自治区', 20, '017100', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42207, 1050, 230603, '龙凤区', 3, 100, '大庆市', 9, '黑龙江省', 20, '163711', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42209, 765, 150625, '杭锦旗', 3, 65, '鄂尔多斯市', 6, '内蒙古自治区', 20, '017400', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42211, 1049, 230602, '萨尔图区', 3, 100, '大庆市', 9, '黑龙江省', 20, '163001', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42213, 766, 150626, '乌审旗', 3, 65, '鄂尔多斯市', 6, '内蒙古自治区', 20, '017300', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42215, 1054, 230621, '肇州县', 3, 100, '大庆市', 9, '黑龙江省', 20, '166400', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42217, 763, 150623, '鄂托克前旗', 3, 65, '鄂尔多斯市', 6, '内蒙古自治区', 20, '016200', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42219, 99, 230500, '双鸭山市', 2, 9, '黑龙江省', NULL, NULL, 20, '0', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42221, 767, 150627, '伊金霍洛旗', 3, 65, '鄂尔多斯市', 6, '内蒙古自治区', 20, '017200', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42223, 1041, 230502, '尖山区', 3, 99, '双鸭山市', 9, '黑龙江省', 20, '155100', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42225, 3385, 150603, '康巴什区', 3, 65, '鄂尔多斯市', 6, '内蒙古自治区', 20, '017020', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42227, 1046, 230522, '友谊县', 3, 99, '双鸭山市', 9, '黑龙江省', 20, '155800', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42229, 760, 150602, '东胜区', 3, 65, '鄂尔多斯市', 6, '内蒙古自治区', 20, '017000', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42231, 1043, 230505, '四方台区', 3, 99, '双鸭山市', 9, '黑龙江省', 20, '155130', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42233, 61, 150200, '包头市', 2, 6, '内蒙古自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42235, 1042, 230503, '岭东区', 3, 99, '双鸭山市', 9, '黑龙江省', 20, '155120', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42237, 733, 150221, '土默特右旗', 3, 61, '包头市', 6, '内蒙古自治区', 20, '014100', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42239, 3384, 150206, '白云鄂博矿区', 3, 61, '包头市', 6, '内蒙古自治区', 20, '014080', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42241, 1047, 230523, '宝清县', 3, 99, '双鸭山市', 9, '黑龙江省', 20, '155600', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42243, 735, 150223, '达尔罕茂明安联合旗', 3, 61, '包头市', 6, '内蒙古自治区', 20, '014500', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42245, 1048, 230524, '饶河县', 3, 99, '双鸭山市', 9, '黑龙江省', 20, '155700', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42247, 1045, 230521, '集贤县', 3, 99, '双鸭山市', 9, '黑龙江省', 20, '155900', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42249, 732, 150207, '九原区', 3, 61, '包头市', 6, '内蒙古自治区', 20, '014060', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42251, 20, 440000, '广东省', 1, 0, NULL, NULL, NULL, 20, '0', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42253, 730, 150205, '石拐区', 3, 61, '包头市', 6, '内蒙古自治区', 20, '014070', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42255, 237, 440500, '汕头市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42257, 727, 150202, '东河区', 3, 61, '包头市', 6, '内蒙古自治区', 20, '014040', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42259, 2227, 440515, '澄海区', 3, 237, '汕头市', 20, '广东省', 20, '515800', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42261, 728, 150203, '昆都仑区', 3, 61, '包头市', 6, '内蒙古自治区', 20, '014010', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42263, 2226, 440514, '潮南区', 3, 237, '汕头市', 20, '广东省', 20, '515144', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42265, 734, 150222, '固阳县', 3, 61, '包头市', 6, '内蒙古自治区', 20, '014200', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42267, 2228, 440523, '南澳县', 3, 237, '汕头市', 20, '广东省', 20, '515900', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42269, 67, 150800, '巴彦淖尔市', 2, 6, '内蒙古自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42271, 785, 150824, '乌拉特中旗', 3, 67, '巴彦淖尔市', 6, '内蒙古自治区', 20, '015300', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42273, 2224, 440512, '濠江区', 3, 237, '汕头市', 20, '广东省', 20, '515071', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42275, 782, 150821, '五原县', 3, 67, '巴彦淖尔市', 6, '内蒙古自治区', 20, '015100', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42277, 2225, 440513, '潮阳区', 3, 237, '汕头市', 20, '广东省', 20, '515100', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42279, 781, 150802, '临河区', 3, 67, '巴彦淖尔市', 6, '内蒙古自治区', 20, '015001', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42281, 2223, 440511, '金平区', 3, 237, '汕头市', 20, '广东省', 20, '515041', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42283, 783, 150822, '磴口县', 3, 67, '巴彦淖尔市', 6, '内蒙古自治区', 20, '015200', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42285, 2222, 440507, '龙湖区', 3, 237, '汕头市', 20, '广东省', 20, '515041', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42287, 784, 150823, '乌拉特前旗', 3, 67, '巴彦淖尔市', 6, '内蒙古自治区', 20, '014400', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42289, 238, 440600, '佛山市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42291, 787, 150826, '杭锦后旗', 3, 67, '巴彦淖尔市', 6, '内蒙古自治区', 20, '015400', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42293, 786, 150825, '乌拉特后旗', 3, 67, '巴彦淖尔市', 6, '内蒙古自治区', 20, '015500', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42295, 2232, 440607, '三水区', 3, 238, '佛山市', 20, '广东省', 20, '528100', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42297, 62, 150300, '乌海市', 2, 6, '内蒙古自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42299, 2233, 440608, '高明区', 3, 238, '佛山市', 20, '广东省', 20, '528500', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42301, 738, 150304, '乌达区', 3, 62, '乌海市', 6, '内蒙古自治区', 20, '016040', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42303, 2231, 440606, '顺德区', 3, 238, '佛山市', 20, '广东省', 20, '528300', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42305, 737, 150303, '海南区', 3, 62, '乌海市', 6, '内蒙古自治区', 20, '016030', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42307, 2230, 440605, '南海区', 3, 238, '佛山市', 20, '广东省', 20, '528200', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42309, 2229, 440604, '禅城区', 3, 238, '佛山市', 20, '广东省', 20, '528000', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42311, 736, 150302, '海勃湾区', 3, 62, '乌海市', 6, '内蒙古自治区', 20, '016000', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42313, 242, 441200, '肇庆市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42315, 66, 150700, '呼伦贝尔市', 2, 6, '内蒙古自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42317, 2260, 441224, '怀集县', 3, 242, '肇庆市', 20, '广东省', 20, '526400', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42319, 779, 150784, '额尔古纳市', 3, 66, '呼伦贝尔市', 6, '内蒙古自治区', 20, '022250', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42321, 777, 150782, '牙克石市', 3, 66, '呼伦贝尔市', 6, '内蒙古自治区', 20, '022150', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42323, 2261, 441225, '封开县', 3, 242, '肇庆市', 20, '广东省', 20, '526500', '2020-08-04 00:58:36', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42325, 2259, 441223, '广宁县', 3, 242, '肇庆市', 20, '广东省', 20, '526300', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42327, 780, 150785, '根河市', 3, 66, '呼伦贝尔市', 6, '内蒙古自治区', 20, '022350', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42329, 2264, 441284, '四会市', 3, 242, '肇庆市', 20, '广东省', 20, '526200', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42331, 769, 150721, '阿荣旗', 3, 66, '呼伦贝尔市', 6, '内蒙古自治区', 20, '162750', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42333, 2262, 441226, '德庆县', 3, 242, '肇庆市', 20, '广东省', 20, '526600', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42335, 768, 150702, '海拉尔区', 3, 66, '呼伦贝尔市', 6, '内蒙古自治区', 20, '021000', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42337, 2258, 441203, '鼎湖区', 3, 242, '肇庆市', 20, '广东省', 20, '526070', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42339, 773, 150725, '陈巴尔虎旗', 3, 66, '呼伦贝尔市', 6, '内蒙古自治区', 20, '021500', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42341, 2257, 441202, '端州区', 3, 242, '肇庆市', 20, '广东省', 20, '526040', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42343, 778, 150783, '扎兰屯市', 3, 66, '呼伦贝尔市', 6, '内蒙古自治区', 20, '162650', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42345, 2263, 441204, '高要区', 3, 242, '肇庆市', 20, '广东省', 20, '526100', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42347, 770, 150722, '莫力达瓦达斡尔族自治旗', 3, 66, '呼伦贝尔市', 6, '内蒙古自治区', 20, '162850', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42349, 243, 441300, '惠州市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42351, 772, 150724, '鄂温克族自治旗', 3, 66, '呼伦贝尔市', 6, '内蒙古自治区', 20, '021100', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42353, 2270, 441324, '龙门县', 3, 243, '惠州市', 20, '广东省', 20, '516800', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42355, 775, 150727, '新巴尔虎右旗', 3, 66, '呼伦贝尔市', 6, '内蒙古自治区', 20, '021300', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42357, 3386, 150703, '扎赉诺尔区', 3, 66, '呼伦贝尔市', 6, '内蒙古自治区', 20, '021410', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42359, 2269, 441323, '惠东县', 3, 243, '惠州市', 20, '广东省', 20, '516300', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42361, 2268, 441322, '博罗县', 3, 243, '惠州市', 20, '广东省', 20, '516100', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42363, 776, 150781, '满洲里市', 3, 66, '呼伦贝尔市', 6, '内蒙古自治区', 20, '021400', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42365, 2267, 441303, '惠阳区', 3, 243, '惠州市', 20, '广东省', 20, '516200', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42367, 771, 150723, '鄂伦春自治旗', 3, 66, '呼伦贝尔市', 6, '内蒙古自治区', 20, '165450', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42369, 2266, 441302, '惠城区', 3, 243, '惠州市', 20, '广东省', 20, '516001', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42371, 774, 150726, '新巴尔虎左旗', 3, 66, '呼伦贝尔市', 6, '内蒙古自治区', 20, '021200', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42373, 235, 440300, '深圳市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42375, 71, 152900, '阿拉善盟', 2, 6, '内蒙古自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42377, 2214, 440306, '宝安区', 3, 235, '深圳市', 20, '广东省', 20, '518101', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42379, 819, 152923, '额济纳旗', 3, 71, '阿拉善盟', 6, '内蒙古自治区', 20, '735400', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42381, 2212, 440304, '福田区', 3, 235, '深圳市', 20, '广东省', 20, '518033', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42383, 818, 152922, '阿拉善右旗', 3, 71, '阿拉善盟', 6, '内蒙古自治区', 20, '737300', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42385, 2216, 440308, '盐田区', 3, 235, '深圳市', 20, '广东省', 20, '518083', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42387, 817, 152921, '阿拉善左旗', 3, 71, '阿拉善盟', 6, '内蒙古自治区', 20, '750306', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42389, 2211, 440303, '罗湖区', 3, 235, '深圳市', 20, '广东省', 20, '518001', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42391, 3409, 440310, '坪山区', 3, 235, '深圳市', 20, '广东省', 20, '518118', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42393, 64, 150500, '通辽市', 2, 6, '内蒙古自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42395, 2215, 440307, '龙岗区', 3, 235, '深圳市', 20, '广东省', 20, '518116', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42397, 759, 150581, '霍林郭勒市', 3, 64, '通辽市', 6, '内蒙古自治区', 20, '029200', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42399, 758, 150526, '扎鲁特旗', 3, 64, '通辽市', 6, '内蒙古自治区', 20, '029100', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42401, 2217, 440311, '光明区', 3, 235, '深圳市', 20, '广东省', 20, '518107', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42403, 753, 150521, '科尔沁左翼中旗', 3, 64, '通辽市', 6, '内蒙古自治区', 20, '029300', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42405, 240, 440800, '湛江市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42407, 757, 150525, '奈曼旗', 3, 64, '通辽市', 6, '内蒙古自治区', 20, '028300', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42409, 2247, 440881, '廉江市', 3, 240, '湛江市', 20, '广东省', 20, '524400', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42411, 755, 150523, '开鲁县', 3, 64, '通辽市', 6, '内蒙古自治区', 20, '028400', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42413, 2249, 440883, '吴川市', 3, 240, '湛江市', 20, '广东省', 20, '524500', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42415, 752, 150502, '科尔沁区', 3, 64, '通辽市', 6, '内蒙古自治区', 20, '028000', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42417, 2246, 440825, '徐闻县', 3, 240, '湛江市', 20, '广东省', 20, '524100', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42419, 756, 150524, '库伦旗', 3, 64, '通辽市', 6, '内蒙古自治区', 20, '028200', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42421, 2248, 440882, '雷州市', 3, 240, '湛江市', 20, '广东省', 20, '524200', '2020-08-04 00:58:37', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42423, 2244, 440811, '麻章区', 3, 240, '湛江市', 20, '广东省', 20, '524003', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42425, 754, 150522, '科尔沁左翼后旗', 3, 64, '通辽市', 6, '内蒙古自治区', 20, '028100', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42427, 2243, 440804, '坡头区', 3, 240, '湛江市', 20, '广东省', 20, '524057', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42429, 69, 152200, '兴安盟', 2, 6, '内蒙古自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42431, 800, 152202, '阿尔山市', 3, 69, '兴安盟', 6, '内蒙古自治区', 20, '137800', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42433, 2242, 440803, '霞山区', 3, 240, '湛江市', 20, '广东省', 20, '524002', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42435, 2245, 440823, '遂溪县', 3, 240, '湛江市', 20, '广东省', 20, '524300', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42437, 802, 152222, '科尔沁右翼中旗', 3, 69, '兴安盟', 6, '内蒙古自治区', 20, '029400', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42439, 804, 152224, '突泉县', 3, 69, '兴安盟', 6, '内蒙古自治区', 20, '137500', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42441, 2241, 440802, '赤坎区', 3, 240, '湛江市', 20, '广东省', 20, '524033', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42443, 236, 440400, '珠海市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42445, 799, 152201, '乌兰浩特市', 3, 69, '兴安盟', 6, '内蒙古自治区', 20, '137401', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42447, 2220, 440403, '斗门区', 3, 236, '珠海市', 20, '广东省', 20, '519100', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42449, 803, 152223, '扎赉特旗', 3, 69, '兴安盟', 6, '内蒙古自治区', 20, '137600', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42451, 801, 152221, '科尔沁右翼前旗', 3, 69, '兴安盟', 6, '内蒙古自治区', 20, '137423', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42453, 2221, 440404, '金湾区', 3, 236, '珠海市', 20, '广东省', 20, '519090', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42455, 70, 152500, '锡林郭勒盟', 2, 6, '内蒙古自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42457, 2219, 440402, '香洲区', 3, 236, '珠海市', 20, '广东省', 20, '519000', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42459, 811, 152526, '西乌珠穆沁旗', 3, 70, '锡林郭勒盟', 6, '内蒙古自治区', 20, '026200', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42461, 249, 445100, '潮州市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42463, 806, 152502, '锡林浩特市', 3, 70, '锡林郭勒盟', 6, '内蒙古自治区', 20, '026000', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42465, 2305, 445122, '饶平县', 3, 249, '潮州市', 20, '广东省', 20, '515700', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42467, 810, 152525, '东乌珠穆沁旗', 3, 70, '锡林郭勒盟', 6, '内蒙古自治区', 20, '026300', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42469, 807, 152522, '阿巴嘎旗', 3, 70, '锡林郭勒盟', 6, '内蒙古自治区', 20, '011400', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42471, 2303, 445102, '湘桥区', 3, 249, '潮州市', 20, '广东省', 20, '521000', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42473, 2304, 445103, '潮安区', 3, 249, '潮州市', 20, '广东省', 20, '515638', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42475, 808, 152523, '苏尼特左旗', 3, 70, '锡林郭勒盟', 6, '内蒙古自治区', 20, '011300', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42477, 809, 152524, '苏尼特右旗', 3, 70, '锡林郭勒盟', 6, '内蒙古自治区', 20, '011200', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42479, 241, 440900, '茂名市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42481, 805, 152501, '二连浩特市', 3, 70, '锡林郭勒盟', 6, '内蒙古自治区', 20, '011100', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42483, 2256, 440983, '信宜市', 3, 241, '茂名市', 20, '广东省', 20, '525300', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42485, 813, 152528, '镶黄旗', 3, 70, '锡林郭勒盟', 6, '内蒙古自治区', 20, '013250', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42487, 2254, 440981, '高州市', 3, 241, '茂名市', 20, '广东省', 20, '525200', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42489, 815, 152530, '正蓝旗', 3, 70, '锡林郭勒盟', 6, '内蒙古自治区', 20, '027200', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42491, 814, 152529, '正镶白旗', 3, 70, '锡林郭勒盟', 6, '内蒙古自治区', 20, '013800', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42493, 2255, 440982, '化州市', 3, 241, '茂名市', 20, '广东省', 20, '525100', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42495, 816, 152531, '多伦县', 3, 70, '锡林郭勒盟', 6, '内蒙古自治区', 20, '027300', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42497, 2253, 440904, '电白区', 3, 241, '茂名市', 20, '广东省', 20, '525400', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42499, 812, 152527, '太仆寺旗', 3, 70, '锡林郭勒盟', 6, '内蒙古自治区', 20, '027000', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42501, 2251, 440902, '茂南区', 3, 241, '茂名市', 20, '广东省', 20, '525011', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42503, 60, 150100, '呼和浩特市', 2, 6, '内蒙古自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42505, 724, 150123, '和林格尔县', 3, 60, '呼和浩特市', 6, '内蒙古自治区', 20, '011500', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42507, 239, 440700, '江门市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42509, 718, 150103, '回民区', 3, 60, '呼和浩特市', 6, '内蒙古自治区', 20, '010030', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42511, 2239, 440784, '鹤山市', 3, 239, '江门市', 20, '广东省', 20, '529711', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42513, 719, 150104, '玉泉区', 3, 60, '呼和浩特市', 6, '内蒙古自治区', 20, '010020', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42515, 2235, 440704, '江海区', 3, 239, '江门市', 20, '广东省', 20, '529000', '2020-08-04 00:58:38', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42517, 726, 150125, '武川县', 3, 60, '呼和浩特市', 6, '内蒙古自治区', 20, '011700', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42519, 2238, 440783, '开平市', 3, 239, '江门市', 20, '广东省', 20, '529312', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42521, 2237, 440781, '台山市', 3, 239, '江门市', 20, '广东省', 20, '529211', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42523, 722, 150121, '土默特左旗', 3, 60, '呼和浩特市', 6, '内蒙古自治区', 20, '010100', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42525, 2240, 440785, '恩平市', 3, 239, '江门市', 20, '广东省', 20, '529411', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42527, 723, 150122, '托克托县', 3, 60, '呼和浩特市', 6, '内蒙古自治区', 20, '010200', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42529, 2236, 440705, '新会区', 3, 239, '江门市', 20, '广东省', 20, '529100', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42531, 721, 150105, '赛罕区', 3, 60, '呼和浩特市', 6, '内蒙古自治区', 20, '010020', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42533, 2234, 440703, '蓬江区', 3, 239, '江门市', 20, '广东省', 20, '529051', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42535, 725, 150124, '清水河县', 3, 60, '呼和浩特市', 6, '内蒙古自治区', 20, '011600', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42537, 246, 441600, '河源市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42539, 63, 150400, '赤峰市', 2, 6, '内蒙古自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42541, 2289, 441624, '和平县', 3, 246, '河源市', 20, '广东省', 20, '517200', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42543, 742, 150421, '阿鲁科尔沁旗', 3, 63, '赤峰市', 6, '内蒙古自治区', 20, '025550', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42545, 2287, 441622, '龙川县', 3, 246, '河源市', 20, '广东省', 20, '517300', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42547, 745, 150424, '林西县', 3, 63, '赤峰市', 6, '内蒙古自治区', 20, '025250', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42549, 2288, 441623, '连平县', 3, 246, '河源市', 20, '广东省', 20, '517100', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42551, 743, 150422, '巴林左旗', 3, 63, '赤峰市', 6, '内蒙古自治区', 20, '025450', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42553, 2290, 441625, '东源县', 3, 246, '河源市', 20, '广东省', 20, '517500', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42555, 2285, 441602, '源城区', 3, 246, '河源市', 20, '广东省', 20, '517000', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42557, 744, 150423, '巴林右旗', 3, 63, '赤峰市', 6, '内蒙古自治区', 20, '025150', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42559, 2286, 441621, '紫金县', 3, 246, '河源市', 20, '广东省', 20, '517400', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42561, 746, 150425, '克什克腾旗', 3, 63, '赤峰市', 6, '内蒙古自治区', 20, '025350', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42563, 251, 445300, '云浮市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42565, 747, 150426, '翁牛特旗', 3, 63, '赤峰市', 6, '内蒙古自治区', 20, '024500', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42567, 741, 150404, '松山区', 3, 63, '赤峰市', 6, '内蒙古自治区', 20, '024005', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42569, 2316, 445322, '郁南县', 3, 251, '云浮市', 20, '广东省', 20, '527100', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42571, 2318, 445381, '罗定市', 3, 251, '云浮市', 20, '广东省', 20, '527200', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42573, 739, 150402, '红山区', 3, 63, '赤峰市', 6, '内蒙古自治区', 20, '024020', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42575, 748, 150428, '喀喇沁旗', 3, 63, '赤峰市', 6, '内蒙古自治区', 20, '024400', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42577, 2315, 445321, '新兴县', 3, 251, '云浮市', 20, '广东省', 20, '527400', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42579, 2314, 445302, '云城区', 3, 251, '云浮市', 20, '广东省', 20, '527300', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42581, 740, 150403, '元宝山区', 3, 63, '赤峰市', 6, '内蒙古自治区', 20, '024076', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42583, 2317, 445303, '云安区', 3, 251, '云浮市', 20, '广东省', 20, '527500', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42585, 750, 150430, '敖汉旗', 3, 63, '赤峰市', 6, '内蒙古自治区', 20, '024300', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42587, 245, 441500, '汕尾市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42589, 749, 150429, '宁城县', 3, 63, '赤峰市', 6, '内蒙古自治区', 20, '024200', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42591, 68, 150900, '乌兰察布市', 2, 6, '内蒙古自治区', NULL, NULL, 20, '0', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42593, 2283, 441521, '海丰县', 3, 245, '汕尾市', 20, '广东省', 20, '516400', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42595, 797, 150929, '四子王旗', 3, 68, '乌兰察布市', 6, '内蒙古自治区', 20, '011800', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42597, 2284, 441523, '陆河县', 3, 245, '汕尾市', 20, '广东省', 20, '516700', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42599, 795, 150927, '察哈尔右翼中旗', 3, 68, '乌兰察布市', 6, '内蒙古自治区', 20, '013550', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42601, 2282, 441581, '陆丰市', 3, 245, '汕尾市', 20, '广东省', 20, '516500', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42603, 791, 150923, '商都县', 3, 68, '乌兰察布市', 6, '内蒙古自治区', 20, '013450', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42605, 247, 441700, '阳江市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42607, 792, 150924, '兴和县', 3, 68, '乌兰察布市', 6, '内蒙古自治区', 20, '013650', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42609, 2294, 441781, '阳春市', 3, 247, '阳江市', 20, '广东省', 20, '529611', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42611, 790, 150922, '化德县', 3, 68, '乌兰察布市', 6, '内蒙古自治区', 20, '013350', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42613, 2291, 441702, '江城区', 3, 247, '阳江市', 20, '广东省', 20, '529525', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42615, 796, 150928, '察哈尔右翼后旗', 3, 68, '乌兰察布市', 6, '内蒙古自治区', 20, '012400', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42617, 789, 150921, '卓资县', 3, 68, '乌兰察布市', 6, '内蒙古自治区', 20, '012300', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42619, 2292, 441721, '阳西县', 3, 247, '阳江市', 20, '广东省', 20, '529800', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42621, 2293, 441704, '阳东区', 3, 247, '阳江市', 20, '广东省', 20, '529931', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42623, 798, 150981, '丰镇市', 3, 68, '乌兰察布市', 6, '内蒙古自治区', 20, '012100', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42625, 794, 150926, '察哈尔右翼前旗', 3, 68, '乌兰察布市', 6, '内蒙古自治区', 20, '012200', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42627, 250, 445200, '揭阳市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42629, 2310, 445281, '普宁市', 3, 250, '揭阳市', 20, '广东省', 20, '515300', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42631, 788, 150902, '集宁区', 3, 68, '乌兰察布市', 6, '内蒙古自治区', 20, '012000', '2020-08-04 00:58:39', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42633, 793, 150925, '凉城县', 3, 68, '乌兰察布市', 6, '内蒙古自治区', 20, '013750', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42635, 2308, 445222, '揭西县', 3, 250, '揭阳市', 20, '广东省', 20, '515400', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42637, 2309, 445224, '惠来县', 3, 250, '揭阳市', 20, '广东省', 20, '515200', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42639, 2307, 445203, '揭东区', 3, 250, '揭阳市', 20, '广东省', 20, '515554', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42641, 2306, 445202, '榕城区', 3, 250, '揭阳市', 20, '广东省', 20, '522095', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42643, 244, 441400, '梅州市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42645, 2279, 441427, '蕉岭县', 3, 244, '梅州市', 20, '广东省', 20, '514100', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42647, 2278, 441426, '平远县', 3, 244, '梅州市', 20, '广东省', 20, '514600', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42649, 2280, 441481, '兴宁市', 3, 244, '梅州市', 20, '广东省', 20, '514500', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42651, 2277, 441424, '五华县', 3, 244, '梅州市', 20, '广东省', 20, '514400', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42653, 2276, 441423, '丰顺县', 3, 244, '梅州市', 20, '广东省', 20, '514300', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42655, 2275, 441422, '大埔县', 3, 244, '梅州市', 20, '广东省', 20, '514200', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42657, 2274, 441403, '梅县区', 3, 244, '梅州市', 20, '广东省', 20, '514733', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42659, 2273, 441402, '梅江区', 3, 244, '梅州市', 20, '广东省', 20, '514000', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42661, 233, 440100, '广州市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42663, 2198, 440117, '从化区', 3, 233, '广州市', 20, '广东省', 20, '510900', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42665, 2196, 440114, '花都区', 3, 233, '广州市', 20, '广东省', 20, '510800', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42667, 2195, 440113, '番禺区', 3, 233, '广州市', 20, '广东省', 20, '511400', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42669, 2189, 440103, '荔湾区', 3, 233, '广州市', 20, '广东省', 20, '510145', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42671, 2191, 440105, '海珠区', 3, 233, '广州市', 20, '广东省', 20, '510220', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42673, 2197, 440118, '增城区', 3, 233, '广州市', 20, '广东省', 20, '511300', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42675, 2190, 440104, '越秀区', 3, 233, '广州市', 20, '广东省', 20, '510030', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42677, 2194, 440112, '黄埔区', 3, 233, '广州市', 20, '广东省', 20, '510700', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42679, 2192, 440106, '天河区', 3, 233, '广州市', 20, '广东省', 20, '510630', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42681, 234, 440200, '韶关市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42683, 2204, 440222, '始兴县', 3, 234, '韶关市', 20, '广东省', 20, '512500', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42685, 2210, 440282, '南雄市', 3, 234, '韶关市', 20, '广东省', 20, '512400', '2020-08-04 00:58:40', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42687, 2202, 440204, '浈江区', 3, 234, '韶关市', 20, '广东省', 20, '512023', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42689, 2205, 440224, '仁化县', 3, 234, '韶关市', 20, '广东省', 20, '512300', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42691, 2207, 440232, '乳源瑶族自治县', 3, 234, '韶关市', 20, '广东省', 20, '512700', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42693, 2206, 440229, '翁源县', 3, 234, '韶关市', 20, '广东省', 20, '512600', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42695, 2203, 440205, '曲江区', 3, 234, '韶关市', 20, '广东省', 20, '512100', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42697, 2201, 440203, '武江区', 3, 234, '韶关市', 20, '广东省', 20, '512026', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42699, 2208, 440233, '新丰县', 3, 234, '韶关市', 20, '广东省', 20, '511100', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42701, 2209, 440281, '乐昌市', 3, 234, '韶关市', 20, '广东省', 20, '512200', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42703, 248, 441800, '清远市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42705, 2302, 441882, '连州市', 3, 248, '清远市', 20, '广东省', 20, '513401', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42707, 2298, 441825, '连山壮族瑶族自治县', 3, 248, '清远市', 20, '广东省', 20, '513200', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42709, 2299, 441826, '连南瑶族自治县', 3, 248, '清远市', 20, '广东省', 20, '513300', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42711, 2301, 441881, '英德市', 3, 248, '清远市', 20, '广东省', 20, '513000', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42713, 2296, 441821, '佛冈县', 3, 248, '清远市', 20, '广东省', 20, '511600', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42715, 2297, 441823, '阳山县', 3, 248, '清远市', 20, '广东省', 20, '513100', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42717, 2300, 441803, '清新区', 3, 248, '清远市', 20, '广东省', 20, '511800', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42719, 2295, 441802, '清城区', 3, 248, '清远市', 20, '广东省', 20, '511500', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42721, 253, 442000, '中山市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42723, 252, 441900, '东莞市', 2, 20, '广东省', NULL, NULL, 20, '0', '2020-08-04 00:58:41', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42799, 2132, 430802, '永定区', 3, 226, '张家界市', 19, '湖南省', 20, '364100', '2020-08-04 01:39:10', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42801, 1650, 370103, '市中区', 3, 170, '济南市', 16, '山东省', 20, '250001', '2020-08-04 01:39:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42803, 820, 210102, '和平区', 3, 72, '沈阳市', 7, '辽宁省', 20, '300041', '2020-08-04 01:39:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42805, 824, 210106, '铁西区', 3, 72, '沈阳市', 7, '辽宁省', 20, '110021', '2020-08-04 01:39:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42807, 1545, 360103, '西湖区', 3, 159, '南昌市', 15, '江西省', 20, '310013', '2020-08-04 01:39:11', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42809, 889, 210902, '海州区', 3, 80, '阜新市', 7, '辽宁省', 20, '123000', '2020-08-04 01:39:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42811, 3209, 630103, '城中区', 3, 349, '西宁市', 30, '青海省', 20, '545001', '2020-08-04 01:39:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42813, 849, 210303, '铁西区', 3, 74, '鞍山市', 7, '辽宁省', 20, '110021', '2020-08-04 01:39:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42815, 848, 210302, '铁东区', 3, 74, '鞍山市', 7, '辽宁省', 20, '114001', '2020-08-04 01:39:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42817, 2496, 500105, '江北区', 3, 271, '重庆城区', 23, '重庆市', 20, '315040', '2020-08-04 01:39:12', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42819, 2938, 540102, '城关区', 3, 318, '拉萨市', 27, '西藏自治区', 20, '850000', '2020-08-04 01:39:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42821, 2321, 610116, '长安区', 3, 325, '西安市', 28, '陕西省', 20, '050011', '2020-08-04 01:39:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42823, 1127, 310107, '普陀区', 3, 108, '上海城区', 10, '上海市', 20, '200333', '2020-08-04 01:39:13', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42825, 396, 120102, '河东区', 3, 37, '天津城区', 3, '天津市', 20, '300171', '2020-08-04 01:39:14', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42827, 381, 110105, '朝阳区', 3, 36, '北京城区', 2, '北京市', 20, '100000', '2020-08-04 01:39:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42829, 2603, 511002, '市中区', 3, 280, '内江市', 24, '四川省', 20, '250001', '2020-08-04 01:39:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42831, 1817, 410204, '鼓楼区', 3, 188, '开封市', 17, '河南省', 20, '210000', '2020-08-04 01:39:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42833, 387, 110112, '通州区', 3, 36, '北京城区', 2, '北京市', 20, '100000', '2020-08-04 01:39:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42835, 1842, 410402, '新华区', 3, 190, '平顶山市', 17, '河南省', 20, '050051', '2020-08-04 01:39:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42837, 622, 140311, '郊区', 3, 51, '阳泉市', 5, '山西省', 20, '045011', '2020-08-04 01:39:15', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42839, 729, 150204, '青山区', 3, 61, '包头市', 6, '内蒙古自治区', 20, '014030', '2020-08-04 01:39:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42841, 2608, 511102, '市中区', 3, 281, '乐山市', 24, '四川省', 20, '250001', '2020-08-04 01:39:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42843, 638, 140502, '城区', 3, 53, '晋城市', 5, '山西省', 20, '037008', '2020-08-04 01:39:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42845, 720, 150102, '新城区', 3, 60, '呼和浩特市', 6, '内蒙古自治区', 20, '010030', '2020-08-04 01:39:16', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42847, 1455, 350102, '鼓楼区', 3, 150, '福州市', 14, '福建省', 20, '210000', '2020-08-04 01:39:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42849, 1092, 231005, '西安区', 3, 104, '牡丹江市', 9, '黑龙江省', 20, '136201', '2020-08-04 01:39:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42851, 1075, 230803, '向阳区', 3, 102, '佳木斯市', 9, '黑龙江省', 20, '154100', '2020-08-04 01:39:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42853, 1078, 230811, '郊区', 3, 102, '佳木斯市', 9, '黑龙江省', 20, '045011', '2020-08-04 01:39:17', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42855, 1044, 230506, '宝山区', 3, 99, '双鸭山市', 9, '黑龙江省', 20, '155131', '2020-08-04 01:39:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42857, 1164, 320302, '鼓楼区', 3, 111, '徐州市', 11, '江苏省', 20, '210000', '2020-08-04 01:39:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42859, 2213, 440305, '南山区', 3, 235, '深圳市', 20, '广东省', 20, '154104', '2020-08-04 01:39:18', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42861, 3531, 440309, '龙华区', 3, 235, '深圳市', 20, '广东省', 20, '570105', '2020-08-04 01:39:18', '2020-08-06 22:39:19', 0);
INSERT INTO `t_areas` VALUES (42863, 419, 130104, '桥西区', 3, 38, '石家庄市', 4, '河北省', 20, '050051', '2020-08-04 01:39:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42865, 420, 130105, '新华区', 3, 38, '石家庄市', 4, '河北省', 20, '050051', '2020-08-04 01:39:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42867, 2281, 441502, '城区', 3, 245, '汕尾市', 20, '广东省', 20, '037008', '2020-08-04 01:39:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42869, 2199, 440115, '南沙区', 3, 233, '广州市', 20, '广东省', 20, '511400', '2020-08-04 01:39:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42871, 731, 440111, '白云区', 3, 233, '广州市', 20, '广东省', 20, '014080', '2020-08-04 01:39:19', '2020-08-04 18:58:27', 0);
INSERT INTO `t_areas` VALUES (42873, 3541, 460302, '南沙区', 3, 3418, '三沙市', 22, '海南省', 20, '511400', '2020-08-04 01:52:34', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42875, 3548, 810016, '沙田区', 3, 3454, '香港特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42877, 3549, 810005, '油尖旺区', 3, 3454, '香港特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42879, 3552, 810009, '观塘区', 3, 3454, '香港特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42881, 3553, 810011, '屯门区', 3, 3454, '香港特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42883, 3550, 810014, '大埔区', 3, 3454, '香港特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42885, 3554, 810004, '南区', 3, 3454, '香港特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42887, 3551, 810007, '九龙城区', 3, 3454, '香港特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42889, 3557, 810015, '西贡区', 3, 3454, '香港特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42891, 3558, 810006, '深水埗区', 3, 3454, '香港特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42893, 3555, 810008, '黄大仙区', 3, 3454, '香港特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42895, 3556, 810001, '中西区', 3, 3454, '香港特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42897, 3562, 810013, '北区', 3, 3454, '香港特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42899, 3563, 810012, '元朗区', 3, 3454, '香港特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42901, 3564, 810002, '湾仔区', 3, 3454, '香港特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42903, 3559, 810018, '离岛区', 3, 3454, '香港特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42905, 3560, 810003, '东区', 3, 3454, '香港特别行政区', NULL, NULL, 20, '617067', '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42907, 3565, 810010, '荃湾区', 3, 3454, '香港特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42909, 3566, 810017, '葵青区', 3, 3454, '香港特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42911, 3455, 820000, '澳门特别行政区', 1, 0, NULL, NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42913, 3567, 820001, '花地玛堂区', 3, 3455, '澳门特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42915, 3568, 820007, '路凼填海区', 3, 3455, '澳门特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42917, 3572, 820003, '望德堂区', 3, 3455, '澳门特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:19', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42919, 3573, 820002, '花王堂区', 3, 3455, '澳门特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:20', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42921, 3569, 820004, '大堂区', 3, 3455, '澳门特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:20', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42923, 3570, 820008, '圣方济各堂区', 3, 3455, '澳门特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:20', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42925, 3571, 820006, '嘉模堂区', 3, 3455, '澳门特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:20', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (42927, 3574, 820005, '风顺堂区', 3, 3455, '澳门特别行政区', NULL, NULL, 20, NULL, '2020-08-04 02:02:20', '2020-08-06 22:39:12', 0);
INSERT INTO `t_areas` VALUES (44520, 8176, NULL, '兵团八十九团', 4, 3451, '双河市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44521, 8182, NULL, '兵团八十六团', 4, 3451, '双河市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44522, 8177, NULL, '兵团八十四团', 4, 3451, '双河市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44523, 8178, NULL, '兵团九十团', 4, 3451, '双河市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44524, 8183, NULL, '兵团八十一团', 4, 3451, '双河市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44525, 8179, NULL, '兵团一八八团', 4, 3449, '北屯市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44526, 8180, NULL, '兵团一八三团', 4, 3449, '北屯市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44527, 8184, NULL, '兵团一八七团', 4, 3449, '北屯市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44528, 8181, NULL, '北屯镇', 4, 3449, '北屯市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44529, 8187, NULL, '兵团二十九团', 4, 3450, '铁门关市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44530, 8185, NULL, '农二师三十团', 4, 3450, '铁门关市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44531, 8186, NULL, '兵团六十八团', 4, 3452, '可克达拉市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44532, 8192, NULL, '都拉塔口岸', 4, 3452, '可克达拉市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44533, 8188, NULL, '兵团六十六团', 4, 3452, '可克达拉市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44534, 8189, NULL, '兵团六十七团', 4, 3452, '可克达拉市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44535, 8193, NULL, '兵团六十三团', 4, 3452, '可克达拉市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44536, 8190, NULL, '兵团六十四团', 4, 3452, '可克达拉市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44537, 8194, NULL, '兵团二二四团', 4, 3453, '昆玉市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44538, 8191, NULL, '阔依其乡', 4, 3453, '昆玉市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:03', '2020-08-11 17:37:03', 0);
INSERT INTO `t_areas` VALUES (44539, 8197, NULL, '乌鲁克萨依乡', 4, 3453, '昆玉市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:04', '2020-08-11 17:37:04', 0);
INSERT INTO `t_areas` VALUES (44540, 8195, NULL, '普恰克其乡', 4, 3453, '昆玉市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:04', '2020-08-11 17:37:04', 0);
INSERT INTO `t_areas` VALUES (44541, 8198, NULL, '兵团四十七团', 4, 3453, '昆玉市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:04', '2020-08-11 17:37:04', 0);
INSERT INTO `t_areas` VALUES (44542, 8196, NULL, '兵团一牧场', 4, 3453, '昆玉市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:04', '2020-08-11 17:37:04', 0);
INSERT INTO `t_areas` VALUES (44543, 8202, NULL, '兵团皮山农场', 4, 3453, '昆玉市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:04', '2020-08-11 17:37:04', 0);
INSERT INTO `t_areas` VALUES (44544, 8203, NULL, '乌尔其乡', 4, 3453, '昆玉市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:04', '2020-08-11 17:37:04', 0);
INSERT INTO `t_areas` VALUES (44545, 8199, NULL, '喀拉喀什镇', 4, 3453, '昆玉市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:04', '2020-08-11 17:37:04', 0);
INSERT INTO `t_areas` VALUES (44546, 8204, NULL, '奴尔乡', 4, 3453, '昆玉市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:04', '2020-08-11 17:37:04', 0);
INSERT INTO `t_areas` VALUES (44547, 8205, NULL, '博斯坦乡', 4, 3453, '昆玉市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:04', '2020-08-11 17:37:04', 0);
INSERT INTO `t_areas` VALUES (44548, 8200, NULL, '兵团一五二团', 4, 3369, '石河子市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:05', '2020-08-11 17:37:05', 0);
INSERT INTO `t_areas` VALUES (44549, 8201, NULL, '向阳街道', 4, 3369, '石河子市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:05', '2020-08-11 17:37:05', 0);
INSERT INTO `t_areas` VALUES (44550, 8207, NULL, '红山街道', 4, 3369, '石河子市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:05', '2020-08-11 17:37:05', 0);
INSERT INTO `t_areas` VALUES (44551, 8208, NULL, '东城街道', 4, 3369, '石河子市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:05', '2020-08-11 17:37:05', 0);
INSERT INTO `t_areas` VALUES (44552, 8206, NULL, '老街街道', 4, 3369, '石河子市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:05', '2020-08-11 17:37:05', 0);
INSERT INTO `t_areas` VALUES (44553, 8212, NULL, '石河子乡', 4, 3369, '石河子市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:05', '2020-08-11 17:37:05', 0);
INSERT INTO `t_areas` VALUES (44554, 8209, NULL, '新城街道', 4, 3369, '石河子市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:05', '2020-08-11 17:37:05', 0);
INSERT INTO `t_areas` VALUES (44555, 8213, NULL, '北泉镇', 4, 3369, '石河子市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:05', '2020-08-11 17:37:05', 0);
INSERT INTO `t_areas` VALUES (44556, 8214, NULL, '兵团一零二团', 4, 3372, '五家渠市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:05', '2020-08-11 17:37:05', 0);
INSERT INTO `t_areas` VALUES (44557, 8215, NULL, '军垦路街道', 4, 3372, '五家渠市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:05', '2020-08-11 17:37:05', 0);
INSERT INTO `t_areas` VALUES (44558, 8210, NULL, '人民路街道', 4, 3372, '五家渠市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:05', '2020-08-11 17:37:05', 0);
INSERT INTO `t_areas` VALUES (44559, 8216, NULL, '兵团一零一团', 4, 3372, '五家渠市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:05', '2020-08-11 17:37:05', 0);
INSERT INTO `t_areas` VALUES (44560, 8211, NULL, '兵团一零三团', 4, 3372, '五家渠市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:05', '2020-08-11 17:37:05', 0);
INSERT INTO `t_areas` VALUES (44561, 8217, NULL, '青湖路街道', 4, 3372, '五家渠市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:05', '2020-08-11 17:37:05', 0);
INSERT INTO `t_areas` VALUES (44562, 8222, NULL, '阿拉尔农场', 4, 3370, '阿拉尔市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:06', '2020-08-11 17:37:06', 0);
INSERT INTO `t_areas` VALUES (44563, 8218, NULL, '幸福路街道', 4, 3370, '阿拉尔市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:06', '2020-08-11 17:37:06', 0);
INSERT INTO `t_areas` VALUES (44564, 8223, NULL, '兵团第一师幸福农场', 4, 3370, '阿拉尔市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:06', '2020-08-11 17:37:06', 0);
INSERT INTO `t_areas` VALUES (44565, 8219, NULL, '兵团七团', 4, 3370, '阿拉尔市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:06', '2020-08-11 17:37:06', 0);
INSERT INTO `t_areas` VALUES (44566, 8224, NULL, '兵团十一团', 4, 3370, '阿拉尔市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:06', '2020-08-11 17:37:06', 0);
INSERT INTO `t_areas` VALUES (44567, 8225, NULL, '青松路街道', 4, 3370, '阿拉尔市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:06', '2020-08-11 17:37:06', 0);
INSERT INTO `t_areas` VALUES (44568, 8220, NULL, '托喀依乡', 4, 3370, '阿拉尔市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:06', '2020-08-11 17:37:06', 0);
INSERT INTO `t_areas` VALUES (44569, 8226, NULL, '兵团第一师水利水电工程处', 4, 3370, '阿拉尔市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:06', '2020-08-11 17:37:06', 0);
INSERT INTO `t_areas` VALUES (44570, 8227, NULL, '兵团八团', 4, 3370, '阿拉尔市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:06', '2020-08-11 17:37:06', 0);
INSERT INTO `t_areas` VALUES (44571, 8228, NULL, '中心监狱', 4, 3370, '阿拉尔市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:06', '2020-08-11 17:37:06', 0);
INSERT INTO `t_areas` VALUES (44572, 8221, NULL, '兵团第一师塔里木灌区水利管理处', 4, 3370, '阿拉尔市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:06', '2020-08-11 17:37:06', 0);
INSERT INTO `t_areas` VALUES (44573, 8229, NULL, '兵团十四团', 4, 3370, '阿拉尔市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:06', '2020-08-11 17:37:06', 0);
INSERT INTO `t_areas` VALUES (44574, 8232, NULL, '兵团十团', 4, 3370, '阿拉尔市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:06', '2020-08-11 17:37:06', 0);
INSERT INTO `t_areas` VALUES (44575, 8233, NULL, '金银川路街道', 4, 3370, '阿拉尔市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:06', '2020-08-11 17:37:06', 0);
INSERT INTO `t_areas` VALUES (44576, 8234, NULL, '兵团十二团', 4, 3370, '阿拉尔市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:06', '2020-08-11 17:37:06', 0);
INSERT INTO `t_areas` VALUES (44577, 8230, NULL, '兵团十六团', 4, 3370, '阿拉尔市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:06', '2020-08-11 17:37:06', 0);
INSERT INTO `t_areas` VALUES (44578, 8235, NULL, '兵团十三团', 4, 3370, '阿拉尔市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:06', '2020-08-11 17:37:06', 0);
INSERT INTO `t_areas` VALUES (44579, 8231, NULL, '南口街道', 4, 3370, '阿拉尔市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:06', '2020-08-11 17:37:06', 0);
INSERT INTO `t_areas` VALUES (44580, 8237, NULL, '兵团四十九团', 4, 3371, '图木舒克市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:07', '2020-08-11 17:37:07', 0);
INSERT INTO `t_areas` VALUES (44581, 8236, NULL, '兵团图木舒克市永安坝', 4, 3371, '图木舒克市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:07', '2020-08-11 17:37:07', 0);
INSERT INTO `t_areas` VALUES (44582, 8238, NULL, '兵团五十一团', 4, 3371, '图木舒克市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:07', '2020-08-11 17:37:07', 0);
INSERT INTO `t_areas` VALUES (44583, 8239, NULL, '前海街道', 4, 3371, '图木舒克市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:07', '2020-08-11 17:37:07', 0);
INSERT INTO `t_areas` VALUES (44584, 8242, NULL, '兵团图木舒克市喀拉拜勒镇', 4, 3371, '图木舒克市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:07', '2020-08-11 17:37:07', 0);
INSERT INTO `t_areas` VALUES (44585, 8240, NULL, '永安坝街道', 4, 3371, '图木舒克市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:07', '2020-08-11 17:37:07', 0);
INSERT INTO `t_areas` VALUES (44586, 8243, NULL, '齐干却勒街道', 4, 3371, '图木舒克市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:07', '2020-08-11 17:37:07', 0);
INSERT INTO `t_areas` VALUES (44587, 8241, NULL, '兵团五十三团', 4, 3371, '图木舒克市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:07', '2020-08-11 17:37:07', 0);
INSERT INTO `t_areas` VALUES (44588, 8244, NULL, '兵团五十团', 4, 3371, '图木舒克市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:07', '2020-08-11 17:37:07', 0);
INSERT INTO `t_areas` VALUES (44589, 8245, NULL, '兵团四十四团', 4, 3371, '图木舒克市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:07', '2020-08-11 17:37:07', 0);
INSERT INTO `t_areas` VALUES (44590, 8247, NULL, '兵团一三零团', 4, 3465, '胡杨河市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:07', '2020-08-11 17:37:07', 0);
INSERT INTO `t_areas` VALUES (44591, 8246, NULL, '五五新镇街道', 4, 3465, '胡杨河市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:07', '2020-08-11 17:37:07', 0);
INSERT INTO `t_areas` VALUES (44592, 8248, NULL, '兵团一二八团', 4, 3465, '胡杨河市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:07', '2020-08-11 17:37:07', 0);
INSERT INTO `t_areas` VALUES (44593, 8252, NULL, '兵团一二九团', 4, 3465, '胡杨河市', 32, '新疆维吾尔自治区', 10, NULL, '2020-08-11 17:37:07', '2020-08-11 17:37:07', 0);
INSERT INTO `t_areas` VALUES (44594, 8249, 210112, '浑南区', 3, 72, '沈阳市', 7, '辽宁省', 10, NULL, '2020-08-11 17:37:08', '2020-08-11 17:37:08', 0);
INSERT INTO `t_areas` VALUES (44595, 8253, NULL, '峪泉镇', 4, 336, '嘉峪关市', 29, '甘肃省', 10, NULL, '2020-08-11 17:37:09', '2020-08-11 17:37:09', 0);
INSERT INTO `t_areas` VALUES (44596, 8254, NULL, '新城镇', 4, 336, '嘉峪关市', 29, '甘肃省', 10, NULL, '2020-08-11 17:37:09', '2020-08-11 17:37:09', 0);
INSERT INTO `t_areas` VALUES (44597, 8255, NULL, '文殊镇', 4, 336, '嘉峪关市', 29, '甘肃省', 10, NULL, '2020-08-11 17:37:09', '2020-08-11 17:37:09', 0);
INSERT INTO `t_areas` VALUES (44598, 8250, NULL, '雄关街道', 4, 336, '嘉峪关市', 29, '甘肃省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44599, 8256, NULL, '钢城街道', 4, 336, '嘉峪关市', 29, '甘肃省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44600, 8251, NULL, '胡市镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44601, 8257, NULL, '多祥镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44602, 8262, NULL, '沉湖管委会', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44603, 8258, NULL, '黄潭镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44604, 8263, NULL, '干驿镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44605, 8259, NULL, '横林镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44606, 8260, NULL, '马湾镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44607, 8261, NULL, '小板镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44608, 8264, NULL, '蒋湖农场', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44609, 8265, NULL, '多宝镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44610, 8266, NULL, '岳口镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44611, 8267, NULL, '蒋场镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44612, 8272, NULL, '石家河镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44613, 8268, NULL, '彭市镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44614, 8273, NULL, '佛子山镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44615, 8274, NULL, '九真镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44616, 8275, NULL, '竟陵街道', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44617, 8269, NULL, '侨乡街道开发区', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44618, 8270, NULL, '麻洋镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44619, 8271, NULL, '杨林街道', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44620, 8276, NULL, '白茅湖农场', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44621, 8277, NULL, '汪场镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44622, 8278, NULL, '张港镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:10', '2020-08-11 17:37:10', 0);
INSERT INTO `t_areas` VALUES (44623, 8279, NULL, '渔薪镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44624, 8282, NULL, '净潭乡', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44625, 8283, NULL, '皂市镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44626, 8284, NULL, '拖市镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44627, 8280, NULL, '卢市镇', 4, 2065, '天门市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44628, 8281, NULL, '东方华侨农场', 4, 2471, '东方市', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44629, 8285, NULL, '江边乡', 4, 2471, '东方市', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44630, 8286, NULL, '天安乡', 4, 2471, '东方市', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44631, 8288, NULL, '东河镇', 4, 2471, '东方市', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44632, 8287, NULL, '积玉口镇', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44633, 8289, NULL, '新龙镇', 4, 2471, '东方市', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44634, 8292, NULL, '广华街道', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44635, 8293, NULL, '国营广坝农场', 4, 2471, '东方市', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44636, 8294, NULL, '泰丰街道', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44637, 8290, NULL, '周矶管理区', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44638, 8291, NULL, '感城镇', 4, 2471, '东方市', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44639, 8295, NULL, '三家镇', 4, 2471, '东方市', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44640, 8297, NULL, '潜江经济开发区', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44641, 8296, NULL, '四更镇', 4, 2471, '东方市', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44642, 8298, NULL, '周矶街道', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44643, 8302, NULL, '板桥镇', 4, 2471, '东方市', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44644, 8303, NULL, '高场街道', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44645, 8304, NULL, '总口管理区', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44646, 8299, NULL, '八所镇', 4, 2471, '东方市', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44647, 8301, NULL, '大田镇', 4, 2471, '东方市', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44648, 8300, NULL, '运粮湖管理区', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44649, 8305, NULL, '王场镇', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44650, 8306, NULL, '国营中建农场', 4, 2473, '屯昌县', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44651, 8307, NULL, '园林街道', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44652, 8308, NULL, '屯城镇', 4, 2473, '屯昌县', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44653, 8312, NULL, '白鹭湖管理区', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44654, 8309, NULL, '南吕镇', 4, 2473, '屯昌县', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44655, 8310, NULL, '竹根滩镇', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44656, 8313, NULL, '坡心镇', 4, 2473, '屯昌县', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44657, 8311, NULL, '渔洋镇', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44658, 8314, NULL, '新兴镇', 4, 2473, '屯昌县', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44659, 8315, NULL, '西昌镇', 4, 2473, '屯昌县', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44660, 8317, NULL, '熊口镇', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44661, 8318, NULL, '国营中坤农场', 4, 2473, '屯昌县', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44662, 8316, NULL, '后湖管理区', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44663, 8322, NULL, '南坤镇', 4, 2473, '屯昌县', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44664, 8323, NULL, '熊口管理区', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44665, 8319, NULL, '枫木镇', 4, 2473, '屯昌县', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44666, 8324, NULL, '江汉石油管理局', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44667, 8320, NULL, '乌坡镇', 4, 2473, '屯昌县', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44668, 8325, NULL, '张金镇', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44669, 8321, NULL, '杨市街道', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44670, 8326, NULL, '后安镇', 4, 2470, '万宁市', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44671, 8327, NULL, '浩口原种场', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44672, 8332, NULL, '礼纪镇', 4, 2470, '万宁市', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44673, 8328, NULL, '龙湾镇', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44674, 8333, NULL, '国营东兴农场', 4, 2470, '万宁市', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44675, 8334, NULL, '老新镇', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44676, 8329, NULL, '万城镇', 4, 2470, '万宁市', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44677, 8335, NULL, '浩口镇', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44678, 8330, NULL, '国营东和农场', 4, 2470, '万宁市', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44679, 8336, NULL, '高石碑镇', 4, 2064, '潜江市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44680, 8331, NULL, '山根镇', 4, 2470, '万宁市', 22, '海南省', 10, NULL, '2020-08-11 17:37:11', '2020-08-11 17:37:11', 0);
INSERT INTO `t_areas` VALUES (44681, 8337, NULL, '大茂镇', 4, 2470, '万宁市', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44682, 8342, NULL, '和乐镇', 4, 2470, '万宁市', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44683, 8343, NULL, '龙滚镇', 4, 2470, '万宁市', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44684, 8338, NULL, '兴隆华侨农场', 4, 2470, '万宁市', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44685, 8344, NULL, '北大镇', 4, 2470, '万宁市', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44686, 8345, NULL, '国营新中农场', 4, 2470, '万宁市', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44687, 8339, NULL, '三更罗镇', 4, 2470, '万宁市', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44688, 8346, NULL, '长丰镇', 4, 2470, '万宁市', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44689, 8340, NULL, '地方国营六连林场', 4, 2470, '万宁市', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44690, 8341, NULL, '东澳镇', 4, 2470, '万宁市', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44691, 8347, NULL, '南桥镇', 4, 2470, '万宁市', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44692, 8348, NULL, '南宝镇', 4, 2475, '临高县', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44693, 8352, NULL, '畜禽良种场', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44694, 8353, NULL, '博厚镇', 4, 2475, '临高县', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44695, 8349, NULL, '豆河镇', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44696, 8354, NULL, '和舍镇', 4, 2475, '临高县', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44697, 8350, NULL, '沙湖镇', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44698, 8351, NULL, '通海口镇', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44699, 8357, NULL, '调楼镇', 4, 2475, '临高县', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44700, 8355, NULL, '长倘口镇', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44701, 8358, NULL, '波莲镇', 4, 2475, '临高县', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44702, 8356, NULL, '胡场镇', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44703, 8362, NULL, '国营加来农场', 4, 2475, '临高县', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44704, 8359, NULL, '五湖渔场', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44705, 8360, NULL, '多文镇', 4, 2475, '临高县', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44706, 8363, NULL, '新盈镇', 4, 2475, '临高县', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44707, 8361, NULL, '干河街道', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44708, 8364, NULL, '杨林尾镇', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44709, 8367, NULL, '东英镇', 4, 2475, '临高县', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44710, 8368, NULL, '西流河镇', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44711, 8365, NULL, '临城镇', 4, 2475, '临高县', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44712, 8366, NULL, '国营红华农场', 4, 2475, '临高县', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44713, 8369, NULL, '赵西垸林场', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44714, 8372, NULL, '皇桐镇', 4, 2475, '临高县', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44715, 8373, NULL, '九合垸原种场', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44716, 8370, NULL, '彭场镇', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44717, 8371, NULL, '十月田镇', 4, 2477, '昌江黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44718, 8374, NULL, '沔城回族镇', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:12', '2020-08-11 17:37:12', 0);
INSERT INTO `t_areas` VALUES (44719, 8376, NULL, '国营霸王岭林场', 4, 2477, '昌江黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44720, 8375, NULL, '龙华山街道', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44721, 8377, NULL, '乌烈镇', 4, 2477, '昌江黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44722, 8382, NULL, '沙湖原种场', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44723, 8383, NULL, '七叉镇', 4, 2477, '昌江黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44724, 8378, NULL, '陈场镇', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44725, 8384, NULL, '郭河镇', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44726, 8385, NULL, '叉河镇', 4, 2477, '昌江黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44727, 8379, NULL, '海南矿业联合有限公司', 4, 2477, '昌江黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44728, 8386, NULL, '郑场镇', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44729, 8380, NULL, '石碌镇', 4, 2477, '昌江黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44730, 8381, NULL, '排湖风景区', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44731, 8387, NULL, '沙嘴街道', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44732, 8392, NULL, '海尾镇', 4, 2477, '昌江黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44733, 8393, NULL, '国营红林农场', 4, 2477, '昌江黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44734, 8388, NULL, '张沟镇', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44735, 8394, NULL, '王下乡', 4, 2477, '昌江黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44736, 8389, NULL, '昌化镇', 4, 2477, '昌江黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44737, 8395, NULL, '毛嘴镇', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44738, 8390, NULL, '黄竹镇', 4, 2472, '定安县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44739, 8391, NULL, '三伏潭镇', 4, 2063, '仙桃市', 18, '湖北省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44740, 8397, NULL, '富文镇', 4, 2472, '定安县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44741, 8396, NULL, '新竹镇', 4, 2472, '定安县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44742, 8398, NULL, '国营中瑞农场', 4, 2472, '定安县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44743, 8402, NULL, '定城镇', 4, 2472, '定安县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44744, 8399, NULL, '雷鸣镇', 4, 2472, '定安县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44745, 8403, NULL, '翰林镇', 4, 2472, '定安县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44746, 8404, NULL, '岭口镇', 4, 2472, '定安县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44747, 8400, NULL, '国营南海农场', 4, 2472, '定安县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44748, 8401, NULL, '木鱼镇', 4, 2066, '神农架林区', 18, '湖北省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44749, 8405, NULL, '龙门镇', 4, 2472, '定安县', 22, '海南省', 10, NULL, '2020-08-11 17:37:13', '2020-08-11 17:37:13', 0);
INSERT INTO `t_areas` VALUES (44750, 8406, NULL, '下谷坪土家族乡', 4, 2066, '神农架林区', 18, '湖北省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44751, 8407, NULL, '国营金鸡岭农场', 4, 2472, '定安县', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44752, 8408, NULL, '新华镇', 4, 2066, '神农架林区', 18, '湖北省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44753, 8412, NULL, '龙河镇', 4, 2472, '定安县', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44754, 8409, NULL, '九湖镇', 4, 2066, '神农架林区', 18, '湖北省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44755, 8413, NULL, '龙湖镇', 4, 2472, '定安县', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44756, 8414, NULL, '宋洛乡', 4, 2066, '神农架林区', 18, '湖北省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44757, 8415, NULL, '金波乡', 4, 2476, '白沙黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44758, 8410, NULL, '松柏镇', 4, 2066, '神农架林区', 18, '湖北省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44759, 8416, NULL, '红坪镇', 4, 2066, '神农架林区', 18, '湖北省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44760, 8411, NULL, '七坊镇', 4, 2476, '白沙黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44761, 8417, NULL, '阳日镇', 4, 2066, '神农架林区', 18, '湖北省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44762, 8422, NULL, '南开乡', 4, 2476, '白沙黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44763, 8423, NULL, '荣邦乡', 4, 2476, '白沙黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44764, 8418, NULL, '邦溪镇', 4, 2476, '白沙黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44765, 8424, NULL, '青松乡', 4, 2476, '白沙黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44766, 8425, NULL, '细水乡', 4, 2476, '白沙黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44767, 8419, NULL, '国营龙江农场', 4, 2476, '白沙黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44768, 8420, NULL, '元门乡', 4, 2476, '白沙黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44769, 8421, NULL, '牙叉镇', 4, 2476, '白沙黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44770, 8426, NULL, '国营白沙农场', 4, 2476, '白沙黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44771, 8427, NULL, '打安镇', 4, 2476, '白沙黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44772, 8432, NULL, '阜龙乡', 4, 2476, '白沙黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44773, 8428, NULL, '国营邦溪农场', 4, 2476, '白沙黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44774, 8433, NULL, '会山镇', 4, 2467, '琼海市', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44775, 8429, NULL, '嘉积镇', 4, 2467, '琼海市', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44776, 8430, NULL, '国营东太农场', 4, 2467, '琼海市', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44777, 8434, NULL, '国营东升农场', 4, 2467, '琼海市', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44778, 8435, NULL, '大路镇', 4, 2467, '琼海市', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44779, 8436, NULL, '万泉镇', 4, 2467, '琼海市', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44780, 8431, NULL, '彬村山华侨农场', 4, 2467, '琼海市', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44781, 8437, NULL, '国营东红农场', 4, 2467, '琼海市', 22, '海南省', 10, NULL, '2020-08-11 17:37:14', '2020-08-11 17:37:14', 0);
INSERT INTO `t_areas` VALUES (44782, 8442, NULL, '潭门镇', 4, 2467, '琼海市', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44783, 8438, NULL, '塔洋镇', 4, 2467, '琼海市', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44784, 8439, NULL, '中原镇', 4, 2467, '琼海市', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44785, 8443, NULL, '博鳌镇', 4, 2467, '琼海市', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44786, 8444, NULL, '阳江镇', 4, 2467, '琼海市', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44787, 8440, NULL, '龙江镇', 4, 2467, '琼海市', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44788, 8445, NULL, '石壁镇', 4, 2467, '琼海市', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44789, 8441, NULL, '长坡镇', 4, 2467, '琼海市', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44790, 8446, NULL, '什运乡', 4, 2481, '琼中黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44791, 8447, NULL, '吊罗山乡', 4, 2481, '琼中黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44792, 8448, NULL, '国营乌石农场', 4, 2481, '琼中黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44793, 8452, NULL, '和平镇', 4, 2481, '琼中黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44794, 8453, NULL, '湾岭镇', 4, 2481, '琼中黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44795, 8454, NULL, '国营加钗农场', 4, 2481, '琼中黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44796, 8449, NULL, '国营阳江农场', 4, 2481, '琼中黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44797, 8450, NULL, '营根镇', 4, 2481, '琼中黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44798, 8455, NULL, '中平镇', 4, 2481, '琼中黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44799, 8456, NULL, '上安乡', 4, 2481, '琼中黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44800, 8457, NULL, '国营黎母山林业公司', 4, 2481, '琼中黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44801, 8451, NULL, '国营长征农场', 4, 2481, '琼中黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44802, 8462, NULL, '黎母山镇', 4, 2481, '琼中黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44803, 8458, NULL, '长征镇', 4, 2481, '琼中黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44804, 8463, NULL, '红毛镇', 4, 2481, '琼中黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44805, 8459, NULL, '洋浦经济开发区', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44806, 8460, NULL, '光村镇', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44807, 8464, NULL, '兰洋镇', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44808, 8465, NULL, '海头镇', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44809, 8466, NULL, '和庆镇', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44810, 8461, NULL, '国营蓝洋农场', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44811, 8467, NULL, '华南热作学院', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44812, 8472, NULL, '东成镇', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44813, 8468, NULL, '排浦镇', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:15', '2020-08-11 17:37:15', 0);
INSERT INTO `t_areas` VALUES (44814, 8473, NULL, '王五镇', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44815, 8474, NULL, '新州镇', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44816, 8475, NULL, '木棠镇', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44817, 8476, NULL, '中和镇', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44818, 8469, NULL, '国营八一农场', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44819, 8470, NULL, '国营西培农场', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44820, 8471, NULL, '国营西联农场', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44821, 8477, NULL, '雅星镇', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44822, 8482, NULL, '南丰镇', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44823, 8478, NULL, '白马井镇', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44824, 8483, NULL, '峨蔓镇', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44825, 8479, NULL, '大成镇', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44826, 8484, NULL, '那大镇', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44827, 8485, NULL, '三都镇', 4, 2468, '儋州市', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44828, 8480, NULL, '国营山荣农场', 4, 2478, '乐东黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44829, 8481, NULL, '莺歌海镇', 4, 2478, '乐东黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44830, 8487, NULL, '国营保国农场', 4, 2478, '乐东黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44831, 8486, NULL, '万冲镇', 4, 2478, '乐东黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44832, 8492, NULL, '抱由镇', 4, 2478, '乐东黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44833, 8488, NULL, '大安镇', 4, 2478, '乐东黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44834, 8493, NULL, '利国镇', 4, 2478, '乐东黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44835, 8494, NULL, '国营乐光农场', 4, 2478, '乐东黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44836, 8489, NULL, '九所镇', 4, 2478, '乐东黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44837, 8490, NULL, '黄流镇', 4, 2478, '乐东黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44838, 8495, NULL, '佛罗镇', 4, 2478, '乐东黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44839, 8491, NULL, '国营尖峰岭林业公司', 4, 2478, '乐东黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44840, 8496, NULL, '尖峰镇', 4, 2478, '乐东黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44841, 8497, NULL, '千家镇', 4, 2478, '乐东黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44842, 8502, NULL, '国营莺歌海盐场', 4, 2478, '乐东黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44843, 8498, NULL, '志仲镇', 4, 2478, '乐东黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:16', '2020-08-11 17:37:16', 0);
INSERT INTO `t_areas` VALUES (44844, 8499, NULL, '福山镇', 4, 2474, '澄迈县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44845, 8503, NULL, '永发镇', 4, 2474, '澄迈县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44846, 8500, NULL, '金江镇', 4, 2474, '澄迈县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44847, 8504, NULL, '文儒镇', 4, 2474, '澄迈县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44848, 8505, NULL, '中兴镇', 4, 2474, '澄迈县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44849, 8501, NULL, '老城镇', 4, 2474, '澄迈县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44850, 8506, NULL, '国营红岗农场', 4, 2474, '澄迈县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44851, 8507, NULL, '瑞溪镇', 4, 2474, '澄迈县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44852, 8512, NULL, '国营红光农场', 4, 2474, '澄迈县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44853, 8513, NULL, '大丰镇', 4, 2474, '澄迈县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44854, 8508, NULL, '仁兴镇', 4, 2474, '澄迈县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44855, 8514, NULL, '加乐镇', 4, 2474, '澄迈县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44856, 8509, NULL, '国营金安农场', 4, 2474, '澄迈县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44857, 8515, NULL, '国营昆仑农场', 4, 2474, '澄迈县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44858, 8516, NULL, '济源市坡头镇', 4, 195, '济源市', 17, '河南省', 20, NULL, '2020-08-11 17:37:17', '2020-09-24 19:39:08', 0);
INSERT INTO `t_areas` VALUES (44859, 8517, NULL, '国营西达农场', 4, 2474, '澄迈县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44860, 8510, NULL, '济源市梨林镇', 4, 195, '济源市', 17, '河南省', 20, NULL, '2020-08-11 17:37:17', '2020-09-24 19:39:35', 0);
INSERT INTO `t_areas` VALUES (44861, 8511, NULL, '国营和岭农场', 4, 2474, '澄迈县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44862, 8518, NULL, '济源市大峪镇', 4, 195, '济源市', 17, '河南省', 20, NULL, '2020-08-11 17:37:17', '2020-09-24 19:39:37', 0);
INSERT INTO `t_areas` VALUES (44863, 8519, NULL, '济源市思礼镇', 4, 195, '济源市', 17, '河南省', 20, NULL, '2020-08-11 17:37:17', '2020-09-24 19:39:39', 0);
INSERT INTO `t_areas` VALUES (44864, 8522, NULL, '济源市五龙口镇', 4, 195, '济源市', 17, '河南省', 20, NULL, '2020-08-11 17:37:17', '2020-09-24 19:39:41', 0);
INSERT INTO `t_areas` VALUES (44865, 8523, NULL, '济源市王屋镇', 4, 195, '济源市', 17, '河南省', 20, NULL, '2020-08-11 17:37:17', '2020-09-24 19:39:46', 0);
INSERT INTO `t_areas` VALUES (44866, 8524, NULL, '椰林镇', 4, 2479, '陵水黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44867, 8525, NULL, '济源市玉泉街道', 4, 195, '济源市', 17, '河南省', 20, NULL, '2020-08-11 17:37:17', '2020-09-24 21:52:45', 0);
INSERT INTO `t_areas` VALUES (44868, 8520, NULL, '黎安镇', 4, 2479, '陵水黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44869, 8521, NULL, '新村镇', 4, 2479, '陵水黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44870, 8526, NULL, '济源市轵城镇', 4, 195, '济源市', 17, '河南省', 20, NULL, '2020-08-11 17:37:17', '2020-09-24 21:52:45', 0);
INSERT INTO `t_areas` VALUES (44871, 8527, NULL, '文罗镇', 4, 2479, '陵水黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44872, 8532, NULL, '济源市济水街道', 4, 195, '济源市', 17, '河南省', 20, NULL, '2020-08-11 17:37:17', '2020-09-24 21:52:45', 0);
INSERT INTO `t_areas` VALUES (44873, 8528, NULL, '国营吊罗山林业公司', 4, 2479, '陵水黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44874, 8533, NULL, '济源市沁园街道', 4, 195, '济源市', 17, '河南省', 20, NULL, '2020-08-11 17:37:17', '2020-09-24 21:52:45', 0);
INSERT INTO `t_areas` VALUES (44875, 8529, NULL, '国营南平农场', 4, 2479, '陵水黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44876, 8534, NULL, '济源市下冶镇', 4, 195, '济源市', 17, '河南省', 20, NULL, '2020-08-11 17:37:17', '2020-09-24 21:52:45', 0);
INSERT INTO `t_areas` VALUES (44877, 8530, NULL, '本号镇', 4, 2479, '陵水黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44878, 8531, NULL, '济源市克井镇', 4, 195, '济源市', 17, '河南省', 20, NULL, '2020-08-11 17:37:17', '2020-09-24 21:52:45', 0);
INSERT INTO `t_areas` VALUES (44879, 8535, NULL, '光坡镇', 4, 2479, '陵水黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44880, 8536, NULL, '济源市天坛街道', 4, 195, '济源市', 17, '河南省', 20, NULL, '2020-08-11 17:37:17', '2020-09-24 21:52:45', 0);
INSERT INTO `t_areas` VALUES (44881, 8537, NULL, '群英乡', 4, 2479, '陵水黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44882, 8542, NULL, '济源市邵原镇', 4, 195, '济源市', 17, '河南省', 20, NULL, '2020-08-11 17:37:17', '2020-09-24 21:52:45', 0);
INSERT INTO `t_areas` VALUES (44883, 8538, NULL, '三才镇', 4, 2479, '陵水黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44884, 8543, NULL, '济源市北海街道', 4, 195, '济源市', 17, '河南省', 20, NULL, '2020-08-11 17:37:17', '2020-09-24 21:52:45', 0);
INSERT INTO `t_areas` VALUES (44885, 8539, NULL, '提蒙乡', 4, 2479, '陵水黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44886, 8544, NULL, '济源市承留镇', 4, 195, '济源市', 17, '河南省', 20, NULL, '2020-08-11 17:37:17', '2020-09-24 21:52:45', 0);
INSERT INTO `t_areas` VALUES (44887, 8545, NULL, '隆广镇', 4, 2479, '陵水黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44888, 8540, NULL, '国营岭门农场', 4, 2479, '陵水黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44889, 8541, NULL, '英州镇', 4, 2479, '陵水黎族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:17', '2020-08-11 17:37:17', 0);
INSERT INTO `t_areas` VALUES (44890, 8546, NULL, '东阁镇', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44891, 8547, NULL, '文教镇', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44892, 8552, NULL, '国营罗豆农场', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44893, 8548, NULL, '会文镇', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44894, 8553, NULL, '国营东路农场', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44895, 8554, NULL, '东郊镇', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44896, 8555, NULL, '翁田镇', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44897, 8549, NULL, '铺前镇', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44898, 8550, NULL, '锦山镇', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44899, 8556, NULL, '龙楼镇', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44900, 8551, NULL, '冯坡镇', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44901, 8557, NULL, '国营南阳农场', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44902, 8562, NULL, '公坡镇', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44903, 8563, NULL, '昌洒镇', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44904, 8558, NULL, '抱罗镇', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44905, 8559, NULL, '东路镇', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44906, 8564, NULL, '潭牛镇', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44907, 8565, NULL, '蓬莱镇', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44908, 8560, NULL, '重兴镇', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44909, 8566, NULL, '文城镇', 4, 2469, '文昌市', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44910, 8567, NULL, '海南保亭热带作物研究所', 4, 2480, '保亭黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44911, 8561, NULL, '新政镇', 4, 2480, '保亭黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44912, 8572, NULL, '加茂镇', 4, 2480, '保亭黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44913, 8573, NULL, '国营金江农场', 4, 2480, '保亭黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:18', '2020-08-11 17:37:18', 0);
INSERT INTO `t_areas` VALUES (44914, 8568, NULL, '国营新星农场', 4, 2480, '保亭黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:19', '2020-08-11 17:37:19', 0);
INSERT INTO `t_areas` VALUES (44915, 8569, NULL, '保城镇', 4, 2480, '保亭黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:19', '2020-08-11 17:37:19', 0);
INSERT INTO `t_areas` VALUES (44916, 8574, NULL, '南林乡', 4, 2480, '保亭黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:19', '2020-08-11 17:37:19', 0);
INSERT INTO `t_areas` VALUES (44917, 8575, NULL, '国营三道农场', 4, 2480, '保亭黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:19', '2020-08-11 17:37:19', 0);
INSERT INTO `t_areas` VALUES (44918, 8570, NULL, '毛感乡', 4, 2480, '保亭黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:19', '2020-08-11 17:37:19', 0);
INSERT INTO `t_areas` VALUES (44919, 8576, NULL, '三道镇', 4, 2480, '保亭黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:19', '2020-08-11 17:37:19', 0);
INSERT INTO `t_areas` VALUES (44920, 8571, NULL, '什玲镇', 4, 2480, '保亭黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:19', '2020-08-11 17:37:19', 0);
INSERT INTO `t_areas` VALUES (44921, 8577, NULL, '六弓乡', 4, 2480, '保亭黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:19', '2020-08-11 17:37:19', 0);
INSERT INTO `t_areas` VALUES (44922, 8578, NULL, '响水镇', 4, 2480, '保亭黎族苗族自治县', 22, '海南省', 10, NULL, '2020-08-11 17:37:19', '2020-08-11 17:37:19', 0);
INSERT INTO `t_areas` VALUES (44923, 8582, NULL, '南圣镇', 4, 2466, '五指山市', 22, '海南省', 10, NULL, '2020-08-11 17:37:19', '2020-08-11 17:37:19', 0);
INSERT INTO `t_areas` VALUES (44924, 8579, NULL, '毛阳镇', 4, 2466, '五指山市', 22, '海南省', 10, NULL, '2020-08-11 17:37:19', '2020-08-11 17:37:19', 0);
INSERT INTO `t_areas` VALUES (44925, 8583, NULL, '通什镇', 4, 2466, '五指山市', 22, '海南省', 10, NULL, '2020-08-11 17:37:19', '2020-08-11 17:37:19', 0);
INSERT INTO `t_areas` VALUES (44926, 8580, NULL, '水满乡', 4, 2466, '五指山市', 22, '海南省', 10, NULL, '2020-08-11 17:37:19', '2020-08-11 17:37:19', 0);
INSERT INTO `t_areas` VALUES (44927, 8584, NULL, '番阳镇', 4, 2466, '五指山市', 22, '海南省', 10, NULL, '2020-08-11 17:37:19', '2020-08-11 17:37:19', 0);
INSERT INTO `t_areas` VALUES (44928, 8581, NULL, '畅好乡', 4, 2466, '五指山市', 22, '海南省', 10, NULL, '2020-08-11 17:37:19', '2020-08-11 17:37:19', 0);
INSERT INTO `t_areas` VALUES (44929, 8585, NULL, '毛道乡', 4, 2466, '五指山市', 22, '海南省', 10, NULL, '2020-08-11 17:37:19', '2020-08-11 17:37:19', 0);
INSERT INTO `t_areas` VALUES (44930, 8586, NULL, '国营畅好农场', 4, 2466, '五指山市', 22, '海南省', 10, NULL, '2020-08-11 17:37:19', '2020-08-11 17:37:19', 0);
INSERT INTO `t_areas` VALUES (44931, 8587, NULL, '三角镇', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:24', '2020-08-11 17:37:24', 0);
INSERT INTO `t_areas` VALUES (44932, 8592, NULL, '横栏镇', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:24', '2020-08-11 17:37:24', 0);
INSERT INTO `t_areas` VALUES (44933, 8593, NULL, '五桂山街道', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:24', '2020-08-11 17:37:24', 0);
INSERT INTO `t_areas` VALUES (44934, 8588, NULL, '东升镇', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:24', '2020-08-11 17:37:24', 0);
INSERT INTO `t_areas` VALUES (44935, 8589, NULL, '神湾镇', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:24', '2020-08-11 17:37:24', 0);
INSERT INTO `t_areas` VALUES (44936, 8590, NULL, '火炬开发区街道', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:24', '2020-08-11 17:37:24', 0);
INSERT INTO `t_areas` VALUES (44937, 8594, NULL, '小榄镇', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:24', '2020-08-11 17:37:24', 0);
INSERT INTO `t_areas` VALUES (44938, 8591, NULL, '南朗镇', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44939, 8597, NULL, '古镇镇', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44940, 8595, NULL, '民众镇', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44941, 8598, NULL, '港口镇', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44942, 8596, NULL, '石岐区街道', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44943, 8599, NULL, '三乡镇', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44944, 8602, NULL, '大涌镇', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44945, 8603, NULL, '南头镇', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44946, 8604, NULL, '黄圃镇', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44947, 8600, NULL, '东区街道', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44948, 8605, NULL, '坦洲镇', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44949, 8601, NULL, '阜沙镇', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44950, 8606, NULL, '西区街道', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44951, 8607, NULL, '板芙镇', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44952, 8612, NULL, '南区街道', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44953, 8613, NULL, '沙溪镇', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44954, 8608, NULL, '东凤镇', 4, 253, '中山市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44955, 8614, NULL, '莞城街道', 4, 252, '东莞市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44956, 8609, NULL, '东莞生态园', 4, 252, '东莞市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44957, 8615, NULL, '松山湖管委会', 4, 252, '东莞市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44958, 8610, NULL, '石龙镇', 4, 252, '东莞市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44959, 8616, NULL, '南城街道', 4, 252, '东莞市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44960, 8611, NULL, '虎门港管委会', 4, 252, '东莞市', 20, '广东省', 10, NULL, '2020-08-11 17:37:25', '2020-08-11 17:37:25', 0);
INSERT INTO `t_areas` VALUES (44961, 8617, NULL, '东城街道', 4, 252, '东莞市', 20, '广东省', 10, NULL, '2020-08-11 17:37:26', '2020-08-11 17:37:26', 0);
INSERT INTO `t_areas` VALUES (44962, 8622, NULL, '长安镇', 4, 252, '东莞市', 20, '广东省', 10, NULL, '2020-08-11 17:37:26', '2020-08-11 17:37:26', 0);
INSERT INTO `t_areas` VALUES (44963, 8618, NULL, '万江街道', 4, 252, '东莞市', 20, '广东省', 10, NULL, '2020-08-11 17:37:26', '2020-08-11 17:37:26', 0);
COMMIT;

-- ----------------------------
-- Table structure for t_file_info
-- ----------------------------
DROP TABLE IF EXISTS `t_file_info`;
CREATE TABLE `t_file_info` (
  `id` varchar(32) NOT NULL COMMENT '文件md5',
  `name` varchar(128) NOT NULL,
  `is_img` tinyint(1) NOT NULL,
  `content_type` varchar(128) NOT NULL,
  `size` int(11) NOT NULL,
  `path` varchar(255) DEFAULT NULL COMMENT '物理路径',
  `url` varchar(1024) NOT NULL,
  `source` varchar(32) NOT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `createTime` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文件信息表';

-- ----------------------------
-- Table structure for t_operate_log
-- ----------------------------
DROP TABLE IF EXISTS `t_operate_log`;
CREATE TABLE `t_operate_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ip` varchar(32) DEFAULT NULL,
  `client` varchar(32) DEFAULT NULL,
  `business_type` varchar(32) DEFAULT NULL,
  `business_key` varchar(32) DEFAULT NULL,
  `operate_type` smallint(4) DEFAULT NULL,
  `content` varchar(1024) DEFAULT NULL,
  `create_role` tinyint(4) DEFAULT NULL,
  `create_user_id` bigint(11) NOT NULL DEFAULT '0' COMMENT '添加人',
  `update_user_id` bigint(11) NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=857 DEFAULT CHARSET=utf8mb4 COMMENT='公用操作日志表';

-- ----------------------------
-- Table structure for tenant_base
-- ----------------------------
DROP TABLE IF EXISTS `tenant_base`;
CREATE TABLE `tenant_base` (
  `tenant_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键（租户ID）-',
  `name` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '租户名称',
  `full_name` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '租户全称',
  `tenant_type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '租户类型 1:企业 2:个人',
  `credit_code` varchar(128) CHARACTER SET utf8 DEFAULT NULL COMMENT '社会信用代码',
  `province_id` int(11) NOT NULL DEFAULT '0' COMMENT '省id',
  `city_id` int(11) NOT NULL DEFAULT '0' COMMENT '市id',
  `district_id` int(11) NOT NULL DEFAULT '0' COMMENT '地区id',
  `detail_address` varchar(256) CHARACTER SET utf8 DEFAULT '' COMMENT '详细地址',
  `legal_person` varchar(32) CHARACTER SET utf8 NOT NULL DEFAULT '0' COMMENT '法定代表人',
  `business_start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '营业期开始时间',
  `business_end_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '营业期结束时间',
  `business_user_id` bigint(11) DEFAULT NULL COMMENT '商务经理',
  `is_general_tax` tinyint(2) DEFAULT '0' COMMENT '是否为一般纳税人 0:否 1:是',
  `register_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '入驻日期',
  `create_user_id` bigint(11) DEFAULT NULL COMMENT '创建人UID',
  `update_user_id` bigint(11) DEFAULT NULL COMMENT '更新人UID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '删除标识(0:默认 1:删除)',
  `remark` varchar(512) CHARACTER SET utf8 DEFAULT NULL,
  `link_nick_name` varchar(50) DEFAULT NULL COMMENT '联系人昵称',
  `link_tel` varchar(50) DEFAULT NULL COMMENT '联系手机号',
  PRIMARY KEY (`tenant_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE COMMENT '租户ID索引'
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COMMENT='租户信息表';

-- ----------------------------
-- Records of tenant_base
-- ----------------------------
BEGIN;
INSERT INTO `tenant_base` VALUES (1, '艾佳生活', '江苏艾佳生活家居用品有限公司', 1, NULL, 0, 0, 0, '', '0', '2020-11-30 11:56:28', '2020-11-30 11:56:28', NULL, 0, '2020-11-30 11:56:28', -1, NULL, '2020-11-30 11:56:28', '2020-11-30 11:56:28', 0, '江苏艾佳生活家居用品有限公司', '孙军洪', '18136877048');
COMMIT;

-- ----------------------------
-- Table structure for tenant_ext
-- ----------------------------
DROP TABLE IF EXISTS `tenant_ext`;
CREATE TABLE `tenant_ext` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tenant_id` bigint(11) NOT NULL COMMENT '租户编码',
  `business_range` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '经营范围',
  `service_type` varchar(128) CHARACTER SET utf8 DEFAULT NULL COMMENT '施工方式，支持多个，json数组方式存储，如：[1,2]',
  `service_area` varchar(512) CHARACTER SET utf8 DEFAULT NULL COMMENT '服务区域，如：[{"provinceId":12,"provinceName":"浙江省","cityList":[{"cityId":130,"cityName":"舟山市","districtList":[{"districtId":130,"districtName":"xxxx区"}]}]},{"provinceId":8,"provinceName":"吉林省","cityList":[{"cityId":93,"cityName":"白城市","districtList":[{"districtId":130,"districtName":"xxxx区"}]}]}]',
  `create_user_id` bigint(11) DEFAULT NULL COMMENT '创建人UID',
  `update_user_id` bigint(11) DEFAULT NULL COMMENT '更新人UID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '删除标识(0:默认 1:删除)',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE COMMENT '租户ID索引'
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COMMENT='租户扩展信息表';

-- ----------------------------
-- Records of tenant_ext
-- ----------------------------
BEGIN;
INSERT INTO `tenant_ext` VALUES (123, 1, NULL, NULL, NULL, NULL, NULL, '2020-11-30 11:56:28', '2020-11-30 11:56:28', 0);
COMMIT;

-- ----------------------------
-- Table structure for tenant_file
-- ----------------------------
DROP TABLE IF EXISTS `tenant_file`;
CREATE TABLE `tenant_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tenant_id` bigint(11) NOT NULL COMMENT '租户编码',
  `file_type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '文件类型 1:营业执照 2:一般纳税人证明',
  `file_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '文件名称',
  `file_url` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件url',
  `create_user_id` bigint(11) DEFAULT NULL COMMENT '创建人UID',
  `update_user_id` bigint(11) DEFAULT NULL COMMENT '更新人UID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '删除标识(0:默认 1:删除)',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE COMMENT '租户ID索引'
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COMMENT='租户信息表';

-- ----------------------------
-- Table structure for tenant_menu_relate
-- ----------------------------
DROP TABLE IF EXISTS `tenant_menu_relate`;
CREATE TABLE `tenant_menu_relate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  `del_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '删除标识',
  `create_by` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE COMMENT '租户ID索引'
) ENGINE=InnoDB AUTO_INCREMENT=3825 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tenant_menu_relate
-- ----------------------------
BEGIN;
INSERT INTO `tenant_menu_relate` VALUES (3727, 1, 2000, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3728, 1, 2001, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3729, 1, 2002, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3730, 1, 2003, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3731, 1, 2004, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3732, 1, 2006, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3733, 1, 2005, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3734, 1, 2007, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3735, 1, 2008, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3736, 1, 1, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3737, 1, 100, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3738, 1, 101, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3739, 1, 103, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3740, 1, 104, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3741, 1, 1001, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3742, 1, 1002, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3743, 1, 1003, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3744, 1, 1004, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3745, 1, 1005, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3746, 1, 1006, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3747, 1, 1007, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3748, 1, 1008, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3749, 1, 1009, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3750, 1, 1010, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3751, 1, 1011, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3752, 1, 1012, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3753, 1, 1017, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3754, 1, 1018, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3755, 1, 1019, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3756, 1, 1020, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3757, 1, 1021, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3758, 1, 1022, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3759, 1, 1023, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3760, 1, 1024, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3761, 1, 1025, 0, -1, '2020-11-30 11:56:29', NULL, '2020-11-30 11:56:29');
INSERT INTO `tenant_menu_relate` VALUES (3762, 1, 2, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3763, 1, 3, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3764, 1, 102, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3765, 1, 105, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3766, 1, 106, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3767, 1, 107, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3768, 1, 108, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3769, 1, 109, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3770, 1, 110, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3771, 1, 111, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3772, 1, 112, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3773, 1, 113, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3774, 1, 114, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3775, 1, 115, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3776, 1, 500, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3777, 1, 501, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3778, 1, 1013, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3779, 1, 1014, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3780, 1, 1015, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3781, 1, 1016, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3782, 1, 1026, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3783, 1, 1027, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3784, 1, 1028, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3785, 1, 1029, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3786, 1, 1030, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3787, 1, 1031, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3788, 1, 1032, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3789, 1, 1033, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3790, 1, 1034, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3791, 1, 1035, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3792, 1, 1036, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3793, 1, 1037, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3794, 1, 1038, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3795, 1, 1039, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3796, 1, 1040, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3797, 1, 1041, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3798, 1, 1042, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3799, 1, 1043, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3800, 1, 1044, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3801, 1, 1045, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3802, 1, 1046, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3803, 1, 1047, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3804, 1, 1048, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3805, 1, 1049, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3806, 1, 1050, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3807, 1, 1051, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3808, 1, 1052, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3809, 1, 1053, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3810, 1, 1054, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3811, 1, 1055, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3812, 1, 1056, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3813, 1, 1057, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3814, 1, 1058, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3815, 1, 1059, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3816, 1, 1060, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
INSERT INTO `tenant_menu_relate` VALUES (3817, 1, 2011, 0, -1, '2020-11-30 13:13:05', NULL, '2020-11-30 13:13:05');
COMMIT;

-- ----------------------------
-- Table structure for tenant_op_record
-- ----------------------------
DROP TABLE IF EXISTS `tenant_op_record`;
CREATE TABLE `tenant_op_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` int(11) DEFAULT NULL COMMENT '操作人id',
  `item_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作项id',
  `op_type` smallint(2) NOT NULL DEFAULT '0' COMMENT '操作类型：1.新增 2.更新 3.删除',
  `op_content` text CHARACTER SET utf8 COMMENT '操作内容',
  `op_result` tinyint(2) DEFAULT '0' COMMENT '操作结果：1.成功 2.失败',
  `op_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  `tenant_id` bigint(11) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_item_id` (`item_id`) USING BTREE COMMENT '操作项ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作记录表';

-- ----------------------------
-- Table structure for tenant_user
-- ----------------------------
DROP TABLE IF EXISTS `tenant_user`;
CREATE TABLE `tenant_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tenant_id` bigint(11) NOT NULL COMMENT '租户编码',
  `user_id` bigint(20) NOT NULL COMMENT '租户名称',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门名称',
  `create_user_id` bigint(11) DEFAULT NULL COMMENT '创建人UID',
  `update_user_id` bigint(11) DEFAULT NULL COMMENT '更新人UID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '删除标识(0:默认 1:删除)',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态：1，在用 2，关闭',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE COMMENT '用户ID索引',
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE COMMENT '租户ID索引'
) ENGINE=InnoDB AUTO_INCREMENT=262707 DEFAULT CHARSET=utf8mb4 COMMENT='租户与用户关联表';

-- ----------------------------
-- Records of tenant_user
-- ----------------------------
BEGIN;
INSERT INTO `tenant_user` VALUES (262706, 1, 1, 287, NULL, NULL, '2020-11-30 11:56:29', '2020-11-30 11:56:29', 0, 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
