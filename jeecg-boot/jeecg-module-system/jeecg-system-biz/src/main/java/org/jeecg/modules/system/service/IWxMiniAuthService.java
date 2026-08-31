package org.jeecg.modules.system.service;

import com.alibaba.fastjson.JSONObject;
import org.jeecg.common.api.vo.Result;
import org.jeecg.modules.system.model.WxMiniLoginDTO;

/**
 * 提案改善 App：微信小程序静默登录 / 首次绑定 / 管理端解绑
 */
public interface IWxMiniAuthService {

    String THIRD_TYPE = "wechat_mp";

    /**
     * 静默登录：jsCode 换 OpenID，已绑定则签发 APP Token
     */
    Result<JSONObject> silentLogin(WxMiniLoginDTO dto);

    /**
     * 小程序首次绑定：工号 + 微信手机号与 sys_user 联合校验后写入 sys_third_account
     */
    Result<JSONObject> bind(WxMiniLoginDTO dto);

    /**
     * 管理端解绑指定用户的微信小程序绑定
     */
    Result<String> unbind(String userId);
}
