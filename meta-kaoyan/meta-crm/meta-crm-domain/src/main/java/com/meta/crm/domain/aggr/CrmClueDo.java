package com.meta.crm.domain.aggr;

import com.meta.crm.intf.domain.TargetDo;
import com.meta.crm.intf.cmd.clue.ClueConvertBusinessCmd;
import com.meta.crm.intf.cmd.clue.ClueSaveCmd;
import com.meta.crm.intf.cmd.clue.ClueUpdateCmd;
import com.meta.crm.intf.compare.ClueAssignCompare;
import com.meta.crm.intf.constants.ClueDicTypeConstants;
import com.meta.crm.intf.entity.CrmBusiness;
import com.meta.crm.intf.entity.CrmClue;
import com.meta.crm.intf.enums.AssignFollowerType;
import com.meta.crm.intf.enums.AssignRole;
import com.meta.crm.intf.enums.ClueStatusEnum;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.log.ClueConvertLog;
import com.meta.crm.intf.req.follow.BatchQueryLatestFollowRo;
import com.meta.crm.intf.req.ro.CrmAssignRo;
import com.meta.crm.intf.req.ro.CrmFollowRo;
import com.meta.crm.intf.res.vo.clue.ClueDetailVo;
import com.meta.crm.intf.res.vo.clue.ClueListVo;
import com.meta.crm.intf.res.vo.follow.CrmFollowVo;
import com.meta.framework.act.entity.SysUser;
import com.meta.framework.common.utils.SecurityUtils;
import com.meta.framework.common.utils.StringUtils;
import com.meta.platform.file.model.FileInfo;
import com.meta.platform.oplog.req.ro.OperateLogRo;
import com.meta.framework.util.BeanUtil;
import lombok.Data;
import org.springframework.beans.BeanUtils;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;
import java.util.stream.Collectors;

@Data
public class CrmClueDo extends CrmClue implements TargetDo {
    public CrmClueDo() {
    }

    public CrmClueDo(CrmClue crmClue) {
        BeanUtils.copyProperties(crmClue, this);
    }

    public static CrmClueDo of(CrmClue entity) {
        if (entity == null) {
            return null;
        }

        CrmClueDo clueDo = new CrmClueDo();
        BeanUtils.copyProperties(entity, clueDo);
        return clueDo;
    }

    public static CrmClue createCrmClue(ClueSaveCmd req) {
        CrmClue crmClue = new CrmClue();
        BeanUtil.copyProperties(req, crmClue);
        crmClue.setCreateBy(SecurityUtils.getUserId());
        crmClue.setClueStatus(ClueStatusEnum.FOLLOW_UP.status);
        return crmClue;
    }

    public static BatchQueryLatestFollowRo createQueryClueFollowUpRo(List<ClueListVo> clueListVos) {
        BatchQueryLatestFollowRo ro = new BatchQueryLatestFollowRo();
        ro.setTargetIds(new ArrayList<>(clueListVos.stream().map(ClueListVo::getId).collect(Collectors.toSet())));
        ro.setTargetType(TargetType.CLUE.getCode());
        return ro;
    }

    public static CrmFollowRo createQueryClueDetailFollowRo(CrmClue crmClue) {
        CrmFollowRo crmFollowRo = new CrmFollowRo();
        crmFollowRo.setTargetId(crmClue.getId());
        crmFollowRo.setTargetType(TargetType.CLUE.getCode());
        return crmFollowRo;
    }

    public static CrmAssignRo createQueryClueDetailAssignDo(CrmClue crmClue) {
        CrmAssignRo crmAssignRo = new CrmAssignRo();
        crmAssignRo.setTargetId(crmClue.getId());
        crmAssignRo.setTargetType(TargetType.CLUE.getCode());
        crmAssignRo.setManagerType(AssignFollowerType.PERSON.getCode());
        crmAssignRo.setAssignRole(AssignRole.MAIN.getCode());
        return crmAssignRo;
    }

    public static ClueConvertLog createConvertLog(CrmBusiness crmBusiness) {
        ClueConvertLog log = new ClueConvertLog();
        log.setLog("将销售线索转为商机,转换后商机名称: #targetName#");
        log.setTargetType("business");
        log.setTargetId(crmBusiness.getId().toString());
        log.setTargetName(crmBusiness.getBusinessName());
        return log;
    }

    public static void fillEnumDescAndUserName(List<ClueListVo> clueListVos, Map<Long, SysUser> userNameMap,
                                               Map<String, Map<String, String>> enumMap) {
        for (ClueListVo clueListVo : clueListVos) {
            if (enumMap.containsKey(ClueDicTypeConstants.CLUE_SOURCE)) {
                clueListVo.setClueSourceDesc(enumMap.get(ClueDicTypeConstants.CLUE_SOURCE).get(clueListVo.getClueSource()));
            }
            if (enumMap.containsKey(ClueDicTypeConstants.CLUE_STATUS)) {
                clueListVo.setClueStatusDesc(enumMap.get(ClueDicTypeConstants.CLUE_STATUS).get(clueListVo.getClueStatus()));
            }
            clueListVo.setManagerName(userNameMap.getOrDefault(clueListVo.getManagerId(), new SysUser()).getNickName());
            clueListVo.setCreateByUserName(userNameMap.getOrDefault(clueListVo.getCreateBy(), new SysUser()).getNickName());
        }
    }

    public static OperateLogRo createQueryClueLogRo(CrmClue crmClue) {
        OperateLogRo ro = new OperateLogRo();
        ro.setBusinessKey(crmClue.getId().toString());
        ro.setBusinessType(TargetType.CLUE.getCode());
        return ro;
    }

    public static Set<Long> getUserIdFromClueList(List<ClueListVo> clueListVos) {
        Set<Long> result = new HashSet<>();
        for (ClueListVo clueListVo : clueListVos) {
            result.add(clueListVo.getManagerId());
            result.add(clueListVo.getCreateBy());
        }
        return result;
    }

    public static void setClueListFollow(Map<Long, CrmFollowVo> lastFollowDoMap, List<ClueListVo> clueListVos) {
        for (ClueListVo clueListVo : clueListVos) {
            Long clueId = clueListVo.getId();
            if (lastFollowDoMap.containsKey(clueId)) {
                CrmFollowVo followVo = lastFollowDoMap.get(clueId);
                clueListVo.setLastFollowInfo(followVo);
            }
        }
    }

    String handleNull(String original) {
        return original == null ? "" : original;
    }

    public String createClueUpdate(ClueUpdateCmd req, CrmClue crmClue, Map<String, String> sourceMap) {
        if (req.equals(crmClue)) {
            return "";
        }

        StringBuilder stringBuilder = new StringBuilder();
        if (!StringUtils.equals(crmClue.getInformantName(), req.getInformantName())) {
            stringBuilder.append("将线索联系人姓名由 ").append(handleNull(crmClue.getInformantName())).append(" 变更为 ").append(handleNull(req.getInformantName())).append("<br>");
            crmClue.setInformantName(req.getInformantName());
        } else {
            crmClue.setInformantName(null);
        }

        if (!StringUtils.equals(crmClue.getInformantMobile(), req.getInformantMobile())) {
            stringBuilder.append("将线索联系人手机由 ").append(handleNull(crmClue.getInformantMobile())).append(" 变更为 ").append(handleNull(req.getInformantMobile())).append("<br>");
            crmClue.setInformantMobile(req.getInformantMobile());
        } else {
            crmClue.setInformantMobile(null);
        }

        if (!StringUtils.equals(crmClue.getCompanyName(), req.getCompanyName())) {
            stringBuilder.append("将线索公司名由 ").append(handleNull(crmClue.getCompanyName())).append(" 变更为 ").append(handleNull(req.getCompanyName())).append("<br>");
            crmClue.setCompanyName(req.getCompanyName());
        } else {
            crmClue.setCompanyName(null);
        }

        if (!StringUtils.equals(crmClue.getCompanyId(), req.getCompanyId())) {
            stringBuilder.append("将线索公司id由 ").append(handleNull(crmClue.getCompanyId())).append(" 变更为 ").append(handleNull(req.getCompanyId())).append("<br>");
            crmClue.setCompanyId(req.getCompanyId());
        } else {
            crmClue.setCompanyId(null);
        }

        if (!StringUtils.equals(crmClue.getClueSource(), req.getClueSource())) {
            stringBuilder.append("将线索来源由 ").append(sourceMap.getOrDefault(crmClue.getClueSource(), "")).append(" 变更为 ").
                    append(sourceMap.getOrDefault(req.getClueSource(), "")).append("<br>");
            crmClue.setClueSource(req.getClueSource());
        } else {
            crmClue.setClueSource(null);
        }

        if (!StringUtils.equals(crmClue.getInformantWechat(), req.getInformantWechat())) {
            stringBuilder.append("将线索联系人微信号由 ").append(handleNull(crmClue.getInformantWechat())).append(" 变更为 ").append(handleNull(req.getInformantWechat())).append("<br>");
            crmClue.setInformantWechat(req.getInformantWechat());
        } else {
            crmClue.setInformantWechat(null);
        }

        if (!StringUtils.equals(crmClue.getRemark(), req.getRemark())) {
            stringBuilder.append("将线索备注由 ").append(handleNull(crmClue.getRemark())).append(" 变更为 ").append(handleNull(req.getRemark())).append("<br>");
            crmClue.setRemark(req.getRemark());
        } else {
            crmClue.setRemark(null);
        }
        crmClue.setUpdateBy(SecurityUtils.getUserId());
        return stringBuilder.toString();
    }

    public static CrmClue clueConvertBusinessUpdate(ClueConvertBusinessCmd req, CrmClue crmClue) {
        crmClue.setClueStatus(ClueStatusEnum.CONVERTED.status);
        crmClue.setUpdateBy(SecurityUtils.getUserId());
        return crmClue;
    }

    public List<ClueAssignCompare> compareClueAssignChange(List<CrmAssignUserDo> existCrmAssignUserDos,
                                                           List<CrmAssignUserDo> updateCrmAssignUserDos) {
        List<ClueAssignCompare> result = new ArrayList<>();
        Map<Long, CrmAssignUserDo> updateMap = updateCrmAssignUserDos.stream().
                collect(Collectors.toMap(CrmAssignUserDo::getTargetId, Function.identity()));
        for (CrmAssignUserDo existCrmAssignUserDo : existCrmAssignUserDos) {
            Long targetId = existCrmAssignUserDo.getTargetId();
            if (updateMap.containsKey(targetId) && updateMap.get(targetId) != null) {
                if (updateMap.get(targetId).getManagerId().compareTo(existCrmAssignUserDo.getManagerId()) != 0) {
                    ClueAssignCompare clueAssignCompare = new ClueAssignCompare();
                    clueAssignCompare.setClueId(targetId);
                    clueAssignCompare.setFromUserId(existCrmAssignUserDo.getManagerId());
                    clueAssignCompare.setToUserId(updateMap.get(targetId).getManagerId());
                    result.add(clueAssignCompare);
                }
            }
        }
        return result;
    }

    public Set<Long> getClueAssignCompareUserIds(List<ClueAssignCompare> clueAssignCompares) {
        Set<Long> result = new HashSet<>();
        for (ClueAssignCompare clueAssignCompare : clueAssignCompares) {
            result.add(clueAssignCompare.getFromUserId());
            result.add(clueAssignCompare.getToUserId());
        }
        return result;
    }

    public Set<Long> getClueDetailUserIds(CrmAssignUserDo crmAssignUserDo) {
        Set<Long> result = new HashSet<>();
        result.add(getCreateBy());
        result.add(crmAssignUserDo.getManagerId());
        return result;
    }

    public ClueDetailVo createClueDetailVo(Map<Long, SysUser> userNameMap, List<FileInfo> avatarFileInfos, Map<String, Map<String, String>> enumMap, CrmFollowDo crmFollowDo, CrmAssignUserDo crmAssignUserDo) {
        ClueDetailVo clueDetailVo = new ClueDetailVo();
        BeanUtils.copyProperties(this, clueDetailVo);
        if (enumMap.containsKey(ClueDicTypeConstants.CLUE_SOURCE)) {
            clueDetailVo.setClueSourceDesc(enumMap.get(ClueDicTypeConstants.CLUE_SOURCE).get(clueDetailVo.getClueSource()));
        }
        if (enumMap.containsKey(ClueDicTypeConstants.CLUE_STATUS)) {
            clueDetailVo.setClueStatusDesc(enumMap.get(ClueDicTypeConstants.CLUE_STATUS).get(clueDetailVo.getClueStatus()));
        }
        clueDetailVo.setClueStatusDesc(ClueStatusEnum.getClueStatusDescByCode(clueDetailVo.getClueStatus()));
        Long managerId = crmAssignUserDo.getManagerId();
        clueDetailVo.setManagerId(managerId);

        Map<String, String> avatarMap = avatarFileInfos.stream().collect(Collectors.toMap(FileInfo::getId, FileInfo::getUrl));
        // 用户姓名
        if (userNameMap.containsKey(managerId)) {
            SysUser orDefault = userNameMap.getOrDefault(managerId, new SysUser());
            clueDetailVo.setManagerName(orDefault.getNickName());
            String avatarFileId = orDefault.getAvatar();
            clueDetailVo.setManagerAvatar(avatarMap.getOrDefault(avatarFileId, ""));
        }
        Long createBy = clueDetailVo.getCreateBy();
        if (userNameMap.containsKey(createBy)) {
            clueDetailVo.setCreateByUserName(userNameMap.getOrDefault(createBy, new SysUser()).getNickName());
        }

        if (crmFollowDo != null) {
            clueDetailVo.setFollowUpDate(crmFollowDo.getCreateTime());
        }

        return clueDetailVo;
    }

    @Override
    public Long getTargetId() {
        return getId();
    }

    @Override
    public TargetType getTargetType() {
        return TargetType.CLUE;
    }

    @Override
    public String getTargetName() {
        return this.getInformantName();
    }

    public void fillClueAssignCompareUserName(Map<Long, String> userNameMap, List<ClueAssignCompare> clueAssignCompares) {
        for (ClueAssignCompare clueAssignCompare : clueAssignCompares) {
            if (userNameMap.containsKey(clueAssignCompare.getFromUserId())) {
                clueAssignCompare.setFromUserName(userNameMap.get(clueAssignCompare.getFromUserId()));
            }
            if (userNameMap.containsKey(clueAssignCompare.getToUserId())) {
                clueAssignCompare.setToUserName(userNameMap.get(clueAssignCompare.getToUserId()));
            }
        }
    }
}
