package com.meta.crm.intf.entity;

import com.meta.framework.core.BaseEntity;
import lombok.Data;

import java.io.Serializable;


/**
 * 商机关联联系人
 *
 * @author M.simple
 * @email 1111111111111@qq.com
 * @date 2020-11-12 17:43:25
 */
@Data
public class CrmBusinessContactRelate extends BaseEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 自增主键
     */
    private Long id;

    /**
     * 商机id
     */
    private Long businessId;

    /**
     * 用户类型C/1W
     */
    private String type;

    /**
     * 关联用户id
     */
    private Long contactId;

}
