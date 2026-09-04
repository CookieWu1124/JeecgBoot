package org.jeecg.modules.system.model;

import lombok.Data;

/**
 * 微信小程序登录入参
 */
@Data
public class WxMiniLoginDTO {
    /** wx.login 返回的 jsCode */
    private String jsCode;
    /** 工号（sys_user.username） */
    private String workNo;
    /** 小程序 getPhoneNumber 返回的一次性授权码，不是手机号 */
    private String phoneCode;
    /** 管理端解绑目标用户 id */
    private String userId;
}
