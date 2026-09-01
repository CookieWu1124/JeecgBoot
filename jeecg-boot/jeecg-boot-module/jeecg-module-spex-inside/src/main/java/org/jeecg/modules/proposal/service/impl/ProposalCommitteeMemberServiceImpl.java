package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.common.exception.JeecgBootBizTipException;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.common.util.oConvertUtils;
import org.jeecg.modules.proposal.entity.ProposalCommitteeMember;
import org.jeecg.modules.proposal.mapper.ProposalCommitteeMemberMapper;
import org.jeecg.modules.proposal.service.IProposalCommitteeMemberService;
import org.jeecg.modules.proposal.util.ProposalAuditHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProposalCommitteeMemberServiceImpl extends ServiceImpl<ProposalCommitteeMemberMapper, ProposalCommitteeMember>
        implements IProposalCommitteeMemberService {

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveMember(ProposalCommitteeMember entity, LoginUser loginUser) {
        if (entity == null || oConvertUtils.isEmpty(entity.getUserId())) {
            throw new JeecgBootBizTipException("userId 必填，须为 sys_user.id");
        }
        if (oConvertUtils.isEmpty(entity.getMemberStatus())) {
            entity.setMemberStatus("active");
        }
        //update-begin---author:spex ---date:2026-09-01  for：【提案配置】重加已移除委员时恢复逻辑删除行-----------
        if (oConvertUtils.isEmpty(entity.getId())) {
            ProposalCommitteeMember existing = baseMapper.selectAnyByUserId(entity.getUserId());
            if (existing != null) {
                if ("Y".equalsIgnoreCase(existing.getActive())) {
                    throw new JeecgBootBizTipException("该员工已在委员会中");
                }
                entity.setId(existing.getId());
                entity.setActive("Y");
                ProposalAuditHelper.fillOnUpdate(loginUser, entity);
                baseMapper.restoreById(entity);
                return;
            }
            ProposalAuditHelper.fillOnCreate(loginUser, entity);
            save(entity);
            return;
        }
        //update-end---author:spex ---date:2026-09-01  for：【提案配置】重加已移除委员时恢复逻辑删除行-----------
        ProposalAuditHelper.fillOnUpdate(loginUser, entity);
        updateById(entity);
    }
}
