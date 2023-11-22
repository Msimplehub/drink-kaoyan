package com.meta.crm.intf.enums;

/**
 * 业务实体类型枚举
 */
public enum AssignRole {

    MAIN(1, "主责任人"),
    FOLLOWER(0, "关注人"),
    ;

    AssignRole(Integer code, String desc){
        this.code = code;
        this.desc = desc;
    }

    private Integer code;
    private String desc;

    public static AssignRole getEnumByCode(Integer code){
        if (code == null){
            return null;
        }
        for (AssignRole value : AssignRole.values()) {
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
