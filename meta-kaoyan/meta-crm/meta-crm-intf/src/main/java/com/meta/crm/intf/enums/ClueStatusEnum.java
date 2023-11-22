package com.meta.crm.intf.enums;

public enum ClueStatusEnum {
    FOLLOW_UP("follow_up", "跟进中"),
    CLOSED("closed", "已关闭"),
    CONVERTED("converted", "已转换"),
    ;

    public String status;
    public String desc;

    ClueStatusEnum(String status, String desc) {
        this.status = status;
        this.desc = desc;
    }

    public static String getClueStatusDescByCode(String code) {
        for (ClueStatusEnum value : ClueStatusEnum.values()) {
            if (value.status.equals(code)) {
                return value.desc;
            }
        }
        return "";
    }

}
