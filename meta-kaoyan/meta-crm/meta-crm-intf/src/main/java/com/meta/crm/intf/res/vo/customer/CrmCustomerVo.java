package com.meta.crm.intf.res.vo.customer;

import com.meta.crm.intf.entity.CrmCustomer;
import com.meta.crm.intf.res.vo.assign.CrmAssignUserVo;
import com.meta.crm.intf.res.vo.follow.CrmFollowVo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.beans.BeanUtils;

@Data
public class CrmCustomerVo extends CrmCustomer {

    @ApiModelProperty("最近更近信息")
    private CrmFollowVo lastFollowInfo;

    @ApiModelProperty("责任人")
    private CrmAssignUserVo manager;

    @ApiModelProperty("商机数量")
    private Integer businessCount;

    @ApiModelProperty("联系人数量")
    private Integer contactCount;

    @ApiModelProperty("创建人姓名")
    private String createUserName;

    @ApiModelProperty("客户来源描述")
    private String customerSourceDesc;

    @ApiModelProperty("客户级别描述")
    private String customerLevelDesc;

    @ApiModelProperty("省名称")
    private String provinceName;

    @ApiModelProperty("市名称")
    private String cityName;

    @ApiModelProperty("区名称")
    private String regionName;

    @ApiModelProperty("行业枚举值")
    private String professionDesc;

    public static CrmCustomerVo of(CrmCustomer customer){

        CrmCustomerVo vo = new CrmCustomerVo();
        BeanUtils.copyProperties(customer, vo);

        return vo;
    }

}
