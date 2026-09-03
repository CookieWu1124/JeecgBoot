package org.jeecg.modules.proposal.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * 首页小广播标语（租户唯一一行）
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("proposal_home_broadcast")
@Schema(description = "首页小广播标语")
public class ProposalHomeBroadcast extends ProposalBaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @Schema(description = "标语文案")
    private String content;
}
