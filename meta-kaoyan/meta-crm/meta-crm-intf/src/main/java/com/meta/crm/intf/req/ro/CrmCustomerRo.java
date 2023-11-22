package com.meta.crm.intf.req.ro;

import com.meta.crm.intf.entity.CrmCustomer;
import com.meta.framework.common.utils.DateUtils;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.Set;

/**
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:26
 */
@Data
@AllArgsConstructor
@Builder
@NoArgsConstructor
public class CrmCustomerRo extends CrmCustomer {
    private Set<Long> ids;

    @ApiModelProperty("是否有商机")
    private Integer hasBusiness;

    @ApiModelProperty("负责人")
    private Long managerId;

    @ApiModelProperty("负责人类型")
    private Integer managerType;

    @ApiModelProperty("创建时间-开始")
    private Date startDate;

    @ApiModelProperty("创建时间-结束")
    private Date endDate;

    public void dealTime() {
        if (getEndDate() != null) {
            // 到次日凌晨
            this.setEndDate(DateUtils.addSeconds(getEndDate(), 86399));
        }
    }
}
