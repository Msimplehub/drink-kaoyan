package com.meta.crm.intf.req.follow;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class ListFollowByCustomerAllRo {

    @ApiModelProperty("客户Id")
    private Long customerId;

}
