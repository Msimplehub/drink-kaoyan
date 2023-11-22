package com.meta.crm.intf.enums;

/**
 * 业务实体类型枚举
 */
public enum FollowType {

    //0，线索，1，客户，2联系人，3商机
    PHONE("phone", "电话"),
    WECHAT("wechat", "微信"),
    VISIT("visit","拜访"),
    ;

    FollowType(String code, String desc){
        this.code = code;
        this.desc = desc;
    }

    private String code;
    private String desc;

    public static FollowType getEnumByCode(Object code){
        if (code == null){
            return null;
        }
        for (FollowType value : FollowType.values()) {
            if (value.code.equals(code)){
                return value;
            }
        }

        return null;
    }

    public String getCode() {
        return code;
    }

    public String getDesc() {
        return desc;
    }
}
