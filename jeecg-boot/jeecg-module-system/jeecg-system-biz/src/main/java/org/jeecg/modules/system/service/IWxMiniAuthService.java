package org.jeecg.modules.system.service;

import com.alibaba.fastjson.JSONObject;
import org.jeecg.common.api.vo.Result;
import org.jeecg.modules.system.model.WxMiniLoginDTO;

/**
 * 微信小程序登录：静默登录、工号绑定、管理端解绑（系统公共能力，不绑定某一业务模块）
 */
public interface IWxMiniAuthService {

    String THIRD_TYPE = "wechat_mp";

    /**
     * 静默登录：jsCode 换 OpenID，已绑定则签发 APP Token
     */
    Result<JSONObject> silentLogin(WxMiniLoginDTO dto);

    /**
     * 小程序首次绑定：工号对应档案有手机号则与微信号严校验；档案为空则放行并回填微信手机号
     */
    Result<JSONObject> bind(WxMiniLoginDTO dto);

    /**
     * 绑定前校验工号：sys_user 是否存在且账号有效（未注销/未冻结）
     */
    Result<JSONObject> checkWorkNo(String workNo);

    /**
     * 管理端解绑指定用户的微信小程序绑定
     */
    Result<String> unbind(String userId);
}
