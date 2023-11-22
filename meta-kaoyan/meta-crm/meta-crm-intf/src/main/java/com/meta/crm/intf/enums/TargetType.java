package com.meta.crm.intf.enums;

/**
 * 业务实体类型枚举
 */
public enum TargetType {

    //0，线索，1，客户，2联系人，3商机
    CLUE("clue", "线索"),
    CUSTOMER("customer", "客户"),
    CONTACT("contact","联系人"),
    BUSINESS("business", "商机"),
    CONTRACT("contract", "合同"),
    CONTRACT_PLAN_FUND("contractPlanFund", "回款计划"),
    CONTRACT_FUND_RECORD("contractFundRecord", "回款记录"),
    CONTRACT_INVOICE("contractInvoice","发票"),
    ;

    TargetType(String code, String desc){
        this.code = code;
        this.desc = desc;
    }

    private String code;
    private String desc;

    public static TargetType getEnumByCode(String code){
        if (code == null){
            return null;
        }
        for (TargetType value : TargetType.values()) {
            if (value.code.equals(code)){
                return value;
            }
        }

        return null;
    }

    public static String getDescByCode(String code){
        TargetType targetType = getEnumByCode(code);
        if (targetType == null){
            return null;
        }
        return targetType.getDesc();
    }

    public String getCode() {
        return code;
    }

    public String getDesc() {
        return desc;
    }
}
