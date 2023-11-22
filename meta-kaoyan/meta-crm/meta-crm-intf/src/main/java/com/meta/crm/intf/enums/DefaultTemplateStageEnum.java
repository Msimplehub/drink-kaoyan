package com.meta.crm.intf.enums;

public enum DefaultTemplateStageEnum {
    demand_guidance("demand_guidance", "需求引导", 1),

    value_presentation("value_presentation", "价值呈现", 2),

    program_competition("program_competition", "方案竞争", 3),

    business_negotiation("business_negotiation", "商务谈判", 4),

    contract_approval("contract_approval", "合同审批", 5),

    win("win", "赢单", 6),

    lose("lose", "输单", 7);

    private String code;
    private String name;
    private Integer sort;

    DefaultTemplateStageEnum(String code, String name, Integer sort) {
        this.code = code;
        this.name = name;
        this.sort = sort;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }
}
