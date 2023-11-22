package com.meta.crm.intf.res.vo.follow;

import com.meta.crm.intf.entity.CrmFollow;
import com.meta.platform.file.model.FileInfo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.beans.BeanUtils;

import java.util.List;

@Data
public class CrmFollowVo extends CrmFollow {

    @ApiModelProperty("跟进人姓名")
    private String followerName;

    @ApiModelProperty("跟进人头像")
    private String followerAvatar;

    @ApiModelProperty("跟进人部门")
    private String followerDept;

    @ApiModelProperty("跟进对象的名称")
    private String targetName;

    @ApiModelProperty("跟进目标类型描述")
    private String targetTypeDesc;

    @ApiModelProperty("跟进类型描述")
    private String followTypeDesc;

    @ApiModelProperty("跟进子类型描述")
    private String followSubTypeDesc;

    @ApiModelProperty("文件信息")
    private List<FileInfo> fileObjs;

    public static CrmFollowVo of(CrmFollow crmFollow) {

        if (crmFollow == null) {
            return null;
        }
        CrmFollowVo vo = new CrmFollowVo();
        BeanUtils.copyProperties(crmFollow, vo);

        return vo;
    }
}
