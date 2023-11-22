package com.meta.crm.web.rest;

import com.meta.framework.common.annotation.Log;
import com.meta.framework.common.core.controller.BaseController;
import com.meta.framework.core.CommonRes;
import com.meta.framework.common.core.page.TableDataInfo;
import com.meta.framework.common.enums.BusinessType;
import com.meta.crm.intf.cmd.clue.ClueConvertBusinessCmd;
import com.meta.crm.intf.cmd.clue.ClueReAssignCmd;
import com.meta.crm.intf.cmd.clue.ClueSaveCmd;
import com.meta.crm.intf.cmd.clue.ClueStatusUpdateCmd;
import com.meta.crm.intf.cmd.clue.ClueUpdateCmd;
import com.meta.crm.intf.enums.ClueStatusEnum;
import com.meta.crm.intf.req.clue.ClueDetailQry;
import com.meta.crm.intf.req.clue.ClueListQry;
import com.meta.crm.intf.req.clue.CluePhoneCheckQry;
import com.meta.crm.intf.res.vo.clue.ClueDetailVo;
import com.meta.crm.intf.res.vo.clue.ClueListVo;
import com.meta.crm.intf.res.vo.clue.CluePhoneCheckVo;
import com.meta.crm.service.app.clue.CrmClueAppService;
import com.meta.crm.service.app.clue.CrmClueQryService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/crmClue")
@Validated
public class CrmClueController extends BaseController {

    @Resource
    private CrmClueAppService crmClueAppService;

    @Resource
    private CrmClueQryService crmClueQryService;

    @PostMapping("/addClue")
    @Log(title = "新增线索", businessType = BusinessType.INSERT)
    public void add(@Validated @RequestBody ClueSaveCmd req) {
        crmClueAppService.addClue(req);
    }

    @GetMapping("/checkCluePhoneNum")
    @Log(title = "校验线索手机号是否重复", businessType = BusinessType.QUERY)
    public CluePhoneCheckVo checkCluePhoneNum(@Valid CluePhoneCheckQry req) {
        return crmClueQryService.checkCluePhoneNum(req);
    }

    @PutMapping("/reAssignClue")
    @Log(title = "批量修改线索责任人", businessType = BusinessType.UPDATE)
    public void reAssignClue(@Validated @RequestBody ClueReAssignCmd req) {
        crmClueAppService.reAssignClue(req);
    }

    @PutMapping("/closeClue")
    @Log(title = "关闭线索", businessType = BusinessType.UPDATE)
    public void closeClue(@Validated @RequestBody ClueStatusUpdateCmd req) {
        req.setClueStatus(ClueStatusEnum.CLOSED.status);
        crmClueAppService.updateClueStatus(req);
    }

    @PutMapping("/openClue")
    @Log(title = "打开线索", businessType = BusinessType.UPDATE)
    public void openClue(@Validated @RequestBody ClueStatusUpdateCmd req) {
        req.setClueStatus(ClueStatusEnum.FOLLOW_UP.status);
        crmClueAppService.updateClueStatus(req);
    }

    @GetMapping("/queryList")
    @Log(title = "查询线索列表", businessType = BusinessType.QUERY)
    public TableDataInfo<ClueListVo> queryList(@Validated ClueListQry req) {
        startPage();
        List<ClueListVo> clueListVos = crmClueQryService.queryList(req);
        return getDataTable(clueListVos);
    }

    @GetMapping("/queryDetail")
    @Log(title = "查询线索详情", businessType = BusinessType.QUERY)
    public ClueDetailVo queryDetail(@Validated ClueDetailQry req) {
        return crmClueQryService.queryDetail(req);
    }

    @PutMapping("/update")
    @Log(title = "更新线索", businessType = BusinessType.UPDATE)
    public void update(@Validated @RequestBody ClueUpdateCmd req) {
        crmClueAppService.update(req);
    }

    @PostMapping("/convertToBusiness")
    @Log(title = "线索转商机", businessType = BusinessType.UPDATE)
    public void convertToBusiness(@Validated @RequestBody ClueConvertBusinessCmd req) {
        crmClueAppService.convertToBusiness(req);
    }
}
