package com.meta.framework.aop.define;

/**
 *  日志级别
 * @Title:      MethodLogLevel
 * @Package:    com.metafnt.aladdin.common.mq.define.MethodLogLevel
 * @Author:     M.simple
 * @Remark:     The modified content
 * @CreateDate: 2019-04-26 15:55
 * @Version:    v2.0
 */
public enum MethodLogLevel {

	INFO("INFO"),DEBUG("DEBUG"),ERROR("ERROR");

	private String levelName;

	MethodLogLevel(String levelName){
		this.levelName = levelName;
	}

	public String getLevelName() {
		return levelName;
	}

}
