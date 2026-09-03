package org.jeecg.modules.sale.so.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * @Description: 附件操作信息
 * @Author: jeecg-boot
 * @Date:   2021-12-07
 * @Version: V1.0
 */
@Data
public class SysAnnexVo  implements Serializable {
    private static final long serialVersionUID = 1L;


    /**数据状态*/
    @Schema(description = "数据状态")
    private String delStatus;
	/**业务数据id*/
    @Schema(description = "业务数据id")
    private String buzId;
	/**业务数据类型*/
    @Schema(description = "业务数据类型")
    private String buzType;
	/**附件格式*/
    @Schema(description = "附件格式")
    private String type;
	/**文件大小（KB）*/
    @Schema(description = "文件大小（KB）")
    private BigDecimal fileSize;
    /**文件名称*/
    @Schema(description = "文件名称")
    private String fileName;
	/**附件路径*/
    @Schema(description = "附件路径")
    private String filePath;
}
