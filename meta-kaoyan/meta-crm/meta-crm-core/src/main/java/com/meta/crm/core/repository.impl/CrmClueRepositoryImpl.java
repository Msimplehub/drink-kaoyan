package com.meta.crm.core.repository.impl;

import com.meta.crm.core.mapper.CrmClueMapper;
import com.meta.crm.domain.tunnel.db.CrmClueRepository;
import com.meta.crm.core.repository.impl.base.TargetRepositoryImpl;
import com.meta.crm.intf.entity.CrmClue;
import com.meta.crm.domain.aggr.CrmClueDo;
import com.meta.crm.intf.domain.TargetDo;
import com.meta.crm.intf.enums.TargetType;
import com.meta.crm.intf.req.ro.CrmClueRo;
import com.meta.crm.intf.res.vo.clue.ClueListVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;

/**
 * 线索主表
 *
 * @Title: CrmClueRepositoryImpl
 * @Author: M.simple
 * @Remark: The modified content
 * @CreateDate: 2020-11-12 17:43:26
 * @Version: v2.0
 */
@Service
public class CrmClueRepositoryImpl extends TargetRepositoryImpl implements CrmClueRepository {

    @Autowired
    private CrmClueMapper crmClueMapper;

    /**
     * insert crmClue info
     *
     * @param crmClue:
     * @return void
     * @method insertCrmClue
     * @author M.simple
     * @date 2020-11-12 17:43:26
     */
    @Override
    public void insertCrmClue(CrmClue crmClue) {
        crmClueMapper.insertCrmClue(crmClue);
    }

    /**
     * batch insert crmClue info
     *
     * @param crmClues:
     * @return void
     * @method insertCrmClue
     * @author M.simple
     * @date 2020-11-12 17:43:26
     */
    @Override
    public void batchInsertCrmClue(List<CrmClue> crmClues) {
        crmClueMapper.batchInsertCrmClue(crmClues);
    }

    /**
     * update crmClue info
     *
     * @param crmClue:
     * @return int
     * @method updateCrmClue
     * @author M.simple
     * @date 2020-11-12 17:43:26
     */
    @Override
    public int updateCrmClue(CrmClue crmClue) {
        return crmClueMapper.updateCrmClue(crmClue);
    }

    /**
     * update crmClue info by Pk
     *
     * @param crmClue:
     * @return int
     * @method updateCrmClueByPk
     * @author M.simple
     * @date 2020-11-12 17:43:26
     */
    @Override
    public int updateCrmClueByPk(CrmClue crmClue) {
        return crmClueMapper.updateCrmClueByPk(crmClue);
    }

    /**
     * list crmClue info
     *
     * @param crmClue:
     * @return List<CrmClue>
     * @method listCrmClue
     * @author M.simple
     * @date 2020-11-12 17:43:26
     */
    @Override
    public List<CrmClue> listCrmClue(CrmClueRo crmClue) {
        return crmClueMapper.listCrmClue(crmClue);
    }

    @Override
    public List<ClueListVo> queryList(CrmClueRo ro) {
        return crmClueMapper.queryList(ro);
    }

    @Override
    public List<CrmClue> checkCluePhoneNum(CrmClueRo crmClueRo) {
        return crmClueMapper.checkCluePhoneNum(crmClueRo);
    }

    @Override
    public TargetDo queryTargetByTargets(Long targetId) {
        CrmClueRo clueRo = new CrmClueRo();
        clueRo.setId(targetId);
        List<CrmClue> clues = listCrmClue(clueRo);
        if (CollectionUtils.isEmpty(clues)){
            return null;
        }
        return CrmClueDo.of(clues.get(0));
    }

    @Override
    public TargetType getTargetType() {
        return TargetType.CLUE;
    }
}
