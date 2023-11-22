package com.meta.crm.intf.req.ro;

import com.meta.crm.intf.entity.CrmFollow;
import com.meta.framework.common.utils.DateUtils;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;
import java.util.Set;


/**
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:26
 */
@Data
public class CrmFollowRo extends CrmFollow {
    private Set<Long> targetIds;

    @ApiModelProperty("创建时间-开始")
    private Date startDate;

    @ApiModelProperty("创建时间-结束")
    private Date endDate;

    public void dealTime(){
        if (getEndDate() != null) {
            // 到次日凌晨
            this.setEndDate(DateUtils.addSeconds(getEndDate(), 86399));
        }
    }
}
