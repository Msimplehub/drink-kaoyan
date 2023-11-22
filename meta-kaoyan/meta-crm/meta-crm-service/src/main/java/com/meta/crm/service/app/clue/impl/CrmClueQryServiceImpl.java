package com.meta.crm.service.app.clue.impl;

import com.meta.act.app.service.ISysDictDataService;
import com.meta.act.app.service.ISysUserService;
import com.meta.crm.domain.aggr.CrmAssignUserDo;
import com.meta.crm.domain.aggr.CrmClueDo;
import com.meta.crm.domain.aggr.CrmFollowDo;
import com.meta.crm.domain.tunnel.db.CrmAssignUserRepository;
import com.meta.crm.domain.tunnel.db.CrmClueRepository;
import com.meta.crm.domain.tunnel.db.CrmFollowRepository;
import com.meta.crm.intf.constants.ClueDicTypeConstants;
import com.meta.crm.intf.entity.CrmClue;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.clue.ClueDetailQry;
import com.meta.crm.intf.req.clue.ClueListQry;
import com.meta.crm.intf.req.clue.CluePhoneCheckQry;
import com.meta.crm.intf.req.follow.BatchQueryLatestFollowRo;
import com.meta.crm.intf.req.ro.CrmAssignRo;
import com.meta.crm.intf.req.ro.CrmClueRo;
import com.meta.crm.intf.res.vo.clue.ClueDetailVo;
import com.meta.crm.intf.res.vo.clue.ClueListVo;
import com.meta.crm.intf.res.vo.clue.CluePhoneCheckVo;
import com.meta.crm.service.app.clue.CrmClueQryService;
import com.meta.crm.service.factory.follow.CrmFollowVoFactory;
import com.meta.framework.act.entity.SysUser;
import com.meta.platform.file.mapper.FileMapper;
import com.meta.platform.file.model.FileInfo;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class CrmClueQryServiceImpl implements CrmClueQryService {
    @Resource
    private CrmClueRepository crmClueRepository;

    @Resource
    private CrmAssignUserRepository crmAssignUserRepository;

    @Resource
    private CrmFollowRepository crmFollowRepository;

    @Resource
    private ISysUserService sysUserService;

    @Resource
    private ISysDictDataService sysDictDataService;

    @Resource
    private CrmFollowVoFactory crmFollowVoFactory;

    @Resource
    private FileMapper fileMapper;

    @Override
    public CluePhoneCheckVo checkCluePhoneNum(CluePhoneCheckQry checkCluePhoneQry) {
        CrmClueRo crmClueRo = checkCluePhoneQry.createCheckPhoneRo();
        if (crmClueRo != null) {
            List<CrmClue> crmClues = crmClueRepository.checkCluePhoneNum(crmClueRo);
            if (!CollectionUtils.isEmpty(crmClues) && crmClues.get(0) != null) {
                return crmClues.get(0).createCheckPhoneVo();
            }
        }
        return null;
    }

    @Override
    public List<ClueListVo> queryList(ClueListQry req) {
        CrmClueRo crmClueRo = req.createRo();
        List<ClueListVo> clueListVos = crmClueRepository.queryList(crmClueRo);
        if (CollectionUtils.isEmpty(clueListVos)) {
            return Collections.emptyList();
        }
        // 线索id
        BatchQueryLatestFollowRo crmFollowRo = CrmClueDo.createQueryClueFollowUpRo(clueListVos);
        // 跟进记录
        Map<Long, CrmFollowDo> lastFollowDoMap = crmFollowRepository.mapLatestFollowUp(crmFollowRo);

        // 填充跟进记录字段
        CrmClueDo.setClueListFollow(crmFollowVoFactory.buildBaseCrmFollowVo(lastFollowDoMap), clueListVos);

        // 负责人id
        Set<Long> userIds = CrmClueDo.getUserIdFromClueList(clueListVos);

        // 查询用户信息
        Map<Long, SysUser> userMap = sysUserService.selectUserMapByIds(userIds);

        // 状态来源枚举值
        Map<String, Map<String, String>> enumMap = sysDictDataService.
                queryDicNamesWithType(Arrays.asList(ClueDicTypeConstants.CLUE_SOURCE, ClueDicTypeConstants.CLUE_STATUS));

        // 补充枚举值 + 用户名
        CrmClueDo.fillEnumDescAndUserName(clueListVos, userMap, enumMap);

        return clueListVos;
    }

    @Override
    public ClueDetailVo queryDetail(ClueDetailQry req) {
        CrmClueRo crmClueRo = req.createQueryClueRo();
        List<CrmClue> crmClues = crmClueRepository.listCrmClue(crmClueRo);
        if (!CollectionUtils.isEmpty(crmClues) && crmClues.get(0) != null) {
            CrmClue crmClue = crmClues.get(0);
            CrmClueDo crmClueDo = new CrmClueDo(crmClue);

            // 查询负责人
            CrmAssignRo crmAssignRo = CrmClueDo.createQueryClueDetailAssignDo(crmClue);
            CrmAssignUserDo crmAssignUserDo = crmAssignUserRepository.getByTargetId(crmAssignRo.getTargetId(), TargetType.CLUE);

            // 查询用户信息
            Set<Long> userIds = crmClueDo.getClueDetailUserIds(crmAssignUserDo);
            Map<Long, SysUser> userMap = sysUserService.selectUserMapByIds(userIds);

            List<String> avatarFileIds = userMap.values().stream().map(SysUser::getAvatar).collect(Collectors.toList());

            List<FileInfo> avatarFileInfos = fileMapper.selectByIds(avatarFileIds);

            CrmFollowDo crmFollowDo = crmFollowRepository.queryLatestFollow(req.getId(), TargetType.CLUE);

            // 状态来源枚举值
            Map<String, Map<String, String>> enumMap = sysDictDataService.
                    queryDicNamesWithType(Arrays.asList(ClueDicTypeConstants.CLUE_SOURCE, ClueDicTypeConstants.CLUE_STATUS));

            // 补充各种值
            return crmClueDo.createClueDetailVo(userMap, avatarFileInfos, enumMap, crmFollowDo, crmAssignUserDo);
        }
        return null;
    }
}
