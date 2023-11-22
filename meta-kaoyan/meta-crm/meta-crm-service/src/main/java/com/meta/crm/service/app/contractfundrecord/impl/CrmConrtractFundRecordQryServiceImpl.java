package com.meta.crm.service.app.contractfundrecord.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.meta.act.app.service.ISysDictDataService;
import com.meta.act.app.service.ISysUserService;
import com.meta.crm.domain.aggr.CrmContractFundRecordDo;
import com.meta.crm.domain.aggr.CrmContractPlanFundDo;
import com.meta.crm.domain.tunnel.db.CrmContractFundRecordRepository;
import com.meta.crm.domain.tunnel.db.CrmContractPlanFundRepository;
import com.meta.crm.intf.constants.ClueDicTypeConstants;
import com.meta.crm.intf.req.contractfundrecord.FundRecordDetailQry;
import com.meta.crm.intf.req.ro.CrmContractFundRecordRo;
import com.meta.crm.intf.res.vo.contractfundrecord.CrmContractFundRecordDetailVo;
import com.meta.crm.intf.res.vo.contractfundrecord.CrmContractFundRecordVo;
import com.meta.crm.service.app.contractfundrecord.CrmContractFundRecordQryService;
import com.meta.framework.act.entity.SysUser;
import com.meta.platform.contract.domain.tunnel.db.ContractRepository;
import com.meta.platform.contract.intf.entity.Contract;
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
public class CrmConrtractFundRecordQryServiceImpl implements CrmContractFundRecordQryService {

    @Resource
    private CrmContractFundRecordRepository recordRepository;

    @Resource
    private CrmContractPlanFundRepository planFundRepository;

    @Resource
    private ContractRepository contractRepository;

    @Resource
    private ISysUserService sysUserService;

    @Resource
    private OssServiceFactory fileServiceFactory;

    @Resource
    private ISysDictDataService sysDictDataService;

    @Override
    public List<CrmContractFundRecordVo> list(CrmContractFundRecordRo recordRo) {
        List<CrmContractFundRecordDo> list = recordRepository.listTable(recordRo);
        return buildVo(list, true);
    }

    @Override
    public List<CrmContractFundRecordVo> listSimple(CrmContractFundRecordRo recordRo) {
        List<CrmContractFundRecordDo> list = recordRepository.listTable(recordRo);
        return buildVo(list, false);
    }

    @Override
    public CrmContractFundRecordDetailVo detail(FundRecordDetailQry fundRecordDetailQry) {
        CrmContractFundRecordRo ro = new CrmContractFundRecordRo();
        ro.setId(fundRecordDetailQry.getId());
        List<CrmContractFundRecordDo> list = recordRepository.listTable(ro);
        List<CrmContractFundRecordVo> voList = buildVo(list,true);
        if (CollectionUtils.isEmpty(voList)){
            return null;
        }

        CrmContractFundRecordDetailVo res = new CrmContractFundRecordDetailVo();
        BeanUtils.copyProperties(voList.get(0), res);

        return res;
    }

    private List<CrmContractFundRecordVo> buildVo(List<CrmContractFundRecordDo> recordDos, boolean complex){
        if (CollectionUtils.isEmpty(recordDos)){
            return new ArrayList<>();
        }

        // 查询用IDs
        Set<Long> recordIds = new HashSet<>();
        Set<Long> sysUserIds = new HashSet<>();
        Set<Long> contractIds = new HashSet<>();
        Set<Long> planFundIds = new HashSet<>();

        for (CrmContractFundRecordDo recordDo : recordDos) {
            recordIds.add(recordDo.getId());
            sysUserIds.add(recordDo.getCreateBy());
            contractIds.add(recordDo.getContractId());
            planFundIds.add(recordDo.getContractPlanFundId());
        }

        // trans
        List<CrmContractFundRecordVo> resList = new ArrayList<>();
        for (CrmContractFundRecordDo recordDo : recordDos) {
            resList.add(CrmContractFundRecordVo.of(recordDo));
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
            for (CrmContractFundRecordVo recordVo : resList) {
                Contract temp;
                if ((temp = contractMap.get(recordVo.getContractId())) != null){
                    recordVo.setContractTotalAmount(temp.getContractAmount());
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

            for (CrmContractFundRecordVo recordVo : resList) {

                SysUser createUser = userNameMap.get(recordVo.getCreateBy()) ;
                if (createUser != null){
                    recordVo.setCreateUserName(createUser.getNickName());
                }

            }
        }

        /*
         * 查询计划信息
         */
        List<CrmContractPlanFundDo> planFundDos = planFundRepository.getByIdList(new ArrayList<>(planFundIds));
        Map<Long, CrmContractPlanFundDo> planFundDoHashMap = new HashMap<>();
        if (!CollectionUtils.isEmpty(planFundDos)){
            for (CrmContractPlanFundDo planFundDo : planFundDos) {
                planFundDoHashMap.putIfAbsent(planFundDo.getId(), planFundDo);
            }
        }
        for (CrmContractFundRecordVo recordVo : resList) {
            CrmContractPlanFundDo temp;
            if ((temp = planFundDoHashMap.get(recordVo.getContractPlanFundId())) != null){
                recordVo.setPlanFundBatch(temp.getPlanFundBatch());
            }
        }

        /*
         * 设置字典信息
         */
        // 查询字典
        Map<String, Map<String, String>> enumMap = sysDictDataService.
                queryDicNamesWithType(Arrays.asList(ClueDicTypeConstants.PAY_TYPE, ClueDicTypeConstants.BANK));

        for (CrmContractFundRecordVo recordVo : resList) {
            // 设置描述
            if (!StringUtils.isEmpty(recordVo.getPayType())){
                recordVo.setPayTypeDesc(enumMap.get(ClueDicTypeConstants.PAY_TYPE).get(recordVo.getPayType()));
                recordVo.setBankDesc(enumMap.get(ClueDicTypeConstants.BANK).get(recordVo.getBank()));
            }
        }

        return resList;
    }

    public static void main(String[] args) {
        String json = "[{\"k\":\"中原银行\",\"v\":\"ZYB\"},{\"k\":\"南京银行\",\"v\":\"NJCB\"},{\"k\":\"招商银行\"," +
                "\"v\":\"CMB\"},{\"k\":\"中国建设银行\",\"v\":\"CCB\"},{\"k\":\"中国农业银行\",\"v\":\"ABC\"},{\"k\":\"中国银行\",\"v\":\"BOC\"},{\"k\":\"兴业银行\",\"v\":\"CIB\"},{\"k\":\"中国邮政储蓄银行\",\"v\":\"PSBC\"},{\"k\":\"交通银行\",\"v\":\"BCOM\"},{\"k\":\"商丘银行\",\"v\":\"HNSQB\"},{\"k\":\"平安银行\",\"v\":\"PAB\"},{\"k\":\"新乡银行\",\"v\":\"HNXXB\"},{\"k\":\"中国工商银行\",\"v\":\"ICBC\"},{\"k\":\"华夏银行\",\"v\":\"HXB\"},{\"k\":\"渤海银行\",\"v\":\"CBHB\"},{\"k\":\"三井住友银行\",\"v\":\"SMBC\"},{\"k\":\"星展银行\",\"v\":\"DBS\"},{\"k\":\"韩亚银行\",\"v\":\"HNBK\"},{\"k\":\"电子结算中心\",\"v\":\"DZJS\"},{\"k\":\"东亚银行\",\"v\":\"HKBEA\"},{\"k\":\"加拿大蒙特利尔银行\",\"v\":\"BMCN\"},{\"k\":\"法国巴黎银行\",\"v\":\"BNPC\"},{\"k\":\"中德住房储蓄银行\",\"v\":\"ZDZF\"},{\"k\":\"恒生银行\",\"v\":\"HSB\"},{\"k\":\"城市信用合作社\",\"v\":\"CSXYHZS\"},{\"k\":\"苏州银行\",\"v\":\"BSZ\"},{\"k\":\"中国光大银行\",\"v\":\"CEB\"},{\"k\":\"华美银行\",\"v\":\"HMYH\"},{\"k\":\"澳大利亚和新西兰银行\",\"v\":\"ANZC\"},{\"k\":\"三峡银行\",\"v\":\"SXYH\"},{\"k\":\"农村信用社\",\"v\":\"NCXYS\"},{\"k\":\"民营银行\",\"v\":\"MYYH\"},{\"k\":\"中国民生银行\",\"v\":\"CMBC\"},{\"k\":\"广东发展银行\",\"v\":\"GDB\"},{\"k\":\"韩国中小企业银行\",\"v\":\"IBK\"},{\"k\":\"国家开发银行\",\"v\":\"CDB\"},{\"k\":\"福建海峡银行\",\"v\":\"FJHXCB\"},{\"k\":\"东莞银行\",\"v\":\"DGB\"},{\"k\":\"华一银行\",\"v\":\"FSBK\"},{\"k\":\"浙商银行\",\"v\":\"CZBANK\"},{\"k\":\"城市商业银行\",\"v\":\"CSSY\"},{\"k\":\"贵阳银行\",\"v\":\"BOGY\"},{\"k\":\"中国农业发展银行\",\"v\":\"ADBC\"},{\"k\":\"澳大利亚西太平洋银行\",\"v\":\"WPSH\"},{\"k\":\"三菱东京日联银行\",\"v\":\"BTMU\"},{\"k\":\"农村合作银行\",\"v\":\"NCHZ\"},{\"k\":\"永隆银行\",\"v\":\"WLB\"},{\"k\":\"中国进出口银行\",\"v\":\"ZGCK\"},{\"k\":\"广发银行\",\"v\":\"GDB\"},{\"k\":\"首都银行\",\"v\":\"SDYH\"},{\"k\":\"国家金库\",\"v\":\"GJJK\"},{\"k\":\"第一商业银行\",\"v\":\"DYSY\"},{\"k\":\"中信银行\",\"v\":\"CITIC\"},{\"k\":\"华侨永亨银行\",\"v\":\"HQYH\"},{\"k\":\"深圳发展银行\",\"v\":\"SZSDB\"},{\"k\":\"兰州银行\",\"v\":\"LZCB\"},{\"k\":\"大华银行\",\"v\":\"UOBS\"},{\"k\":\"金融服务\",\"v\":\"JRFW\"},{\"k\":\"南洋商业银行\",\"v\":\"NCB\"},{\"k\":\"瑞士银行\",\"v\":\"UBSB\"},{\"k\":\"上海浦东发展银行\",\"v\":\"SPDB\"},{\"k\":\"农村商业银行\",\"v\":\"RCB\"},{\"k\":\"汇丰银行\",\"v\":\"HSBC\"},{\"k\":\"徽商银行\",\"v\":\"HSBANK\"},{\"k\":\"国民银行\",\"v\":\"GMYH\"},{\"k\":\"第三方支付机构\",\"v\":\"DSFJG\"},{\"k\":\"华商银行\",\"v\":\"CMBH\"},{\"k\":\"渣打银行\",\"v\":\"SCCN\"},{\"k\":\"新韩银行\",\"v\":\"CH\"},{\"k\":\"宁波银行\",\"v\":\"NBCB\"},{\"k\":\"集友银行\",\"v\":\"CBCL\"},{\"k\":\"厦门国际银行\",\"v\":\"XIBH\"},{\"k\":\"瑞穗实业银行\",\"v\":\"MHCB\"},{\"k\":\"上海银行\",\"v\":\"BKSH\"},{\"k\":\"创兴银行\",\"v\":\"CHB\"},{\"k\":\"江苏银行\",\"v\":\"JSB\"},{\"k\":\"恒丰银行\",\"v\":\"EGBANK\"},{\"k\":\"国泰世华商业银行\",\"v\":\"GTSH\"},{\"k\":\"花旗银行\",\"v\":\"CITI\"},{\"k\":\"中国人民银行\",\"v\":\"PBOC\"},{\"k\":\"其他\",\"v\":\"OTHER\"}]";
        JSONArray array = JSON.parseArray(json);
        System.out.println(array.size());

        String format = "INSERT INTO `x_crm`.`sys_dict_data`" +
                "( `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark` )" +
                "VALUES" +
                "(%s, '%s', '%s', 'bank', 'N', '0', '172', '2020-12-10 13:19:58', '172', '2020-12-10 " +
                "13:21:11', NULL );";
        for (int i = 0; i < array.size(); i++) {
            JSONObject jso = array.getJSONObject(i);
            String k = jso.getString("k");
            String v = jso.getString("v");
            System.out.println(String.format(format, i, k, v));
        }
    }
}
