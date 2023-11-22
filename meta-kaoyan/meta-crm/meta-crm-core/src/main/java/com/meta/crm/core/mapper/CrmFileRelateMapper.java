package com.meta.crm.core.mapper;

import com.meta.crm.intf.entity.CrmFileRelate;
import org.springframework.stereotype.Repository;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author yanxinwei
 * @since 2020-12-15
 */
@Repository
public interface CrmFileRelateMapper {
    int addCrmFileRelate(CrmFileRelate crmFileRelate);
}
