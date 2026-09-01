package org.jeecg.modules.proposal.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.jeecg.modules.proposal.entity.ProposalApprover;

public interface IProposalApproverService extends IService<ProposalApprover> {

    /**
     * 全局仅一人有效：把当前 active=Y 的行逻辑删除，再插入新批准人。
     */
    void replaceCurrent(ProposalApprover entity);
}
