package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.common.util.oConvertUtils;
import org.jeecg.modules.proposal.entity.ProposalHomeBroadcast;
import org.jeecg.modules.proposal.mapper.ProposalHomeBroadcastMapper;
import org.jeecg.modules.proposal.service.IProposalHomeBroadcastService;
import org.jeecg.modules.proposal.util.ProposalAuditHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProposalHomeBroadcastServiceImpl
        extends ServiceImpl<ProposalHomeBroadcastMapper, ProposalHomeBroadcast>
        implements IProposalHomeBroadcastService {

    @Override
    public ProposalHomeBroadcast getCurrent(LoginUser loginUser) {
        String tenantId = resolveTenantId(loginUser);
        ProposalHomeBroadcast row = getOne(new LambdaQueryWrapper<ProposalHomeBroadcast>()
                .eq(ProposalHomeBroadcast::getTenantId, tenantId)
                .last("limit 1"));
        if (row != null) {
            return row;
        }
        ProposalHomeBroadcast empty = new ProposalHomeBroadcast();
        empty.setTenantId(tenantId);
        empty.setContent("");
        return empty;
    }

    @Override
    public String getCurrentContent(LoginUser loginUser) {
        ProposalHomeBroadcast row = getCurrent(loginUser);
        return row == null || oConvertUtils.isEmpty(row.getContent()) ? "" : row.getContent().trim();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveCurrent(ProposalHomeBroadcast entity, LoginUser loginUser) {
        String tenantId = resolveTenantId(loginUser);
        String content = entity == null || entity.getContent() == null ? "" : entity.getContent().trim();
        if (content.length() > 200) {
            content = content.substring(0, 200);
        }

        ProposalHomeBroadcast existing = getOne(new LambdaQueryWrapper<ProposalHomeBroadcast>()
                .eq(ProposalHomeBroadcast::getTenantId, tenantId)
                .last("limit 1"));
        if (existing == null) {
            ProposalHomeBroadcast created = new ProposalHomeBroadcast();
            created.setContent(content);
            created.setTenantId(tenantId);
            ProposalAuditHelper.fillOnCreate(loginUser, created);
            save(created);
            return;
        }
        existing.setContent(content);
        ProposalAuditHelper.fillOnUpdate(loginUser, existing);
        updateById(existing);
    }

    private String resolveTenantId(LoginUser loginUser) {
        if (loginUser != null && oConvertUtils.isNotEmpty(loginUser.getRelTenantIds())) {
            String[] parts = loginUser.getRelTenantIds().split(",");
            if (parts.length > 0 && oConvertUtils.isNotEmpty(parts[0])) {
                return parts[0].trim();
            }
        }
        return "";
    }
}
