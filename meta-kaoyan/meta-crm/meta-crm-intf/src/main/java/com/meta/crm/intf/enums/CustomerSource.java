package com.meta.crm.intf.enums;

/**
 * 业务实体类型枚举
 */
public enum CustomerSource {

    //    广告、搜索引擎、客户介绍、预约上门、陌拜、电话咨询、邮件咨询、线上注册、线上询价、其它

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

    CustomerSource(String code, String desc){
        this.code = code;
        this.desc = desc;
    }

    private String code;
    private String desc;

    public static CustomerSource getEnumByCode(String code){
        if (code == null){
            return null;
        }
        for (CustomerSource value : CustomerSource.values()) {
            if (value.code.equals(code)){
                return value;
            }
        }

        return null;
    }

    public static String getDescByCode(String code){
        if (code == null){
            return null;
        }
        CustomerSource level = getEnumByCode(code);
        if (level == null){
            return null;
        }

        return level.getDesc();
    }

    public String getCode() {
        return code;
    }

    public String getDesc() {
        return desc;
    }
}
