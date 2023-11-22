package com.meta.crm.service.app.contractplanfund.impl;

import com.meta.act.app.service.ISysDictDataService;
import com.meta.act.app.service.ISysUserService;
import com.meta.crm.domain.aggr.CrmAssignUserDo;
import com.meta.crm.domain.aggr.CrmContractPlanFundDo;
import com.meta.crm.domain.tunnel.db.*;
import com.meta.crm.intf.constants.ClueDicTypeConstants;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.contractplanfund.PlanFundDetailQry;
import com.meta.crm.intf.req.ro.CrmContractPlanFundRo;
import com.meta.crm.intf.res.vo.assign.CrmAssignUserVo;
import com.meta.crm.intf.res.vo.contractplanfund.CheckPlanAmountVo;
import com.meta.crm.intf.res.vo.contractplanfund.CrmContractPlanFundDetailVo;
import com.meta.crm.intf.res.vo.contractplanfund.CrmContractPlanFundVo;
import com.meta.crm.service.app.contractplanfund.CrmContractPlanFundQryService;
import com.meta.framework.act.entity.SysUser;
import com.meta.platform.contract.domain.aggr.ContractFundRecordDo;
import com.meta.platform.contract.domain.tunnel.db.ContractFundRecordRepository;
import com.meta.platform.contract.domain.tunnel.db.ContractRepository;
import com.meta.platform.contract.intf.cmd.contractplanfund.CheckAmountCmd;
import com.meta.platform.contract.intf.entity.Contract;
import com.meta.platform.contract.intf.ro.ContractFundRecordRo;
import com.meta.platform.contract.intf.ro.ContractRo;
import com.meta.platform.file.config.OssServiceFactory;
import com.meta.platform.file.model.FileInfo;
import com.meta.platform.file.model.FileType;
import com.meta.platform.file.service.IFileService;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.*;

@Service
public class CrmContractPlanFundQryServiceImpl implements CrmContractPlanFundQryService {

    @Resource
    private CrmContractPlanFundRepository planFundRepository;

    @Resource
    private CrmCustomerRepository crmCustomerRepository;

    @Resource
    private CrmAssignUserRepository crmAssignUserRepository;

    @Resource
    private ISysUserService sysUserService;

    @Resource
    private OssServiceFactory fileServiceFactory;

    @Resource
    private ISysDictDataService sysDictDataService;

    @Resource
    private ContractFundRecordRepository recordRepository;

    @Resource
    private ContractRepository contractRepository;

    @Override
    public List<CrmContractPlanFundVo> list(CrmContractPlanFundRo planFundRo){
        planFundRo.dealTime();
        List<CrmContractPlanFundDo> planFundDos = planFundRepository.list(planFundRo);
        return buildVo(planFundDos, true);
    }

    @Override
    public List<CrmContractPlanFundVo> listSimple(CrmContractPlanFundRo planFundRo){
        List<CrmContractPlanFundDo> planFundDos = planFundRepository.list(planFundRo);
        return buildVo(planFundDos, false);
    }

    private List<CrmContractPlanFundVo> buildVo(List<CrmContractPlanFundDo> planFundDos, boolean complex){

        if (CollectionUtils.isEmpty(planFundDos)){
            return new ArrayList<>();
        }

        // 查询用IDs
        Set<Long> planFundIds = new HashSet<>();
        Set<Long> sysUserIds = new HashSet<>();
        Set<Long> contractIds = new HashSet<>();

        for (CrmContractPlanFundDo planFundDo : planFundDos) {
            planFundIds.add(planFundDo.getId());
            sysUserIds.add(planFundDo.getCreateBy());
            contractIds.add(planFundDo.getContractId());
        }

        // trans
        List<CrmContractPlanFundVo> resList = new ArrayList<>();
        for (CrmContractPlanFundDo planFundDo : planFundDos) {
            resList.add(CrmContractPlanFundVo.of(planFundDo));
        }

        // 复杂查询
        if (complex){
            /*
             * 查询合同信息
             */
            ContractRo contractRo = new ContractRo();
            contractRo.setIdList(new ArrayList<>(contractIds));
            List<Contract> contracts = contractRepository.listContract(contractRo);
            Map<Long, Contract> contractMap = new HashMap<>();
            if (!CollectionUtils.isEmpty(contracts)){
                for (Contract contract : contracts) {
                    contractMap.putIfAbsent(contract.getId(), contract);
                }
            }
            for (CrmContractPlanFundVo planFundVo : resList) {
                Contract temp;
                if ((temp = contractMap.get(planFundVo.getContractId())) != null){
                    planFundVo.setContractTotalAmount(temp.getContractAmount());
                }
            }

            /*
             * 责任人
             */
            Map<Long, CrmAssignUserDo> assignUserMap= crmAssignUserRepository.mapByTargetIds(planFundIds,
                    TargetType.CONTRACT_PLAN_FUND);
            for (CrmContractPlanFundVo planFundVo : resList) {
                CrmAssignUserVo assignUserVo = CrmAssignUserVo.of(assignUserMap.get(planFundVo.getId()));
                planFundVo.setManager(assignUserVo);
            }

            for (CrmAssignUserDo value : assignUserMap.values()) {
                sysUserIds.add(value.getManagerId());
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

            for (CrmContractPlanFundVo planFundVo : resList) {

                SysUser createUser = userNameMap.get(planFundVo.getCreateBy()) ;
                if (createUser != null){
                    planFundVo.setCreateUserName(createUser.getNickName());
                }

                CrmAssignUserVo assignUserVo = planFundVo.getManager();
                if (assignUserVo != null){
                    SysUser assignUser = userNameMap.get(assignUserVo.getManagerId());
                    if (assignUser != null){
                        assignUserVo.setManagerName(assignUser.getNickName());
                        assignUserVo.setManagerAvatar(assignUser.getAvatar());
                    }
                }

            }
        }

        /*
         * 设置字典信息
         */
        // 查询字典
        Map<String, Map<String, String>> enumMap = sysDictDataService.
                queryDicNamesWithType(Arrays.asList(ClueDicTypeConstants.CONTRACT_FUND_STATUS));

        for (CrmContractPlanFundVo planFundVo : resList) {
            // 设置描述
            if (!StringUtils.isEmpty(planFundVo.getPlanFundStatus())){
                planFundVo.setPlanFundStatusDesc(enumMap.get(ClueDicTypeConstants.CONTRACT_FUND_STATUS).get(planFundVo.getPlanFundStatus()));
            }
        }

        return resList;
    }


    @Override
    public CrmContractPlanFundDetailVo detail(PlanFundDetailQry planFundRo) {
        CrmContractPlanFundRo ro = new CrmContractPlanFundRo();
        ro.setId(planFundRo.getId());
        List<CrmContractPlanFundDo> planFundDos = planFundRepository.list(ro);

        if (CollectionUtils.isEmpty(planFundDos)){
            return null;
        }

        CrmContractPlanFundVo planFundVo = buildVo(planFundDos, true).get(0);

        CrmContractPlanFundDetailVo res = new CrmContractPlanFundDetailVo();
        BeanUtils.copyProperties(planFundVo, res);

        //查询回款记录
        ContractFundRecordRo recordRo = new ContractFundRecordRo();
        recordRo.setContractPlanFundId(planFundRo.getId());
        List<ContractFundRecordDo> recordDos = recordRepository.listContractFundRecordDo(recordRo);
        res.setFundRecordCount(recordDos.size());

        return res;
    }
}
