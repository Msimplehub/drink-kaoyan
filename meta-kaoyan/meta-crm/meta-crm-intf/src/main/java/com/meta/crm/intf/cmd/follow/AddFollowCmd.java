package com.meta.crm.intf.cmd.follow;

import com.meta.crm.intf.entity.CrmFollow;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.List;

@Data
public class AddFollowCmd extends CrmFollow {

    @ApiModelProperty("附件列表")
    List<FileObj> fileObjs;

    /**
     *跟进目标类型（0，线索，1，客户，2联系人，3商机）
     */
    @ApiModelProperty("跟进对象类型")
    @NotNull(message = "跟进对象类型不能为空")
    private String targetType;

    /**
     *跟进目标ID
     */
    @ApiModelProperty("跟进对象ID")
    @NotNull(message = "跟进对象ID不能为空")
    private Long targetId;

    @Data
    public static class FileObj {
        private String id;
    }
}
