package com.meta.crm.intf.res.vo.assign;

import com.meta.crm.intf.entity.CrmAssignUser;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.beans.BeanUtils;

@Data
public class CrmAssignUserVo extends CrmAssignUser {

    @ApiModelProperty("负责人姓名")
    private String managerName;

    @ApiModelProperty("负责人头像")
    private String managerAvatar;

    public static CrmAssignUserVo of(CrmAssignUser crmAssignUser){

        if (crmAssignUser == null){
            return null;
        }
        CrmAssignUserVo vo = new CrmAssignUserVo();
        BeanUtils.copyProperties(crmAssignUser, vo);
        return vo;
    }
}
