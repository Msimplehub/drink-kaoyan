package com.meta.crm.web.rest;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.meta.framework.common.annotation.Log;
import com.meta.framework.common.core.controller.BaseController;
import com.meta.framework.common.exception.CustomException;
import com.meta.framework.common.utils.AssertUtils;
import com.meta.framework.core.CommonRes;
import com.meta.framework.common.core.page.PageDomain;
import com.meta.framework.common.core.page.TableSupport;
import com.meta.framework.common.enums.BusinessType;
import com.meta.crm.intf.entity.CrmCompanyInfo;
import com.meta.crm.intf.req.company.CompanyListQry;
import com.meta.crm.service.app.company.CrmCompanyAppService;
import com.meta.crm.service.app.company.CrmCompanyQryService;
import com.meta.platform.company.dto.QueryCompanyDto;
import com.meta.platform.company.openapi.TYCApi;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("crmCompanyInfo")
@Slf4j
public class CrmCompanyInfoController extends BaseController {

    @Resource
    private CrmCompanyAppService crmCompanyAppService;

    @Resource
    private CrmCompanyQryService crmCompanyQryService;

    @Log(title = "工商模糊查询", businessType = BusinessType.QUERY)
    @GetMapping("/queryListByFuzzy")
    public JSONArray listCompanyInfoByFuzzy(@Validated CompanyListQry req) {
        // 公司名模糊查询
        QueryCompanyDto dto = new QueryCompanyDto();
        dto.setKeyword(req.getCompanyName());
        PageDomain pageDomain = TableSupport.buildPageRequest();
        dto.setPageSize(pageDomain.getPageSize());
        dto.setPageIndex(pageDomain.getPageNum());
        return TYCApi.queryCompanyList(dto);
    }

    @Log(title = "工商查询详情", businessType = BusinessType.QUERY)
    @GetMapping("/getCompanyDetail")
    public CrmCompanyInfo getCompanyDetail(@Validated CompanyListQry req) {
        // 选中公司时，根据公司全名或信用编号，库中查询详情时，如果返回则直接返回，否则返回且入库缓存
        CrmCompanyInfo info = crmCompanyQryService.getCompanyDetail(req);
        if (info == null) {
            return queryIntfAndSaveCompanyInfo(req);
        }
        return info;
    }

    public CrmCompanyInfo queryIntfAndSaveCompanyInfo(CompanyListQry req) {
        // 各业务前端调用接口保存后，传递选中后的公司全称或信用编号，发起工商详情入库操作（不影响主流程）
        List<CrmCompanyInfo> crmCompanyInfos = crmCompanyQryService.listCrmCompanyInfo(req);
        // 逻辑：判断根据信用编号或公司全称，获取工商详情，没有查到的话，就从接口查询详情
        if (crmCompanyInfos != null && crmCompanyInfos.size() <= 0) {

            // 逻辑：数据库没查到，从接口查询到返回，插入数据库(不影响整体业务)
            try {
                CrmCompanyInfo info = new CrmCompanyInfo();
                QueryCompanyDto dto = new QueryCompanyDto();

                // 基础信息
                String searchWord = req.getCreditCode();
                if(searchWord == null){
                    searchWord = req.getCompanyName();
                }
                dto.setKeyword(searchWord);
                JSONObject basicResultJsonObject = TYCApi.queryBasicInfo(dto);
                String companyNameDbStr = basicResultJsonObject.getString("name");
                String creditCodeDbStr = req.getCreditCode();
                String basicDbStr = JSONObject.toJSONString(basicResultJsonObject);
                info.setCreditCode(creditCodeDbStr);
                info.setCompanyName(companyNameDbStr);
                info.setBasicInfo(basicDbStr);

                // 设置公司信息查询统一参数：信用编号
                dto.setKeyword(req.getCreditCode());
                dto.setSearchKey(searchWord);
                // 股东信息
                JSONArray holderResultJsonObject = TYCApi.queryShareholderInfo(dto);
                String holderDbStr = JSONObject.toJSONString(holderResultJsonObject);
                info.setShareholderInfo(holderDbStr);

                // 主要成员信息
                JSONArray memberResultJsonObject = TYCApi.queryMemberInfo(dto);
                String memberDbStr = JSONObject.toJSONString(memberResultJsonObject);
                info.setMemberInfo(memberDbStr);

//                // 变更信息
//                String changeIntfStr = QccApi.queryChangeInfo(dto);
//                JSONArray changeResultJsonObject = JSONObject.parseObject(changeIntfStr).getJSONArray("Result");
//                String changeDbStr = JSONObject.toJSONString(changeResultJsonObject);
//                info.setChangeInfo(changeDbStr);

                // 分支机构
                JSONArray branchResultJsonObject = TYCApi.queryBranchInfo(dto);
                String branchDbStr = JSONObject.toJSONString(branchResultJsonObject);
                info.setBranchInfo(branchDbStr);

                // 运营信息
                // info.setOperationInfo();

                // 返回工商信息入库
                crmCompanyAppService.insertCrmCompanyInfo(info);
                return info;
            } catch (Exception e) {
                log.error("公司{}接口查询返回入库", req.getCompanyName());
                e.printStackTrace();
                throw new CustomException("查询工商信息详情接口与入库异常");
            }
        } else {
            // 转换成json对象，带有反斜杠的问题
            return crmCompanyInfos.get(0);
        }
    }

}
