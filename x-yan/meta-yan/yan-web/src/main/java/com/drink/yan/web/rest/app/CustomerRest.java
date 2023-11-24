package com.drink.yan.web.rest.app;

import com.drink.yan.intf.vo.CustomerVo;
import com.meta.act.app.service.ISysNoticeService;
import com.meta.act.entity.SysNotice;
import com.meta.framework.core.CommonRes;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
@RequestMapping("/app/customer")
public class CustomerRest {

    @ApiOperation(value = "获取轮播信息", notes = "获取轮播信息", tags = "学生小程序")
    @GetMapping("/detail/{userId}")
    public CommonRes<CustomerVo> detail(@PathVariable Long userId){

        CustomerVo customerVo = new CustomerVo();

        return CommonRes.success(customerVo);
    }

}
