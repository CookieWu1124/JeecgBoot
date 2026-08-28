package org.jeecg.modules.proposal.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.modules.proposal.entity.Proposal;
import org.jeecg.modules.proposal.vo.ProposalCreateRequest;
import org.jeecg.modules.proposal.vo.ProposalDetailVo;
import org.jeecg.modules.proposal.vo.app.ProposalHomeVo;

public interface IProposalService extends IService<Proposal> {

    String createDraft(ProposalCreateRequest request, LoginUser loginUser);

    void updateDraft(String id, ProposalCreateRequest request, LoginUser loginUser);

    void submit(String id, LoginUser loginUser);

    void withdraw(String id, LoginUser loginUser);

    ProposalDetailVo getDetail(String id, LoginUser loginUser);

    IPage<Proposal> listForUser(String tab, String title, int pageNo, int pageSize, LoginUser loginUser);

    ProposalHomeVo buildHome(LoginUser loginUser);
}
