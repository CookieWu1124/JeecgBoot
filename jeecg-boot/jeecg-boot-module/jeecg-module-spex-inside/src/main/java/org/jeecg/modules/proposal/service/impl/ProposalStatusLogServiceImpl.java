package org.jeecg.modules.proposal.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.common.util.oConvertUtils;
import org.jeecg.modules.proposal.entity.ProposalStatusLog;
import org.jeecg.modules.proposal.mapper.ProposalStatusLogMapper;
import org.jeecg.modules.proposal.service.IProposalStatusLogService;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
public class ProposalStatusLogServiceImpl extends ServiceImpl<ProposalStatusLogMapper, ProposalStatusLog>
        implements IProposalStatusLogService {

    @Override
    public List<ProposalStatusLog> listHomeFeeds(String userId, boolean approver, int limit) {
        if (oConvertUtils.isEmpty(userId) || limit <= 0) {
            return Collections.emptyList();
        }
        return baseMapper.selectHomeFeeds(userId, approver, limit);
    }
}
