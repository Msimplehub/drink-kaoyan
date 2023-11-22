package com.meta.crm.intf.req.follow;

import com.meta.framework.core.BaseEntity;
import com.meta.crm.intf.domain.TargetDo;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Builder
@Data
public class ListFollowByTargetListRo extends BaseEntity {

    List<TargetDo> targetDos;
}
