package com.meta.framework.define;

/**
 * delete flag enum
 *
 * @Title:   DelFlagEnum
 * @Package: com.metafnt.platform.define.
 * @Author: M.simple
 * @Remark: The modified content
 * @CreateDate: 2020/3/17 1:51 下午
 * @Version: v2.0
 */
public enum DelFlagEnum {

	O(0, "有效"),
	I(1, "删除");

	DelFlagEnum(Integer code, String value) {
		this.code = code;
		this.value = value;
	}

	private Integer code;

	private String value;

	public Integer getCode() {
		return code;
	}

	public String getValue() {
		return value;
	}
}
