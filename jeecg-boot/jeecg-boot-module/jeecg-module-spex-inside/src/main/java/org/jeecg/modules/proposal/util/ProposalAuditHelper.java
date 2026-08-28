package org.jeecg.modules.proposal.util;

import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.common.util.oConvertUtils;
import org.jeecg.modules.proposal.entity.ProposalBaseEntity;

public final class ProposalAuditHelper {

    private ProposalAuditHelper() {
    }

    public static void fillOnCreate(LoginUser user, ProposalBaseEntity entity) {
        if (user == null || entity == null) {
            return;
        }
        String workNo = oConvertUtils.isNotEmpty(user.getWorkNo()) ? user.getWorkNo() : user.getUsername();
        entity.setCreateNo(workNo);
        entity.setCreateBy(user.getRealname());
        entity.setUpdateNo(workNo);
        entity.setUpdateBy(user.getRealname());
        entity.setSysOrgCode(user.getOrgCode());
        if (oConvertUtils.isEmpty(entity.getTenantId())) {
            entity.setTenantId(resolveTenantId(user));
        }
        if (oConvertUtils.isEmpty(entity.getActive())) {
            entity.setActive("Y");
        }
    }

    public static void fillOnUpdate(LoginUser user, ProposalBaseEntity entity) {
        if (user == null || entity == null) {
            return;
        }
        String workNo = oConvertUtils.isNotEmpty(user.getWorkNo()) ? user.getWorkNo() : user.getUsername();
        entity.setUpdateNo(workNo);
        entity.setUpdateBy(user.getRealname());
    }

    private static String resolveTenantId(LoginUser user) {
        if (oConvertUtils.isNotEmpty(user.getRelTenantIds())) {
            String[] parts = user.getRelTenantIds().split(",");
            if (parts.length > 0 && oConvertUtils.isNotEmpty(parts[0])) {
                return parts[0].trim();
            }
        }
        return "";
    }
}
