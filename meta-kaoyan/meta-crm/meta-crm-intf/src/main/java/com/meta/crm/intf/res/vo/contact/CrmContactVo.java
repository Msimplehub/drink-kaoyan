package com.meta.crm.intf.res.vo.contact;

import com.meta.crm.intf.entity.CrmContact;
import com.meta.crm.intf.res.vo.assign.CrmAssignUserVo;
import com.meta.crm.intf.res.vo.follow.CrmFollowVo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.beans.BeanUtils;

@Data
public class CrmContactVo extends CrmContact {

    @ApiModelProperty("最近更近信息")
    private CrmFollowVo lastFollowInfo;

    @ApiModelProperty("责任人")
    private CrmAssignUserVo manager;

    @ApiModelProperty("创建人信息")
    private String createUserName;

    @ApiModelProperty("客户名称")
    private String customerName;

    @ApiModelProperty("商机数量")
    private Integer businessCount;

    @ApiModelProperty("性别")
    private String sexDesc;

    public static CrmContactVo of(CrmContact contact){

        CrmContactVo vo = new CrmContactVo();
        BeanUtils.copyProperties(contact, vo);

        return vo;
    }
}
