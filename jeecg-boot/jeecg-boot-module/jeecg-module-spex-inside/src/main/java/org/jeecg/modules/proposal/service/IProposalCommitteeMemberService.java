package org.jeecg.modules.proposal.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.modules.proposal.entity.ProposalCommitteeMember;

public interface IProposalCommitteeMemberService extends IService<ProposalCommitteeMember> {

    /** 新增/编辑委员；同人若有逻辑删除行则恢复，避免撞唯一键 */
    void saveMember(ProposalCommitteeMember entity, LoginUser loginUser);
}
