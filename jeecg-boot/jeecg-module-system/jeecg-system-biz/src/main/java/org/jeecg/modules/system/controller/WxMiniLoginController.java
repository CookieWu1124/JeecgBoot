package org.jeecg.modules.system.controller;

import com.alibaba.fastjson.JSONObject;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.jeecg.common.api.vo.Result;
import org.jeecg.config.shiro.IgnoreAuth;
import org.jeecg.modules.system.model.WxMiniLoginDTO;
import org.jeecg.modules.system.service.IWxMiniAuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 提案改善 App 微信小程序登录 / H5 工号+手机号登录 / 管理端解绑
 */
@Slf4j
@RestController
@RequestMapping("/sys/wxMini")
@Tag(name = "微信小程序登录")
public class WxMiniLoginController {

    @Autowired
    private IWxMiniAuthService wxMiniAuthService;

    //update-begin---author:spex ---date:2026-08-31  for：【提案App】微信静默登录-----------
    @IgnoreAuth
    @Operation(summary = "小程序静默登录")
    @PostMapping("/silentLogin")
    public Result<JSONObject> silentLogin(@RequestBody WxMiniLoginDTO dto) {
        return wxMiniAuthService.silentLogin(dto);
    }
    //update-end---author:spex ---date:2026-08-31  for：【提案App】微信静默登录-----------

    //update-begin---author:spex ---date:2026-08-31  for：【提案App】工号+微信手机号绑定-----------
    @IgnoreAuth
    @Operation(summary = "小程序首次绑定")
    @PostMapping("/bind")
    public Result<JSONObject> bind(@RequestBody WxMiniLoginDTO dto) {
        return wxMiniAuthService.bind(dto);
    }
    //update-end---author:spex ---date:2026-08-31  for：【提案App】工号+微信手机号绑定-----------

    //update-begin---author:spex ---date:2026-08-31  for：【提案App】H5工号+手机号登录-----------
    @IgnoreAuth
    @Operation(summary = "H5工号+手机号登录")
    @PostMapping("/phoneLogin")
    public Result<JSONObject> phoneLogin(@RequestBody WxMiniLoginDTO dto) {
        return wxMiniAuthService.phoneLogin(dto);
    }
    //update-end---author:spex ---date:2026-08-31  for：【提案App】H5工号+手机号登录-----------

    //update-begin---author:spex ---date:2026-08-31  for：【提案App】管理端解绑微信-----------
    @Operation(summary = "管理端解绑微信")
    @PostMapping("/unbind")
    public Result<String> unbind(@RequestBody WxMiniLoginDTO dto) {
        return wxMiniAuthService.unbind(dto == null ? null : dto.getUserId());
    }
    //update-end---author:spex ---date:2026-08-31  for：【提案App】管理端解绑微信-----------
}
