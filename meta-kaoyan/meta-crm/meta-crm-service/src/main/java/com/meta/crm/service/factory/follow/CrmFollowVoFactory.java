package com.meta.crm.service.factory.follow;

import com.meta.act.app.service.ISysDeptService;
import com.meta.act.app.service.ISysUserService;
import com.meta.crm.domain.aggr.CrmCustomerDo;
import com.meta.crm.intf.constants.ClueDicTypeConstants;
import com.meta.crm.domain.aggr.CrmFollowDo;
import com.meta.crm.intf.res.vo.assign.CrmAssignUserVo;
import com.meta.crm.intf.res.vo.customer.CrmCustomerVo;
import com.meta.crm.intf.res.vo.follow.CrmFollowVo;
import com.meta.act.app.service.ISysDictDataService;
import com.meta.framework.act.entity.SysDept;
import com.meta.framework.act.entity.SysUser;
import com.meta.platform.file.config.OssServiceFactory;
import com.meta.platform.file.model.FileInfo;
import com.meta.platform.file.model.FileType;
import com.meta.platform.file.service.IFileService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

@Component
@Slf4j
public class CrmFollowVoFactory {

    @Resource
    private ISysDictDataService sysDictDataService;

    @Resource
    private ISysUserService sysUserService;

    @Resource
    private OssServiceFactory fileServiceFactory;

    @Resource
    private ISysDeptService sysDeptService;

    public Map<Long, CrmFollowVo> buildBaseCrmFollowVo(Map<Long, CrmFollowDo> followDoMap){

        if (CollectionUtils.isEmpty(followDoMap)){
            return new HashMap<>();
        }

        Map<Long, CrmFollowVo> resMap = new HashMap<>();

        Map<Long, CrmFollowVo> idMap = new HashMap<>();
        List<CrmFollowVo> followVos = buildBaseCrmFollowVo(new ArrayList<>(followDoMap.values()));
        for (CrmFollowVo followVo : followVos) {
            idMap.put(followVo.getId(), followVo);
        }

        followDoMap.forEach((k, v) -> {
            resMap.put(k, idMap.get(v.getId()));
        });

        return resMap;
    }

    public CrmFollowVo buildBaseCrmFollowVo(CrmFollowDo followDo){
        if (followDo == null){
            return null;
        }

        List<CrmFollowVo> resList = buildBaseCrmFollowVo(Collections.singletonList(followDo));
        if (resList.isEmpty()){
            return null;
        }

        return resList.get(0);
    }

    public List<CrmFollowVo> buildBaseCrmFollowVo(List<CrmFollowDo> followDos){
        if (CollectionUtils.isEmpty(followDos)){
            return new ArrayList<>();
        }

        Set<Long> sysUserIds = new HashSet<>();
        for (CrmFollowDo followDo : followDos) {
            sysUserIds.add(followDo.getCreateBy());
        }

        List<CrmFollowVo> resList =
                followDos.stream().map(CrmFollowVo::of).collect(Collectors.toList());

        /*
         *   翻译字典内容
         */
        // 查询字典
        Map<String, Map<String, String>> enumMap = sysDictDataService.
                queryDicNamesWithType(Arrays.asList(ClueDicTypeConstants.TARGET_TYPE,
                        ClueDicTypeConstants.FOLLOW_TYPE,
                        ClueDicTypeConstants.FOLLOW_SUB_TYPE_PHONE,
                        ClueDicTypeConstants.FOLLOW_SUB_TYPE_WECHAT));

        for (CrmFollowVo followVo : resList) {
            // 设置描述
            followVo.setFollowTypeDesc(enumMap.get(ClueDicTypeConstants.FOLLOW_TYPE).get(followVo.getFollowType()));
            followVo.setTargetTypeDesc(enumMap.get(ClueDicTypeConstants.TARGET_TYPE).get(followVo.getTargetType()));
            String followSubTypeDic = "follow_sub_type_" + followVo.getFollowType();
            if (enumMap.get(followSubTypeDic) != null){
                followVo.setFollowSubTypeDesc(enumMap.get(followSubTypeDic).get(followVo.getFollowSubType()));
            }
        }

        /*
         * 统一填充用户信息
         */
        Map<Long, SysUser> userNameMap = sysUserService.selectUserMapByIds(sysUserIds);

        userNameMap.forEach((k , user) -> {
            // 根据头像的文件ID查询文件url返回
            String fileType = FileType.ALIYUN.toString();
            IFileService fileService = fileServiceFactory.getFileService(fileType);
            List<FileInfo> avatarFiles = fileService.findFilesByIds(Arrays.asList(user.getAvatar()));
            if(avatarFiles != null && avatarFiles.size() > 0){
                user.setAvatar(avatarFiles.get(0).getUrl());
            }
        });

        for (CrmFollowVo followVo : resList) {
            SysUser followUser = userNameMap.get(followVo.getCreateBy());
            if (followUser != null){
                followVo.setFollowerName(followUser.getNickName());
                followVo.setFollowerDept(buildFollowDeptName(followUser.getDept()));
                followVo.setFollowerName(followUser.getNickName());
                followVo.setFollowerAvatar(followUser.getAvatar());
            }
        }

        return resList;
    }

    /**
     * 组装部门
     * @param dept
     */
    private String buildFollowDeptName(SysDept dept){
        StringBuilder builder = new StringBuilder();

        SysDept lastDept = dept;
        if (lastDept == null){
            return "";
        }

        try {
            String firstDeptId = dept.getAncestors().split(",")[0];
            SysDept firstDept = sysDeptService.selectDeptById(Long.valueOf(firstDeptId));
            builder.append(firstDept.getDeptName());
            builder.append("/");
        }
        catch (Exception e){
            log.error("no first dept error");
        }

        builder.append(lastDept.getDeptName());

        return builder.toString();
    }
}
