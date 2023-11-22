package com.meta.crm.service.app.follow.impl;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.meta.crm.core.factory.repository.TargetRepositoryFactory;
import com.meta.crm.domain.tunnel.db.CrmFollowRepository;
import com.meta.crm.core.repository.impl.base.TargetRepositoryImpl;
import com.meta.crm.domain.aggr.CrmFollowDo;
import com.meta.crm.domain.tunnel.db.base.TargetRepository;
import com.meta.crm.intf.domain.TargetDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.exception.BusinessException;
import com.meta.crm.intf.req.follow.ListFollowByTargetListRo;
import com.meta.crm.intf.req.follow.ListFollowByTargetRo;
import com.meta.crm.intf.req.ro.CrmFollowRo;
import com.meta.crm.intf.res.vo.follow.CrmFollowVo;
import com.meta.framework.util.PageLocalHepler;
import com.meta.crm.service.app.follow.CrmFollowQryService;
import com.meta.crm.service.factory.follow.CrmFollowVoFactory;
import com.meta.framework.act.entity.SysDept;
import com.meta.framework.act.entity.SysUser;
import com.meta.framework.common.core.page.PageDomain;
import com.meta.framework.common.core.page.TableSupport;
import com.meta.framework.common.utils.StringUtils;
import com.meta.framework.common.utils.sql.SqlUtil;
import com.meta.platform.file.config.OssServiceFactory;
import com.meta.platform.file.model.FileInfo;
import com.meta.platform.file.model.FileType;
import com.meta.platform.file.service.IFileService;
import com.meta.act.app.service.ISysDeptService;
import com.meta.act.app.service.ISysUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.*;

@Service
@Slf4j
public class CrmFollowQryServiceImpl implements CrmFollowQryService {

    @Resource
    private CrmFollowRepository crmFollowRepository;

    @Resource
    private ISysUserService sysUserService;

    @Resource
    private OssServiceFactory fileServiceFactory;

    @Resource
    private CrmFollowVoFactory crmFollowVoFactory;

    @Override
    public List<CrmFollowVo> listPage(CrmFollowRo crmFollowRo) {
        startPage();
        crmFollowRo.dealTime();
        List<CrmFollowDo> followDos =  crmFollowRepository.listCrmFollow(crmFollowRo);
        return buildFollowVos(followDos);
    }

    @Override
    public List<CrmFollowVo> listByTarget(ListFollowByTargetRo listFollowByTargetRo) {

        TargetType targetType = TargetType.getEnumByCode(listFollowByTargetRo.getTargetType());
        if (targetType == null){
            return new ArrayList<>();
        }

        // 从工厂获获取仓储服务类
        TargetRepository targetRepository = TargetRepositoryFactory.getTargetRepository(targetType);

        if (targetRepository == null){
            throw new BusinessException("未找到跟进实体");
        }

        // 获取实体列表
        List<TargetDo> targetDos = targetRepository.queryShowFollowTargets(listFollowByTargetRo.getTargetId());

        //分页
        startPage();

        List<CrmFollowDo> followDos = crmFollowRepository.listByTargets(
                ListFollowByTargetListRo.builder().targetDos(targetDos).build());

        return buildFollowVos(followDos);
    }

    private List<CrmFollowVo> buildFollowVos (List<CrmFollowDo> followDos){

        if (CollectionUtils.isEmpty(followDos)){
            return new ArrayList<>();
        }

        List<CrmFollowVo> resList = crmFollowVoFactory.buildBaseCrmFollowVo(followDos);

        // 查询用ID
        Set<String> fileIds = new HashSet<>();
        for (CrmFollowVo followVo : resList) {
            List<FileInfo> fileInfos = JSON.parseArray(followVo.getFiles(), FileInfo.class);
            followVo.setFileObjs(fileInfos);
            if (!CollectionUtils.isEmpty(fileInfos)){
                for (FileInfo fileInfo : fileInfos) {
                    fileIds.add(fileInfo.getId());
                }
            }
        }

        /*
         * 填充跟进对象信息
         */
        for (CrmFollowVo followVo : resList) {
            TargetRepository targetRepository =
                    TargetRepositoryFactory.getTargetRepository(TargetType.getEnumByCode(followVo.getTargetType()));
            if (targetRepository != null){
                TargetDo target = targetRepository.queryTargetByTargets(followVo.getTargetId());
                if (target != null){
                    followVo.setTargetName(target.getTableShowName());
                }
            }
        }

        /*
         * 填充文件信息
         */
        if (StringUtils.isNotEmpty(fileIds)){
            String fileType = FileType.ALIYUN.toString();
            IFileService fileService = fileServiceFactory.getFileService(fileType);
            List<FileInfo> fileInfos = fileService.findFilesByIds(new ArrayList<>(fileIds));
            if (!CollectionUtils.isEmpty(fileInfos)){
                Map<String, FileInfo> fileInfoMap = new HashMap<>();
                for (FileInfo fileInfo : fileInfos) {
                    fileInfoMap.put(fileInfo.getId(), fileInfo);
                }

                for (CrmFollowVo followVo : resList) {
                    List<FileInfo> fileObjs = followVo.getFileObjs();
                    if (!CollectionUtils.isEmpty(fileObjs)){
                        for (FileInfo fileObj : fileObjs) {
                            FileInfo oriFileObj = fileInfoMap.get(fileObj.getId());
                            if (oriFileObj != null){
                                BeanUtils.copyProperties(oriFileObj, fileObj);
                            }
                        }
                    }
                }
            }
        }

        return resList;
    }

    private void startPage(){
        PageDomain pageDomain = TableSupport.buildPageRequest();
        Integer pageNum = pageDomain.getPageNum();
        Integer pageSize = pageDomain.getPageSize();
        if (StringUtils.isNotNull(pageNum) && StringUtils.isNotNull(pageSize))
        {
            String orderBy = SqlUtil.escapeOrderBySql(pageDomain.getOrderBy());
            PageHelper.startPage(pageNum, pageSize, orderBy);
            PageLocalHepler.setPageLocal(PageHelper.getLocalPage());
        }
    }
}
