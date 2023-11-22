package com.meta.crm.service.app.clue;

import com.meta.crm.intf.req.clue.ClueDetailQry;
import com.meta.crm.intf.req.clue.ClueListQry;
import com.meta.crm.intf.req.clue.CluePhoneCheckQry;
import com.meta.crm.intf.res.vo.clue.ClueDetailVo;
import com.meta.crm.intf.res.vo.clue.ClueListVo;
import com.meta.crm.intf.res.vo.clue.CluePhoneCheckVo;

import java.util.List;

public interface CrmClueQryService {
    /**
     * 检查是否存在同手机号线索
     *
     * @param checkCluePhoneQry
     * @return
     */
    CluePhoneCheckVo checkCluePhoneNum(CluePhoneCheckQry checkCluePhoneQry);

    /**
     * 线索列表
     *
     * @param req
     * @return
     */
    List<ClueListVo> queryList(ClueListQry req);

    /**
     * 查询详情
     *
     * @param req
     * @return
     */
    ClueDetailVo queryDetail(ClueDetailQry req);
}
