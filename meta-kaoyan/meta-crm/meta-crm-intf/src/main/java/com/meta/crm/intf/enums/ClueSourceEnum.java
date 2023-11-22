package com.meta.crm.intf.enums;

public enum ClueSourceEnum {
    AD("ad", "广告"),
    SEARCH("search", "搜索引擎"),
    MAN_INTRODUCE("man_introduce", "客户介绍"),
    MAKE_AN_APPOINTMENT("make_an_appointment", "预约上门"),
    MOBAI("mobai", "陌拜"),
    TEL("tel", "电话咨询"),
    MAIL("mail", "邮件咨询"),
    ONLINE_REG("online_reg", "线上注册"),
    ONLINE_INQUIRY("online_inquiry", "线上询价"),
    OTHER("other", "其它"),

    ;

    private String code;
    private String desc;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    ClueSourceEnum(String code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public static String getSourceByCode(String source) {
        for (ClueSourceEnum value : ClueSourceEnum.values()) {
            if (value.getCode().equals(source)) {
                return value.getDesc();
            }
        }
        return "";
    }
}
