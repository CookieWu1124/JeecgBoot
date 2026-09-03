package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.modules.proposal.entity.ProposalApprover;
import org.jeecg.modules.proposal.mapper.ProposalApproverMapper;
import org.jeecg.modules.proposal.service.IProposalApproverService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProposalApproverServiceImpl extends ServiceImpl<ProposalApproverMapper, ProposalApprover>
        implements IProposalApproverService {

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void replaceCurrent(ProposalApprover entity) {
        // TableLogic：remove 把 active=Y 置为 N，旧批准人保留作历史
        remove(new QueryWrapper<>());
        entity.setId(null);
        entity.setActive("Y");
        save(entity);
    }
}
