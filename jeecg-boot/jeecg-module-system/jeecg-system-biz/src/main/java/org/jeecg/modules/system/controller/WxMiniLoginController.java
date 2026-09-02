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
 * 微信小程序登录（系统公共能力）：静默登录、工号绑定、管理端解绑。
 * 任意业务 App 只要走同一套 sys_user + 同一小程序 AppID，即可复用本接口。
 */
@Slf4j
@RestController
@RequestMapping("/sys/wxMini")
@Tag(name = "微信小程序登录")
public class WxMiniLoginController {

    @Autowired
    private IWxMiniAuthService wxMiniAuthService;

    //update-begin---author:spex ---date:2026-08-31  for：微信小程序静默登录-----------
    @IgnoreAuth
    @Operation(summary = "小程序静默登录")
    @PostMapping("/silentLogin")
    public Result<JSONObject> silentLogin(@RequestBody WxMiniLoginDTO dto) {
        return wxMiniAuthService.silentLogin(dto);
    }
    //update-end---author:spex ---date:2026-08-31  for：微信小程序静默登录-----------

    //update-begin---author:spex ---date:2026-08-31  for：微信小程序工号绑定-----------
    @IgnoreAuth
    @Operation(summary = "小程序首次绑定")
    @PostMapping("/bind")
    public Result<JSONObject> bind(@RequestBody WxMiniLoginDTO dto) {
        return wxMiniAuthService.bind(dto);
    }
    //update-end---author:spex ---date:2026-08-31  for：微信小程序工号绑定-----------

    //update-begin---author:spex ---date:2026-09-02  for：微信小程序绑定前工号粗校验-----------
    @IgnoreAuth
    @Operation(summary = "绑定前校验工号")
    @PostMapping("/checkWorkNo")
    public Result<JSONObject> checkWorkNo(@RequestBody WxMiniLoginDTO dto) {
        return wxMiniAuthService.checkWorkNo(dto == null ? null : dto.getWorkNo());
    }
    //update-end---author:spex ---date:2026-09-02  for：微信小程序绑定前工号粗校验-----------

    //update-begin---author:spex ---date:2026-08-31  for：管理端解绑微信小程序-----------
    @Operation(summary = "管理端解绑微信")
    @PostMapping("/unbind")
    public Result<String> unbind(@RequestBody WxMiniLoginDTO dto) {
        return wxMiniAuthService.unbind(dto == null ? null : dto.getUserId());
    }
    //update-end---author:spex ---date:2026-08-31  for：管理端解绑微信小程序-----------
}
