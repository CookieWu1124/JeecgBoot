package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.common.exception.JeecgBootBizTipException;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.common.util.oConvertUtils;
import org.jeecg.modules.proposal.entity.ProposalDeptLeader;
import org.jeecg.modules.proposal.mapper.ProposalDeptLeaderMapper;
import org.jeecg.modules.proposal.service.IProposalDeptLeaderService;
import org.jeecg.modules.proposal.util.ProposalAuditHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProposalDeptLeaderServiceImpl extends ServiceImpl<ProposalDeptLeaderMapper, ProposalDeptLeader>
        implements IProposalDeptLeaderService {

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveLeader(ProposalDeptLeader entity, LoginUser loginUser) {
        if (entity == null || oConvertUtils.isEmpty(entity.getDeptId())) {
            throw new JeecgBootBizTipException("deptId 必填，须为 sys_depart.id");
        }
        //update-begin---author:spex ---date:2026-09-01  for：【提案配置】同部门已移除行恢复，避免撞唯一键-----------
        if (oConvertUtils.isEmpty(entity.getId())) {
            ProposalDeptLeader existing = baseMapper.selectAnyByDeptId(entity.getDeptId());
            if (existing != null) {
                entity.setId(existing.getId());
                entity.setActive("Y");
                ProposalAuditHelper.fillOnUpdate(loginUser, entity);
                if ("Y".equalsIgnoreCase(existing.getActive())) {
                    updateById(entity);
                } else {
                    baseMapper.restoreById(entity);
                }
                return;
            }
            ProposalAuditHelper.fillOnCreate(loginUser, entity);
            save(entity);
            return;
        }
        //update-end---author:spex ---date:2026-09-01  for：【提案配置】同部门已移除行恢复，避免撞唯一键-----------
        ProposalAuditHelper.fillOnUpdate(loginUser, entity);
        updateById(entity);
    }
}
