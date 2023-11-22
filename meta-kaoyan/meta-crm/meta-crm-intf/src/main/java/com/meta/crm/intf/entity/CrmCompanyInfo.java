package com.meta.crm.intf.entity;

import java.io.Serializable;

import com.meta.framework.core.BaseEntity;
import lombok.Data;


/**
 * 企业工商信息
 * 
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:25
 */
@Data
public class CrmCompanyInfo extends BaseEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	
	    /**
	 *PK
	 */
    private Integer id;

	/**
	 *信用编号
	 */
	private String creditCode;
	
		/**
	 *公司名
	 */
    private String companyName;
	
		/**
	 *基础信息
	 */
    private String basicInfo;

	/**
	 *股东信息
	 */
	private String shareholderInfo;

	/**
	 *主要成员信息
	 */
	private String memberInfo;

	/**
	 *变更信息
	 */
	private String changeInfo;

	/**
	 *分支机构信息
	 */
	private String branchInfo;

	/**
	 *经营信息
	 */
	private String operationInfo;

	
//		/**
//	 *地址
//	 */
//    private String address;
//
//		/**
//	 *联系电话
//	 */
//    private String contactNumber;
//
//		/**
//	 *邮箱地址
//	 */
//    private String email;
//
//		/**
//	 *标签
//	 */
//    private String tag;
//
//		/**
//	 *状态
//	 */
//    private String status;
//
//		/**
//	 *编号
//	 */
//    private String keyNo;
//
//
//
//		/**
//	 *入库时间
//	 */
//    private Date date;
	
}
