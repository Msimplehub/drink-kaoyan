package com.meta.framework.exception;

/**
 * 系统统一error Code
 *
 * @Title:  ErrorCode
 * @Package: com.metafnt.platform.exception.
 * @Author: M.simple
 * @Remark: The modified content
 * @CreateDate: 2020-03-12 14:51
 * @Version: v2.0
 */
public class PlatformErrorCode {

	public final static ErrorCode FAIL = new ErrorCode("0", "失败");
	public final static ErrorCode SUCCESS = new ErrorCode("1", "成功");
	public final static ErrorCode PARAM_NOT_NULL = new ErrorCode("10001", "参数不能为空");
	public final static ErrorCode RESULT_NOT_EXIST = new ErrorCode("10002", "数据不存在");
	public final static ErrorCode RESULT_EXIST_CHILD_CATEGORY = new ErrorCode("10003", "该类目存在下级类目");
	public final static ErrorCode RESULT_EXIST_CATEGORY_LABEL = new ErrorCode("10004", "该类目存在激活标签");
	public final static ErrorCode RESULT_EXIST_CATEGORY_CODE = new ErrorCode("10005", "类目编码已存在");
	public final static ErrorCode RESULT_EXIST_CATEGORY_NAME = new ErrorCode("10006", "类目名已存在");
	public final static ErrorCode RESULT_ADVANCED_BUSINESS_KEY_COUNT = new ErrorCode("10007", "业务标识个数需要为1-1000之间");

	public final static ErrorCode RESULT_NOT_EXIST_ROLECODE = new ErrorCode("10008", "参数中的角色无效");
	public final static ErrorCode RESULT_EXIST_MOBILE = new ErrorCode("10009", "手机号已被使用");
	public final static ErrorCode RESULT_EXIST_FULLNAME = new ErrorCode("10010", "租户名称已被使用");
	public final static ErrorCode RESULT_EXIST_NAME = new ErrorCode("10011", "租户简称已被使用");


	private String errorCode;

	private String errorMsg;

	public PlatformErrorCode(String errorCode, String errorMsg) {
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
