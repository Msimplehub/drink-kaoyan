package com.meta.crm.intf.enums;

public enum OperateTypeEnum {

    ADD(20, "新增"),
    CERTIFICATION(21, "实名认证"),
    CREATE_ACCOUNT(22, "创建账户"),
    UPDATE_ACCOUNT(23, "更新账户"),
    CANCEL_ACCOUNT(24, "注销账户"),
    UPDATE_SEAL(25, "更新印章"),
    CLUE_REASSIGN(101, "线索重新分配"),
    CLUE_CLOSE(102, "线索关闭"),
    CLUE_OPEN(103, "线索打开"),
    CLUE_ADD_FOLLOW_UP(104, "线索新增跟进记录"),
    CLUE_UPDATE(105, "线索更新"),
    CLUE_CONVERT(106, "线索转换商机"),

    BUSINESS_FROM_CONVERT(201, "商机由线索转换而来"),
    BUSINESS_UPDATE(202, "商机更新"),
    BUSINESS_CHANGE_STAGE(203, "商机变更阶段"),
    BUSINESS_CHANGE_CONTACT(204, "商机变更联系人"),

    CUSTOMER_ADD(301, "新建客户"),
    CLUE_ADD_CUSTOMER(303, "线索转商机创建客户"),
    CUSTOMER_UPDATE(302, "更新客户"),

    CONTACT_ADD(401, "新建联系人"),
    CLUE_ADD_CONTACT(403, "线索转商机创建联系人"),
    CONTACT_UPDATE(402, "更新联系人"),

    ASSIGN(501, "分配负责人"),

    PLAN_FUND_ADD(601, "新建回款计划"),
    PLAN_FUND_UPDATE(602, "更新回款计划"),

    CONTRACT_ADD(701, "新增合同"),
    CONTRACT_UPDATE(702, "更新合同"),

    FUND_RECORD_ADD(801, "新建回款记录"),

    INVOICE_ADD(801, "新增发票"),
    INVOICE_UPDATE(802, "更新发票"),

    ;
    private Integer code;

    private String desc;

    private OperateTypeEnum(Integer code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public static OperateTypeEnum getByCode(Integer code) {
        for (OperateTypeEnum fileTypeEnum : values()) {
            if (fileTypeEnum.getCode().equals(code)) {
                //获取指定的枚举
                return fileTypeEnum;
            }
        }
        return null;
    }
}
