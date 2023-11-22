package com.meta.crm.domain.aggr;

import com.alibaba.fastjson.JSON;
import com.meta.crm.intf.cmd.follow.AddFollowCmd;
import com.meta.crm.intf.cmd.follow.ClueFollowUpAddCmd;
import com.meta.crm.intf.entity.CrmFollow;
import com.meta.crm.intf.res.vo.clue.ClueFollowUpVo;
import lombok.Data;
import org.springframework.beans.BeanUtils;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Data
public class CrmFollowDo extends CrmFollow {

    public static CrmFollowDo of(CrmFollow crmFollow) {
        CrmFollowDo crmFollowDo = new CrmFollowDo();
        BeanUtils.copyProperties(crmFollow, crmFollowDo);

        return crmFollowDo;
    }

    public static List<CrmFollowDo> of(List<CrmFollow> crmFollows) {

        if (CollectionUtils.isEmpty(crmFollows)) {
            return new ArrayList<>();
        }

        return crmFollows.stream().map(CrmFollowDo::of).collect(Collectors.toList());
    }

    public static CrmFollowDo create(AddFollowCmd addFollowCmd) {

        CrmFollowDo followDo = new CrmFollowDo();
        BeanUtils.copyProperties(addFollowCmd, followDo);

        if (!CollectionUtils.isEmpty(addFollowCmd.getFileObjs())){
            followDo.setFiles(JSON.toJSONString(addFollowCmd.getFileObjs()));
        }

        return followDo;
    }

    public static CrmFollowDo create(ClueFollowUpAddCmd addFollowCmd) {
        CrmFollowDo followDo = new CrmFollowDo();
        BeanUtils.copyProperties(addFollowCmd, followDo);
        return followDo;
    }

    public static List<ClueFollowUpVo> getClueDetailFollowList(List<CrmFollow> crmFollows) {
        List<ClueFollowUpVo> result = new ArrayList<>();
        for (CrmFollow crmFollow : crmFollows) {

        }
        return result;
    }

    public static ClueFollowUpVo createClueFollowUpVo(CrmFollowDo clueFollowUpDo, Map<Long, String> userNameMap) {
        ClueFollowUpVo clueFollowUpVo = new ClueFollowUpVo();
        clueFollowUpVo.setFiles(clueFollowUpDo.getFiles());
        clueFollowUpVo.setFollowUpDate(clueFollowUpDo.getCreateTime());
        clueFollowUpVo.setFollowUpDesc(clueFollowUpDo.getContent());
        Long createBy = clueFollowUpDo.getCreateBy();
        clueFollowUpVo.setFollowUpUserId(createBy);
        // 用户姓名
        if (userNameMap.containsKey(createBy)) {
            clueFollowUpVo.setFollowUpUserName(userNameMap.get(createBy));
        }
        return clueFollowUpVo;
    }


}
