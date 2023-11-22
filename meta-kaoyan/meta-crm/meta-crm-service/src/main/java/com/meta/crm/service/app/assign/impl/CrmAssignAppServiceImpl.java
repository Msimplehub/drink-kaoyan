package com.meta.crm.service.app.assign.impl;

import com.meta.crm.domain.tunnel.db.CrmAssignUserRepository;
import com.meta.crm.intf.cmd.assign.BatchChangeManagerCmd;
import com.meta.crm.intf.cmd.assign.UpdateAssignUserCmd;
import com.meta.crm.domain.aggr.CrmAssignUserDo;
import com.meta.crm.intf.enums.AssignFollowerType;
import com.meta.crm.intf.enums.AssignRole;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.service.app.opLog.AssignOpLogContentBuilder;
import com.meta.crm.service.app.assign.CrmAssignAppService;
import com.meta.platform.oplog.common.OperateLogHandler;
import com.meta.crm.intf.enums.OperateTypeEnum;
import com.meta.act.app.service.ISysUserService;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.*;

@Service
public class CrmAssignAppServiceImpl implements CrmAssignAppService {

    @Resource
    private CrmAssignUserRepository crmAssignUserRepository;

    @Resource
    private OperateLogHandler operateLogHandler;

    @Resource
    private ISysUserService sysUserService;

    @Resource
    private AssignOpLogContentBuilder assignOpLogContentBuilder;

    @Override
    public void updateAssignUser(UpdateAssignUserCmd changeAssignUserCmd) {

        // 查询现有的分配关系
        CrmAssignUserDo assignUserDo = crmAssignUserRepository.getByTargetId(
                changeAssignUserCmd.getTargetId(),
                TargetType.getEnumByCode(changeAssignUserCmd.getTargetType()));

        // 如果原分配关系不存在，则创建
        if (assignUserDo == null){
            if (changeAssignUserCmd.getManagerId() == null){
                return;
            }

            // 创建关系
            assignUserDo = assignUserDo.createAssignUser(
                    changeAssignUserCmd.getManagerId(),
                    AssignFollowerType.PERSON,
                    changeAssignUserCmd.getTargetId(),
                    AssignRole.MAIN,
                    TargetType.getEnumByCode(changeAssignUserCmd.getTargetType())
            );
            crmAssignUserRepository.saveCrmAssignUser(assignUserDo);

            //操作日志
            Map<Long, String> nameMap =
                    sysUserService.selectUserNameMapByIds(new HashSet<>(Collections.singletonList(assignUserDo.getManagerId())));
            assignUserDo.setManagerName(nameMap.get(assignUserDo.getManagerId()));
            operateLogHandler.addLog(changeAssignUserCmd.getTargetType(), changeAssignUserCmd.getTargetId().toString(),
                    OperateTypeEnum.ASSIGN.getCode(), assignOpLogContentBuilder.buildCreateContent(assignUserDo));
        }
        else{
            if (assignUserDo.getManagerId().equals(changeAssignUserCmd.getManagerId())){
                return;
            }

            CrmAssignUserDo old = new CrmAssignUserDo();
            assignUserDo.transform(old);

            // 变更关系
            assignUserDo.changeManager(changeAssignUserCmd.getManagerId(),
                    AssignFollowerType.getEnumByCode(changeAssignUserCmd.getManagerType()));

            crmAssignUserRepository.saveCrmAssignUser(assignUserDo);

            //操作日志
            Map<Long, String> nameMap =
                    sysUserService.selectUserNameMapByIds(new HashSet<>(Arrays.asList(old.getManagerId(),
                            assignUserDo.getManagerId())));
            old.setManagerName(nameMap.get(old.getManagerId()));
            assignUserDo.setManagerName(nameMap.get(assignUserDo.getManagerId()));
            operateLogHandler.addLog(changeAssignUserCmd.getTargetType(), changeAssignUserCmd.getTargetId().toString(),
                    OperateTypeEnum.ASSIGN.getCode(), assignOpLogContentBuilder.buildUpdateContent(old, assignUserDo));
        }


    }

    @Override
    public void batchChangeManager(BatchChangeManagerCmd cmd) {
        // 查询现有的分配关系
        if (CollectionUtils.isEmpty(cmd.getTargetIds())){
            return;
        }

        for (Long targetId : cmd.getTargetIds()) {
            UpdateAssignUserCmd updateAssignUserCmd = new UpdateAssignUserCmd();
            updateAssignUserCmd.setTargetId(targetId);
            updateAssignUserCmd.setTargetType(cmd.getTargetType());
            updateAssignUserCmd.setManagerId(cmd.getManagerId());
            updateAssignUserCmd.setManagerType(cmd.getManagerType());

            updateAssignUser(updateAssignUserCmd);
        }
    }
}
