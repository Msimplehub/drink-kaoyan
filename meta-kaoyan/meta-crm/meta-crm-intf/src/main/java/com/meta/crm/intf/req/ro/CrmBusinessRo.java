package com.meta.crm.intf.req.ro;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.meta.crm.intf.entity.CrmBusiness;
import lombok.Data;

import java.util.Date;
import java.util.List;


/**
 * 商机主表
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:25
 */
@Data
public class CrmBusinessRo extends CrmBusiness {

    // 商机名or客户名
    private String mixedName;

    // 商机名
    private String businessNameRex;

    // 客户名
    private String customerNameRex;

    // 创建开始时间
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date startDate;

    // 创建结束时间
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date endDate;

    // 负责人id
    private Long userId;

    // 联系人id
    private Long contactId;

    // 商机id列表
    private List<Long> businessIds;
}
