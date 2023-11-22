package com.meta.crm.service.app.contact.impl;

import com.meta.framework.act.entity.SysUser;
import com.meta.crm.domain.tunnel.db.CrmAssignUserRepository;
import com.meta.crm.domain.tunnel.db.CrmBusinessRepository;
import com.meta.crm.domain.tunnel.db.CrmContactRepository;
import com.meta.crm.domain.tunnel.db.CrmFollowRepository;
import com.meta.crm.intf.constants.ClueDicTypeConstants;
import com.meta.crm.intf.entity.CrmBusiness;
import com.meta.crm.domain.aggr.CrmAssignUserDo;
import com.meta.crm.domain.aggr.CrmContactDo;
import com.meta.crm.domain.aggr.CrmFollowDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.follow.BatchQueryLatestFollowRo;
import com.meta.crm.intf.req.ro.CrmBusinessRo;
import com.meta.crm.intf.req.ro.CrmContactRo;
import com.meta.crm.intf.res.vo.assign.CrmAssignUserVo;
import com.meta.crm.intf.res.vo.contact.CrmContactByCustomerVo;
import com.meta.crm.intf.res.vo.contact.CrmContactVo;
import com.meta.crm.intf.res.vo.follow.CrmFollowVo;
import com.meta.crm.service.app.contact.CrmContactQryService;
import com.meta.crm.service.factory.follow.CrmFollowVoFactory;
import com.meta.act.app.service.ISysDictDataService;
import com.meta.act.app.service.ISysUserService;
import com.meta.platform.file.config.OssServiceFactory;
import com.meta.platform.file.model.FileInfo;
import com.meta.platform.file.model.FileType;
import com.meta.platform.file.service.IFileService;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.*;

@Service
public class CrmContactQryServiceImpl implements CrmContactQryService {

    @Resource
    private CrmContactRepository crmContactRepository;

    @Resource
    private CrmAssignUserRepository crmAssignUserRepository;

    @Resource
    private CrmFollowRepository crmFollowRepository;

    @Resource
    private CrmBusinessRepository businessRepository;

    @Resource
    private ISysUserService sysUserService;

    @Resource
    private CrmFollowVoFactory crmFollowVoFactory;

    @Resource
    private ISysDictDataService sysDictDataService;

    @Resource
    private OssServiceFactory fileServiceFactory;

    @Override
    public List<CrmContactVo> listCrmContacts(CrmContactRo contactRo) {
        contactRo.dealTime();
        List<CrmContactDo> crmContactDos = crmContactRepository.listCrmContact(contactRo);
        if (CollectionUtils.isEmpty(crmContactDos)){
            return new ArrayList<>();
        }

        // 查询用IDs
        Set<Long> contactIds = new HashSet<>();
        Set<Long> sysUserIds = new HashSet<>();

        for (CrmContactDo contactDo : crmContactDos) {
            contactIds.add(contactDo.getId());
            sysUserIds.add(contactDo.getCreateBy());
        }

        // trans
        List<CrmContactVo> resList = new ArrayList<>();
        for (CrmContactDo contactDo : crmContactDos) {
            resList.add(CrmContactVo.of(contactDo));
        }

        /*
         * 责任人
         */
        Map<Long, CrmAssignUserDo> assignUserMap= crmAssignUserRepository.mapByTargetIds(contactIds,
                TargetType.CONTACT);
        for (CrmContactVo crmContactVo : resList) {
            CrmAssignUserVo assignUserVo = CrmAssignUserVo.of(assignUserMap.get(crmContactVo.getId()));
            crmContactVo.setManager(assignUserVo);
        }

        for (CrmAssignUserDo value : assignUserMap.values()) {
            sysUserIds.add(value.getManagerId());
        }

        /*
         最近跟进信息
         */
        BatchQueryLatestFollowRo followRo = new BatchQueryLatestFollowRo(new ArrayList<>(contactIds),
                TargetType.CONTACT.getCode());
        Map<Long, CrmFollowVo> lastFollowDoMap =
                crmFollowVoFactory.buildBaseCrmFollowVo(crmFollowRepository.mapLatestFollowUp(followRo));

        for (CrmContactVo crmContactVo : resList) {
            crmContactVo.setLastFollowInfo(lastFollowDoMap.get(crmContactVo.getId()));
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

        for (CrmContactVo crmContactVo : resList) {

            SysUser createUser = userNameMap.get(crmContactVo.getCreateBy()) ;
            if (createUser != null){
                crmContactVo.setCreateUserName(createUser.getNickName());
            }

            CrmAssignUserVo assignUserVo = crmContactVo.getManager();
            if (assignUserVo != null){
                SysUser assignUser = userNameMap.get(assignUserVo.getManagerId());
                if (assignUser != null){
                    assignUserVo.setManagerName(assignUser.getNickName());
                    assignUserVo.setManagerAvatar(assignUser.getAvatar());
                }
            }
        }

        /*
         * 设置字典信息
         */
        // 查询字典
        Map<String, Map<String, String>> enumMap = sysDictDataService.
                queryDicNamesWithType(Arrays.asList(ClueDicTypeConstants.SEX));

        for (CrmContactVo crmContactVo : resList) {
            // 设置描述
            if (!StringUtils.isEmpty(crmContactVo.getSex())){
                crmContactVo.setSexDesc(enumMap.get(ClueDicTypeConstants.SEX).get(crmContactVo.getSex()));
            }
        }

        return resList;
    }

    @Override
    public List<CrmContactByCustomerVo> listCrmContactsByCustomerId(Long customerId) {

        CrmContactRo contactRo = new CrmContactRo();
        contactRo.setCustomerId(customerId);
        List<CrmContactDo> crmContactDos = crmContactRepository.listCrmContact(contactRo);
        if (CollectionUtils.isEmpty(crmContactDos)){
            return new ArrayList<>();
        }

        // trans
        List<CrmContactByCustomerVo> resList = new ArrayList<>();

        for (CrmContactDo crmContactDo : crmContactDos) {
            resList.add(CrmContactByCustomerVo.of(crmContactDo));
        }

        return resList;
    }

    @Override
    public CrmContactVo getDetailById(Long contactId) {
        CrmContactRo contactRo = new CrmContactRo();
        contactRo.setId(contactId);

        List<CrmContactVo> resList = listCrmContacts(contactRo);
        if (CollectionUtils.isEmpty(resList)){
            return null;
        }

        CrmContactVo res = resList.get(0);

        /*
         *  查询商机数量
         */
        CrmBusinessRo businessRo = new CrmBusinessRo();
        businessRo.setContactId(contactId);
        List<CrmBusiness> businesses = businessRepository.listCrmBusinessWithContactId(businessRo);
        res.setBusinessCount(CollectionUtils.isEmpty(businesses) ? 0 : businesses.size());
        return res;
    }

    @Override
    public CrmContactDo getContactByMobileAndCustomer(CrmContactRo contactRo) {

        // 校验联系人手机号
        CrmContactDo contactDo = crmContactRepository.getByMobileAndCustomerId(
                contactRo.getMobile(), contactRo.getCustomerId());

        return contactDo;
    }
}
