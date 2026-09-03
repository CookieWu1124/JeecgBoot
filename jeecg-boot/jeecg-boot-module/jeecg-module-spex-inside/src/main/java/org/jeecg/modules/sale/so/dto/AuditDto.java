package org.jeecg.modules.sale.so.dto;

import io.swagger.v3.oas.annotations.media.Schema; // 1. 修改导入包
import lombok.Data;

@Data
public class AuditDto {
    private static final long serialVersionUID = 1L;

    @Schema(description = "id")       // 2. 替换注解 (value -> description)
    private String id;

    @Schema(description = "审核不通过原因")
    private String reason;

    @Schema(description = "审核（1通过 0驳回）")
    private String status;
}