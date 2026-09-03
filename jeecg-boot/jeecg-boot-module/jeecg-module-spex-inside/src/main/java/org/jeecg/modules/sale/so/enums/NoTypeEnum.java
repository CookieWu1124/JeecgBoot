package org.jeecg.modules.sale.so.enums;

import lombok.Getter;

@Getter
public enum NoTypeEnum {
    PROJ_FORMAL("PROJ_FORMAL", "", 3),   // 正式项目：2026001
    PROJ_TEMP("PROJ_TEMP", "FC", 3);     // 临时项目：FC2026001

    private final String code;
    private final String prefix;
    private final int serialLength;

    NoTypeEnum(String code, String prefix, int serialLength) {
        this.code = code;
        this.prefix = prefix;
        this.serialLength = serialLength;
    }
}