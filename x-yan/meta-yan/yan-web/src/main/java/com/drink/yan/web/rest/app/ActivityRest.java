package com.drink.yan.web.rest.app;

import com.drink.yan.intf.entity.YanActivity;
import com.meta.act.app.service.ISysNoticeService;
import com.meta.act.entity.SysNotice;
import com.meta.framework.common.annotation.Log;
import com.meta.framework.common.core.page.TableDataInfo;
import com.meta.framework.common.enums.BusinessType;
import com.meta.framework.core.CommonRes;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

/**
 * java类简单作用描述
 *
 * @Title:
 * @Package: com.drink.yan.web.rest.app.
 * @Author: M.simple
 * @Remark: The modified content
 * @CreateDate: 2023/11/23 14:58
 * @Version: v2.0
 */
@RestController
@RequestMapping("/app/activity")
public class ActivityRest {

    private ISysNoticeService noticeService;

    @ApiOperation(value = "获取热门活动", notes = "获取热门活动", tags = "学生小程序")
    @GetMapping("hot")
    public TableDataInfo<YanActivity> listHotActivity(){
        TableDataInfo<YanActivity> tableDataInfo = new TableDataInfo();
        List<YanActivity> list = new ArrayList<>();

        tableDataInfo.setRows(list);
        return tableDataInfo;
    }
}
