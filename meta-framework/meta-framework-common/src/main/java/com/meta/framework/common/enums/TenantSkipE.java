package com.meta.framework.common.enums;

/**
 *  查询是否跳过
 * @Title:      TenantSkipE
 * @Package:    com.meta.framework.common.enums.TenantSkipE
 * @Author:     M.simple
 * @Remark:     The modified content
 * @CreateDate: 2020/11/14 3:30 下午
 * @Version:    v2.0
 */
public enum TenantSkipE
{
    DEFAULT("0", "正常"), SKIP("1", "跳过");

    private final String code;
    private final String info;

    TenantSkipE(String code, String info)
    {
        this.code = code;
        this.info = info;
    }

    public String getCode()
    {
        return code;
    }

    public String getInfo()
    {
        return info;
    }
}
