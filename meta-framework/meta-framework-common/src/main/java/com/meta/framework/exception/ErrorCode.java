package com.meta.framework.exception;

/**
 * java类简单作用描述
 *
 * @Title:
 * @Package: com.metafnt.platform.exception.
 * @Author: M.simple
 * @Remark: The modified content
 * @CreateDate: 2020/3/20 4:39 下午
 * @Version: v2.0
 */
public class ErrorCode {

	private String errorCode;

	private String errorMsg;

	public ErrorCode(String errorCode, String errorMsg) {
		this.errorCode = errorCode;
		this.errorMsg = errorMsg;
	}

	public String getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
}
