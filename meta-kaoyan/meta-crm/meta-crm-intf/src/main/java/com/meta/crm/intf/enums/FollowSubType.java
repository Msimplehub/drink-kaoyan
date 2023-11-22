package com.meta.crm.intf.enums;

/**
 * 业务实体类型枚举
 */
public enum FollowSubType {

    //0，线索，1，客户，2联系人，3商机
    PHONE_SUCCESS("phone_success", "接通成功"),
    PHONE_NO_RESP("phone_no_resp", "无法接通"),
    PHONE_WRONG_NUMBER("phone_wrong_number", "空号/错号"),
    PHONE_STOP_SERVICE("phone_stop_service", "号码停机"),
    WECHAT_HAS_RESP("wechat_has_resp", "有回复"),
    WECHAT_NO_RESP("wechat_no_resp", "持续不回复"),
    ;

    FollowSubType(String code, String desc){
        this.code = code;
        this.desc = desc;
    }

    private String code;
    private String desc;

    public static FollowSubType getEnumByCode(Object code){
        if (code == null){
            return null;
        }
        for (FollowSubType value : FollowSubType.values()) {
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
