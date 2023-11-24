package com.drink.yan.intf.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * java类简单作用描述
 *
 * @Title:
 * @Package: com.drink.yan.intf.vo.
 * @Author: M.simple
 * @Remark: The modified content
 * @CreateDate: 2023/11/24 17:56
 * @Version: v2.0
 */
@Data
public class CustomerVo {

    @ApiModelProperty("用户编号")
    private Long userId;

    @ApiModelProperty("头像")
    private String headImg;
    @ApiModelProperty("性别")
    private String sex;
    @ApiModelProperty("手机")
    private String mobile;
    @ApiModelProperty("身份证")
    private String idCardNo;
    @ApiModelProperty("本科学校")
    private String bachelorSchoolId;
    @ApiModelProperty("本科学校名称")
    private String bachelorSchoolName;
    @ApiModelProperty("目标学校")
    private String targetSchoolId;
    @ApiModelProperty("目标学校名称")
    private String targetSchoolName;
    @ApiModelProperty("目标年份")
    private String targetYear;


}
