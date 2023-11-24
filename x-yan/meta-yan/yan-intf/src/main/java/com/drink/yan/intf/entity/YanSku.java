package com.drink.yan.intf.entity;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;


/**
 * java类简单作用描述
 *
 * @Title:
 * @Package: com.drink.yan.intf.entity.
 * @Author: M.simple
 * @Remark: The modified content
 * @CreateDate: 2023/11/24 17:27
 * @Version: v2.0
 */
@Data
public class YanSku {

    @ApiModelProperty(value = "商品编号")
    private Long skuId;
    @ApiModelProperty(value = "商品类型")
    private String skuType;
    @ApiModelProperty(value = "商品名称")
    private String skuName;
    @ApiModelProperty(value = "商品标签")
    private String skuLabels;
    @ApiModelProperty(value = "价格")
    private BigDecimal skuPrice;
    @ApiModelProperty(value = "归属人")
    private Long belongUid;
    @ApiModelProperty(value = "购买描述")
    private String buyRemark;
    @ApiModelProperty(value = "详情页 html")
    private String skuDetail;
    private String delFlag;
    private String createBy;
    private LocalDateTime createTime;
    private String updateBy;
    private LocalDateTime updateTime;
    private String remark;

}
