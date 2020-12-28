DROP TABLE IF EXISTS `crm_assign`;
CREATE TABLE `crm_assign` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `manager_id` bigint(20) NOT NULL COMMENT '责任人ID',
  `manager_type` int(11) NOT NULL COMMENT '责任人类型（0，个人，1 群体）',
  `target_id` bigint(20) NOT NULL COMMENT '目标ID',
  `target_type` varchar(32) NOT NULL COMMENT '目标类型',
  `assign_role` tinyint(4) NOT NULL COMMENT '分配责任角色',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_by` bigint(20) DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_target_id` (`target_id`) USING BTREE COMMENT '对象ID索引',
  KEY `idx_manager_id` (`manager_id`) USING BTREE COMMENT '责任人ID索引'
) ENGINE=InnoDB AUTO_INCREMENT=218 DEFAULT CHARSET=utf8mb4 COMMENT='责任分配关系表';

-- ----------------------------
-- Table structure for crm_business
-- ----------------------------
DROP TABLE IF EXISTS `crm_business`;
CREATE TABLE `crm_business` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `business_name` varchar(64) NOT NULL COMMENT '商机名',
  `clue_id` bigint(20) DEFAULT NULL COMMENT '线索id',
  `customer_id` bigint(11) NOT NULL COMMENT '客户id',
  `template_id` bigint(11) DEFAULT NULL COMMENT '阶段模板id',
  `current_stage_code` varchar(64) NOT NULL DEFAULT '' COMMENT '当前商机阶段',
  `estimate_deal_amount` decimal(14,2) NOT NULL COMMENT '预估成交金额',
  `estimate_deal_date` date NOT NULL COMMENT '预估成交时间',
  `real_deal_date` date DEFAULT NULL COMMENT '成交日期',
  `lose_reason` varchar(32) DEFAULT NULL COMMENT '输单原因',
  `lose_desc` varchar(255) DEFAULT NULL COMMENT '输单描述',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_by` bigint(20) DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_global_query` (`business_name`,`customer_id`,`current_stage_code`,`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COMMENT='商机主表';

-- ----------------------------
-- Table structure for crm_business_contact_relate
-- ----------------------------
DROP TABLE IF EXISTS `crm_business_contact_relate`;
CREATE TABLE `crm_business_contact_relate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `business_id` bigint(20) NOT NULL COMMENT '商机id',
  `type` varchar(16) NOT NULL DEFAULT '' COMMENT '用户类型C/1W',
  `contact_id` bigint(20) NOT NULL COMMENT '关联用户id',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_business_id` (`business_id`,`contact_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COMMENT='商机关联联系人';

-- ----------------------------
-- Table structure for crm_business_process
-- ----------------------------
DROP TABLE IF EXISTS `crm_business_process`;
CREATE TABLE `crm_business_process` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `business_id` bigint(11) NOT NULL COMMENT '商机id',
  `template_code` varchar(64) NOT NULL DEFAULT '' COMMENT '阶段模板编号',
  `template_id` bigint(20) NOT NULL COMMENT '阶段模板id',
  `before_stage_code` varchar(64) NOT NULL DEFAULT '' COMMENT '上一阶段',
  `after_stage_code` varchar(64) NOT NULL DEFAULT '' COMMENT '下一阶段',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_by` bigint(20) DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_business_id` (`business_id`,`template_id`,`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COMMENT='商机阶段流程表';

-- ----------------------------
-- Table structure for crm_clue
-- ----------------------------
DROP TABLE IF EXISTS `crm_clue`;
CREATE TABLE `crm_clue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `clue_source` varchar(32) NOT NULL COMMENT '线索来源',
  `clue_status` varchar(32) NOT NULL DEFAULT '1' COMMENT '线索状态 1跟进中 2 已转换 0已作废',
  `informant_name` varchar(32) NOT NULL DEFAULT '' COMMENT '线索人姓名',
  `informant_mobile` varchar(32) DEFAULT '' COMMENT '线索人手机号',
  `informant_wechat` varchar(64) DEFAULT '' COMMENT '线索人微信号',
  `company_id` varchar(64) DEFAULT '' COMMENT '缓存工商信息id',
  `company_name` varchar(128) NOT NULL DEFAULT '' COMMENT '公司名称',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_by` bigint(20) DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_global_query` (`clue_source`,`clue_status`,`informant_name`,`informant_mobile`,`company_name`,`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COMMENT='线索主表';

-- ----------------------------
-- Table structure for crm_company_info
-- ----------------------------
DROP TABLE IF EXISTS `crm_company_info`;
CREATE TABLE `crm_company_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `credit_code` varchar(255) NOT NULL DEFAULT '' COMMENT '信用编号',
  `company_name` varchar(255) DEFAULT '' COMMENT '公司名',
  `basic_info` mediumtext COMMENT '基础信息',
  `shareholder_info` varchar(2500) DEFAULT '' COMMENT '股东信息',
  `member_info` varchar(2500) DEFAULT '' COMMENT '主要人员信息',
  `change_info` text COMMENT '变更信息',
  `branch_info` text COMMENT '分支机构信息',
  `operation_info` varchar(2500) DEFAULT '' COMMENT '经营信息',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COMMENT='企业工商信息';

-- ----------------------------
-- Table structure for crm_contact
-- ----------------------------
DROP TABLE IF EXISTS `crm_contact`;
CREATE TABLE `crm_contact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '联系人姓名',
  `customer_id` bigint(20) NOT NULL COMMENT '所属客户',
  `apartment` varchar(255) DEFAULT '' COMMENT '部门',
  `position` varchar(255) DEFAULT '' COMMENT '职务',
  `mobile` varchar(255) DEFAULT '' COMMENT '手机号',
  `wechat` varchar(255) DEFAULT '' COMMENT '微信号',
  `sex` tinyint(4) DEFAULT NULL COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `email` varchar(255) DEFAULT '' COMMENT 'email',
  `stand_score` int(11) DEFAULT NULL COMMENT '立场分',
  `ext_info` varchar(255) DEFAULT NULL COMMENT '扩展信息',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_by` bigint(20) DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_customer_id` (`customer_id`) USING BTREE COMMENT '客户ID索引',
  KEY `idx_mobile` (`mobile`) USING BTREE COMMENT '手机号索引'
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COMMENT='联系人表';

-- ----------------------------
-- Table structure for crm_customer
-- ----------------------------
DROP TABLE IF EXISTS `crm_customer`;
CREATE TABLE `crm_customer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_name` varchar(255) DEFAULT NULL COMMENT '客户名称',
  `customer_level` varchar(255) DEFAULT NULL COMMENT '客户级别',
  `source` varchar(50) DEFAULT NULL COMMENT '客户来源',
  `profession` varchar(255) DEFAULT NULL COMMENT '客户所在行业',
  `province_code` bigint(10) DEFAULT NULL COMMENT '省code',
  `city_code` bigint(10) DEFAULT NULL COMMENT 'cityCode',
  `region_code` bigint(10) DEFAULT NULL COMMENT '区域code',
  `company_id` varchar(100) DEFAULT NULL COMMENT '公司唯一标识',
  `address` varchar(255) DEFAULT NULL COMMENT '公司地址',
  `url` varchar(255) DEFAULT NULL COMMENT '公司网址',
  `employee_no` int(11) DEFAULT NULL COMMENT '公司人数',
  `clue_id` bigint(20) DEFAULT NULL COMMENT '线索来源',
  `ext_info` varchar(255) DEFAULT NULL COMMENT '扩展信息',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_by` bigint(20) DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_customer_name` (`customer_name`) USING BTREE COMMENT '客户名称索引'
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COMMENT='客户主表';

-- ----------------------------
-- Table structure for crm_follow
-- ----------------------------
DROP TABLE IF EXISTS `crm_follow`;
CREATE TABLE `crm_follow` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `target_type` varchar(20) DEFAULT NULL COMMENT '跟进目标类型（0，线索，1，客户，2联系人，3商机）',
  `target_id` bigint(20) DEFAULT NULL COMMENT '跟进目标ID',
  `follow_type` varchar(32) DEFAULT NULL COMMENT '记录类型（0，电话，1微信，2拜访）',
  `follow_sub_type` varchar(32) DEFAULT NULL COMMENT '记录子类型',
  `content` varchar(2000) DEFAULT NULL COMMENT '跟进内容',
  `files` varchar(2000) DEFAULT NULL COMMENT '文件列表',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_by` bigint(20) DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_create_by` (`create_by`) USING BTREE COMMENT '跟进人索引',
  KEY `idx_target_id` (`target_id`) USING BTREE COMMENT '目标ID索引'
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8mb4 COMMENT='跟进表';

-- ----------------------------
-- Table structure for crm_template
-- ----------------------------
DROP TABLE IF EXISTS `crm_template`;
CREATE TABLE `crm_template` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(64) NOT NULL DEFAULT '' COMMENT '模板编码',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '模板名称',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '生效状态 0否 1生效',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_by` bigint(20) DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COMMENT='模板表';

-- ----------------------------
-- Records of crm_template
-- ----------------------------
BEGIN;
INSERT INTO `crm_template` VALUES (1, 'template_v1', '版本一模板', 1, 1, '0', 0, '2020-11-30 11:06:50', 0, '2020-11-30 11:06:50', NULL);
COMMIT;

-- ----------------------------
-- Table structure for crm_template_stage
-- ----------------------------
DROP TABLE IF EXISTS `crm_template_stage`;
CREATE TABLE `crm_template_stage` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `code` varchar(64) NOT NULL DEFAULT '' COMMENT '子阶段编码',
  `template_code` varchar(64) NOT NULL DEFAULT '' COMMENT '父模板编码',
  `template_id` bigint(20) DEFAULT NULL COMMENT '父模板id',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '阶段名',
  `sort` int(11) NOT NULL COMMENT '排序',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_by` bigint(20) DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_template_id` (`template_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COMMENT='模板阶段表';

-- ----------------------------
-- Records of crm_template_stage
-- ----------------------------
BEGIN;
INSERT INTO `crm_template_stage` VALUES (92, 'demand_guidance', 'template_v1', 1, '需求引导', 1, 1, '0', 0, '2020-11-30 11:06:50', 0, '2020-11-30 11:06:50', NULL);
INSERT INTO `crm_template_stage` VALUES (93, 'value_presentation', 'template_v1', 1, '价值呈现', 2, 1, '0', 0, '2020-11-30 11:06:50', 0, '2020-11-30 11:06:50', NULL);
INSERT INTO `crm_template_stage` VALUES (94, 'program_competition', 'template_v1', 1, '方案竞争', 3, 1, '0', 0, '2020-11-30 11:06:50', 0, '2020-11-30 11:06:50', NULL);
INSERT INTO `crm_template_stage` VALUES (95, 'business_negotiation', 'template_v1', 1, '商务谈判', 4, 1, '0', 0, '2020-11-30 11:06:50', 0, '2020-11-30 11:06:50', NULL);
INSERT INTO `crm_template_stage` VALUES (96, 'contract_approval', 'template_v1', 1, '合同审批', 5, 1, '0', 0, '2020-11-30 11:06:50', 0, '2020-11-30 11:06:50', NULL);
INSERT INTO `crm_template_stage` VALUES (97, 'win', 'template_v1', 1, '赢单', 6, 1, '0', 0, '2020-11-30 11:06:50', 0, '2020-11-30 11:06:50', NULL);
INSERT INTO `crm_template_stage` VALUES (98, 'lose', 'template_v1', 1, '输单', 7, 1, '0', 0, '2020-11-30 11:06:50', 0, '2020-11-30 11:06:50', NULL);
COMMIT;
