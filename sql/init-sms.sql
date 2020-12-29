drop table if exists sms_config;
CREATE TABLE `sms_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `inner_sms_key` varchar(64) NOT NULL DEFAULT '' COMMENT '接口调用时传入sms key值',
  `sms_type` varchar(32) NOT NULL DEFAULT '' COMMENT '短信类型 验证码 营销 通知',
  `outer_sms_channel` varchar(32) NOT NULL DEFAULT '' COMMENT '短信发送渠道',
  `outer_sms_template_code` varchar(64) NOT NULL DEFAULT '' COMMENT '外部第三方短信平台的模板code',
  `outer_sms_template` varchar(512) NOT NULL DEFAULT '' COMMENT '短信发送文本模板',
  `sign_name` varchar(64) NOT NULL DEFAULT '' COMMENT '短信签名',
  `max_resend_count` int(11) NOT NULL DEFAULT '0' COMMENT '重新发送次数限制',
  `add_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '增加时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标志位 0删除 1 未删除',
  `support_foreign` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否支持国外短信 0否 1是',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有效 0无效 1有效',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique` (`inner_sms_key`,`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='短信模板配置';

drop table if exists sms_send_record;
CREATE TABLE `sms_send_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `biz_id` varchar(64) NOT NULL DEFAULT '' COMMENT '传给外部系统的业务主键',
  `inner_sms_key` varchar(64) NOT NULL DEFAULT '' COMMENT '接口调用时传入sms key值',
  `send_mobile` varchar(32) NOT NULL DEFAULT '' COMMENT '短信发送手机号',
  `sms_content` varchar(512) NOT NULL DEFAULT '' COMMENT '实际短信发送内容',
  `outer_sms_channel` varchar(32) NOT NULL DEFAULT '' COMMENT '短信发送渠道',
  `outer_sms_template_code` varchar(64) NOT NULL DEFAULT '' COMMENT '外部第三方短信平台的模板code',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  `send_status` varchar(32) NOT NULL DEFAULT 'sending' COMMENT '发送状态',
  `resend_count` int(11) NOT NULL DEFAULT '0' COMMENT '重发次数',
  `add_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '增加时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标志位 0删除 1 未删除',
  PRIMARY KEY (`id`),
  KEY `idx_query` (`inner_sms_key`,`send_mobile`,`send_status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='短信发送记录';

drop table if exists sms_mobile_black_list;
CREATE TABLE `sms_mobile_black_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(32) NOT NULL DEFAULT '' COMMENT '黑名单手机号',
  `reason` varchar(64) NOT NULL DEFAULT '' COMMENT '添加原因',
  `add_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '增加时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标志位 0删除 1 未删除',
  PRIMARY KEY (`id`),
  KEY `idx_mobile` (`mobile`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='短信黑名单';