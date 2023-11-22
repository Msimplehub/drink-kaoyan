package com.meta.crm.intf.req.ro;

import com.meta.crm.intf.entity.CrmClue;
import lombok.Data;

import java.util.Date;


/**
 * 线索主表
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:26
 */
@Data
public class CrmClueRo extends CrmClue {
    private String mixedName;

    private String informantNameRex;

    private String companyNameRex;

    private String informantMobileRex;

    private Date startDate;

    private Date endDate;

    private Long managerId;
}
