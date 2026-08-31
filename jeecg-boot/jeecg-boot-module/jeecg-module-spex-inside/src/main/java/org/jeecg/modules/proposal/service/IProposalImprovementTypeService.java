package org.jeecg.modules.proposal.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.jeecg.modules.proposal.entity.Proposal;
import org.jeecg.modules.proposal.entity.ProposalImprovementType;
import org.jeecg.modules.proposal.vo.ImprovementTypeOption;

import java.util.Collection;
import java.util.List;

public interface IProposalImprovementTypeService extends IService<ProposalImprovementType> {

    /** 元数据：默认仅启用项；enabledOnly=false 含停用（回显旧名） */
    List<ImprovementTypeOption> listOptions(boolean enabledOnly);

    /** 提交校验：码必须是当前启用行；名册空则不可提交 */
    void assertEnabledCodes(String improvementTypesJson);

    /** 列表/详情回显：码换名称，已停用仍显示旧名 */
    void attachTypeLabels(Collection<Proposal> proposals);

    void saveConfig(ProposalImprovementType entity);

    void deleteConfig(String id);
}
