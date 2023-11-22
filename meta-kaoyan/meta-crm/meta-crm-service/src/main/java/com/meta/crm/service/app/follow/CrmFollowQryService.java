package com.meta.crm.service.app.follow;

import com.meta.crm.intf.req.follow.ListFollowByTargetRo;
import com.meta.crm.intf.req.ro.CrmFollowRo;
import com.meta.crm.intf.res.vo.follow.CrmFollowVo;

import java.util.List;

public interface CrmFollowQryService {

    List<CrmFollowVo> listPage(CrmFollowRo crmFollowRo);

    List<CrmFollowVo> listByTarget(ListFollowByTargetRo listFollowByTargetRo);

}
