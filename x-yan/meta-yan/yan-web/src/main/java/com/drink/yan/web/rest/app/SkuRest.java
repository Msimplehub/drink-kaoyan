package com.drink.yan.web.rest.app;

import com.drink.yan.intf.entity.YanActivity;
import com.drink.yan.intf.entity.YanSku;
import com.drink.yan.web.rest.req.qry.PageCourseSkuQry;
import com.meta.act.app.service.ISysNoticeService;
import com.meta.framework.common.core.page.TableDataInfo;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
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
@RequestMapping("/app/sku")
public class SkuRest {

    private ISysNoticeService noticeService;

    @ApiOperation(value = "获取热门体验课", notes = "获取热门体验课", tags = "学生小程序")
    @GetMapping("hot")
    public TableDataInfo<YanSku> listHotActivity(PageCourseSkuQry pageCourseSkuQry){
        TableDataInfo<YanSku> tableDataInfo = new TableDataInfo();
        List<YanSku> list = new ArrayList<>();

        tableDataInfo.setRows(list);
        return tableDataInfo;
    }
}
