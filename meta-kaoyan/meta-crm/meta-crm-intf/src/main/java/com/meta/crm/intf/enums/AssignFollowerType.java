package com.meta.crm.intf.enums;

/**
 * 业务实体类型枚举
 */
public enum AssignFollowerType {

    PERSON(0, "个人"),
    GROUP(1, "团队"),
    ;

    AssignFollowerType(Integer code, String desc){
        this.code = code;
        this.desc = desc;
    }

    private Integer code;
    private String desc;

    public static AssignFollowerType getEnumByCode(Integer code){
        if (code == null){
            return null;
        }
        for (AssignFollowerType value : AssignFollowerType.values()) {
            if (value.code.equals(code)){
                return value;
            }
        }

        return null;
    }

    public Integer getCode() {
        return code;
    }

    public String getDesc() {
        return desc;
    }
}
