package org.jeecg.modules.proposal.vo.app;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Data
@Schema(description = "小程序「我的」页摘要")
public class ProposalMeSummaryVo {

    /** 姓名下行：部门 · 组别（同首页）· 岗位；缺段则省略 */
    private String positionLine;

    /** 提案改善配置角色：委员 / 评分座位 / 批准人（不含提案人） */
    private List<String> roleTags = new ArrayList<>();

    /** 自己作为提案人发起的提案总数 */
    private long myProposalCount;

    /** 采纳率展示文案，如 {@code 67%}；分母=已批准+不批准为 0 时为 {@code 0%} */
    private String adoptionRate;

    /**
     * 累计奖金（元）。结案段未交付前固定占位 0
     */
    private BigDecimal totalBonus = BigDecimal.ZERO;
}
