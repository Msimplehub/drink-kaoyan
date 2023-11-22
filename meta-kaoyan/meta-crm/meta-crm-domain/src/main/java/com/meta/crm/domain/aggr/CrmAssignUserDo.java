package com.meta.crm.domain.aggr;

import com.meta.framework.common.utils.SecurityUtils;
import com.meta.crm.intf.entity.CrmAssignUser;
import com.meta.crm.intf.entity.CrmBusiness;
import com.meta.crm.intf.enums.AssignFollowerType;
import com.meta.crm.intf.enums.AssignRole;
import com.meta.crm.intf.enums.TargetType;
import lombok.Data;
import org.springframework.beans.BeanUtils;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Data
public class CrmAssignUserDo extends CrmAssignUser {

    /**
     * 负责人名称
     */
    private String managerName;

    public static CrmAssignUserDo of(CrmAssignUser assignUser) {
        CrmAssignUserDo assignUserDo = new CrmAssignUserDo();
        BeanUtils.copyProperties(assignUser, assignUserDo);
        return assignUserDo;
    }

    public static List<CrmAssignUserDo> of(List<CrmAssignUser> assignUsers) {
        if (CollectionUtils.isEmpty(assignUsers)) {
            return new ArrayList<>();
        }

        return assignUsers.stream().map(CrmAssignUserDo::of).collect(Collectors.toList());
    }

    /**
     * 创建客户责任人
     *
     * @param managerId
     * @param customerId
     * @return
     */
    public static CrmAssignUserDo createCustomerAssignUser(Long managerId, Long customerId) {

        return createAssignUser(managerId,
                AssignFollowerType.PERSON,
                customerId,
                AssignRole.MAIN,
                TargetType.CUSTOMER);

    }

    /**
     * 创建联系人责任人
     *
     * @param managerId
     * @param contactId
     * @return
     */
    public static CrmAssignUserDo createContactAssignUser(Long managerId,
                                                          Long contactId) {

        return createAssignUser(managerId,
                AssignFollowerType.PERSON,
                contactId,
                AssignRole.MAIN,
                TargetType.CONTACT);

    }


    /**
     * 创建责任人
     *
     * @param managerId
     * @param targetId
     * @param assignRole
     * @return
     */
    public static CrmAssignUserDo createAssignUser(
            Long managerId,
            AssignFollowerType managerType,
            Long targetId,
            AssignRole assignRole,
            TargetType businessType) {

        CrmAssignUserDo assign = new CrmAssignUserDo();
        assign.setTargetType(businessType.getCode());
        assign.setTargetId(targetId);
        assign.setAssignRole(assignRole.getCode());

        assign.setManagerId(managerId);
        assign.setManagerType(managerType.getCode());


        return assign;
    }

    /**
     * 创建责任人
     *
     * @param managerId
     * @param targetId
     * @return
     */
    public static CrmAssignUserDo createAssignUser(
            Long managerId,
            Long targetId,
            TargetType businessType) {

        CrmAssignUserDo assign = new CrmAssignUserDo();
        assign.setTargetType(businessType.getCode());
        assign.setTargetId(targetId);
        assign.setAssignRole(AssignRole.MAIN.getCode());
        assign.setManagerId(managerId);
        assign.setManagerType(AssignFollowerType.PERSON.getCode());

        return assign;
    }

    /**
     * copy
     *
     * @return
     */
    public static CrmAssignUserDo copy(CrmAssignUserDo source) {

        CrmAssignUserDo assign = new CrmAssignUserDo();
        BeanUtils.copyProperties(source, assign);
        return assign;
    }

    /**
     * 更新
     *
     * @param newAssignDo
     */
    public void update(CrmAssignUserDo newAssignDo) {
        Long id = this.getId();
        BeanUtils.copyProperties(newAssignDo, this);
        this.setId(id);
    }

    /**
     * 更换责任人
     */
    public void changeManager(Long managerId, AssignFollowerType managerType) {
        this.setManagerId(managerId);
        this.setManagerType(managerType.getCode());
    }

    /**
     * 批量更新负责人,返回新对象
     *
     * @param managerId
     * @return
     */
    public static List<CrmAssignUserDo> batchUpdateManagerWithCopy(List<CrmAssignUserDo> sources,
                                                                   Long managerId, AssignFollowerType managerType) {

        if (CollectionUtils.isEmpty(sources)) {
            return new ArrayList<>();
        }

        List<CrmAssignUserDo> res = new ArrayList<>();

        for (CrmAssignUserDo source : sources) {
            CrmAssignUserDo tar = CrmAssignUserDo.copy(source);
            res.add(tar);
            tar.changeManager(managerId, managerType);
        }

        return res;
    }

    public void updateManagerId(Long assignUserId) {
        setManagerId(assignUserId);
        setUpdateBy(SecurityUtils.getUserId());
    }

    public static CrmAssignUserDo createCrmAssign(CrmBusiness crmBusiness, Long managerId) {
        CrmAssignUserDo crmAssignUserDo = new CrmAssignUserDo();
        crmAssignUserDo.setManagerId(managerId);
        crmAssignUserDo.setManagerType(AssignFollowerType.PERSON.getCode());
        crmAssignUserDo.setTargetId(crmBusiness.getId());
        crmAssignUserDo.setTargetType(TargetType.BUSINESS.getCode());
        crmAssignUserDo.setAssignRole(AssignRole.MAIN.getCode());
        return crmAssignUserDo;
    }

    public static CrmAssignUserDo createBusinessResponsible(CrmBusiness crmBusiness, Long assignUserId) {
        CrmAssignUserDo user = new CrmAssignUserDo();
        user.setManagerId(assignUserId);
        user.setManagerType(AssignFollowerType.PERSON.getCode());
        user.setTargetId(crmBusiness.getId());
        user.setTargetType(TargetType.BUSINESS.getCode());
        user.setAssignRole(AssignRole.MAIN.getCode());
        return user;
    }
}
