package org.jeecg.modules.proposal.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.modules.proposal.entity.ProposalDeptLeader;

public interface IProposalDeptLeaderService extends IService<ProposalDeptLeader> {

    /** 新增/编辑部门负责人；同部门若有逻辑删除行则恢复，避免撞唯一键 */
    void saveLeader(ProposalDeptLeader entity, LoginUser loginUser);
}
