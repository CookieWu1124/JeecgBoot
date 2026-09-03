package org.jeecg.modules.proposal.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.modules.proposal.entity.ProposalHomeBroadcast;

public interface IProposalHomeBroadcastService extends IService<ProposalHomeBroadcast> {

    /** 当前租户标语；无行时返回 content 为空的对象（不落库） */
    ProposalHomeBroadcast getCurrent(LoginUser loginUser);

    /** 当前租户标语文案；无行/空串返回 "" */
    String getCurrentContent(LoginUser loginUser);

    /** 按租户 upsert */
    void saveCurrent(ProposalHomeBroadcast entity, LoginUser loginUser);
}
