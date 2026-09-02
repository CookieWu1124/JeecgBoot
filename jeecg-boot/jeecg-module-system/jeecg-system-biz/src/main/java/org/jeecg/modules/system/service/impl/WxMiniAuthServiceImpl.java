package org.jeecg.modules.system.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import lombok.extern.slf4j.Slf4j;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.constant.CommonConstant;
import org.jeecg.common.system.util.JwtUtil;
import org.jeecg.common.util.RedisUtil;
import org.jeecg.common.util.RestUtil;
import org.jeecg.common.util.oConvertUtils;
import org.jeecg.config.JeecgBaseConfig;
import org.jeecg.modules.base.service.BaseCommonService;
import org.jeecg.modules.system.entity.SysDepart;
import org.jeecg.modules.system.entity.SysThirdAccount;
import org.jeecg.modules.system.entity.SysUser;
import org.jeecg.modules.system.model.WxMiniLoginDTO;
import org.jeecg.modules.system.service.ISysDepartService;
import org.jeecg.modules.system.service.ISysThirdAccountService;
import org.jeecg.modules.system.service.ISysUserService;
import org.jeecg.modules.system.service.IWxMiniAuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.net.URI;
import java.util.List;

/**
 * 微信小程序登录绑定（OpenID ↔ sys_user，third_type = wechat_mp）
 */
@Service
@Slf4j
public class WxMiniAuthServiceImpl implements IWxMiniAuthService {

    private static final String MSG_PROFILE_MISMATCH = "工号与手机号不一致，请联系管理员修正用户信息";
    private static final String MSG_WORK_NO_INVALID = "工号无效，请重新输入";
    private static final String MSG_BOUND_OTHER_WX = "该工号已绑定其他微信，请联系管理员解绑";
    private static final String ACCESS_TOKEN_CACHE_KEY = "wx_mini:access_token:";
    private static final String JSCODE2SESSION_URL = "https://api.weixin.qq.com/sns/jscode2session";
    private static final String CGI_TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token";
    private static final String PHONE_URL = "https://api.weixin.qq.com/wxa/business/getuserphonenumber";

    @Value("${jeecg.wx-mini.app-id:}")
    private String appId;
    @Value("${jeecg.wx-mini.app-secret:}")
    private String appSecret;

    @Autowired
    private ISysUserService sysUserService;
    @Autowired
    private ISysThirdAccountService sysThirdAccountService;
    @Autowired
    private ISysDepartService sysDepartService;
    @Autowired
    private RedisUtil redisUtil;
    @Autowired
    private JeecgBaseConfig jeecgBaseConfig;
    @Autowired
    private BaseCommonService baseCommonService;

    @Override
    public Result<JSONObject> silentLogin(WxMiniLoginDTO dto) {
        if (dto == null || oConvertUtils.isEmpty(dto.getJsCode())) {
            return Result.error("缺少微信登录凭证");
        }
        Result<String> openidRes = exchangeOpenId(dto.getJsCode());
        if (!openidRes.isSuccess()) {
            return Result.error(openidRes.getMessage());
        }
        String openid = openidRes.getResult();
        SysThirdAccount account = findByOpenid(openid);
        if (account == null || oConvertUtils.isEmpty(account.getSysUserId())) {
            JSONObject data = new JSONObject();
            data.put("bound", false);
            return Result.OK(data);
        }
        SysUser sysUser = sysUserService.getById(account.getSysUserId());
        Result<?> effective = sysUserService.checkUserIsEffective(sysUser);
        if (!effective.isSuccess()) {
            return Result.error(effective.getMessage());
        }
        return issueAppToken(sysUser, true);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Result<JSONObject> bind(WxMiniLoginDTO dto) {
        if (dto == null || oConvertUtils.isEmpty(dto.getJsCode())) {
            return Result.error("缺少微信登录凭证");
        }
        String workNo = trimToEmpty(dto.getWorkNo());
        if (oConvertUtils.isEmpty(workNo)) {
            return Result.error("请输入工号");
        }
        if (oConvertUtils.isEmpty(dto.getPhoneCode())) {
            return Result.error("缺少手机号授权");
        }
        Result<String> openidRes = exchangeOpenId(dto.getJsCode());
        if (!openidRes.isSuccess()) {
            return Result.error(openidRes.getMessage());
        }
        String openid = openidRes.getResult();

        SysUser workUser = sysUserService.getUserByName(workNo);
        if (workUser == null) {
            return Result.error(MSG_WORK_NO_INVALID);
        }
        Result<?> effective = sysUserService.checkUserIsEffective(workUser);
        if (!effective.isSuccess()) {
            return Result.error(effective.getMessage());
        }

        SysThirdAccount byOpenid = findByOpenid(openid);
        SysThirdAccount byUser = sysThirdAccountService.getOneBySysUserId(workUser.getId(), THIRD_TYPE);

        if (byOpenid != null && oConvertUtils.isNotEmpty(byOpenid.getSysUserId())
                && !byOpenid.getSysUserId().equals(workUser.getId())) {
            SysUser boundUser = sysUserService.getById(byOpenid.getSysUserId());
            return Result.error("该微信已绑定其他工号" + formatUserLabel(boundUser) + "，请联系管理员解绑");
        }
        if (byUser != null && oConvertUtils.isNotEmpty(byUser.getThirdUserId())
                && !byUser.getThirdUserId().equals(openid)) {
            return Result.error(MSG_BOUND_OTHER_WX);
        }
        if (byOpenid != null && workUser.getId().equals(byOpenid.getSysUserId())) {
            return issueAppToken(workUser, true);
        }

        Result<String> phoneRes = fetchWechatPhone(dto.getPhoneCode());
        if (!phoneRes.isSuccess()) {
            return Result.error(phoneRes.getMessage());
        }
        String wxPhone = phoneRes.getResult();
        String storedPhone = normalizePhone(workUser.getPhone());
        if (oConvertUtils.isEmpty(storedPhone)) {
            Result<String> fillRes = fillEmptyUserPhone(workUser, wxPhone);
            if (!fillRes.isSuccess()) {
                return Result.error(fillRes.getMessage());
            }
        } else if (!storedPhone.equals(normalizePhone(wxPhone))) {
            return Result.error(MSG_PROFILE_MISMATCH);
        }
        saveBinding(workUser, openid);
        return issueAppToken(workUser, true);
    }

    //update-begin---author:spex ---date:2026-09-02  for：微信小程序绑定前工号粗校验-----------
    @Override
    public Result<JSONObject> checkWorkNo(String workNo) {
        String trimmed = trimToEmpty(workNo);
        if (oConvertUtils.isEmpty(trimmed)) {
            return Result.error("请输入工号");
        }
        SysUser workUser = sysUserService.getUserByName(trimmed);
        if (workUser == null) {
            return Result.error(MSG_WORK_NO_INVALID);
        }
        Result<?> effective = sysUserService.checkUserIsEffective(workUser);
        if (!effective.isSuccess()) {
            return Result.error(effective.getMessage());
        }
        JSONObject data = new JSONObject();
        data.put("valid", true);
        data.put("workNo", trimmed);
        data.put("realname", workUser.getRealname());
        return Result.OK(data);
    }
    //update-end---author:spex ---date:2026-09-02  for：微信小程序绑定前工号粗校验-----------

    @Override
    public Result<String> unbind(String userId) {
        if (oConvertUtils.isEmpty(userId)) {
            return Result.error("缺少用户id");
        }
        LambdaQueryWrapper<SysThirdAccount> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SysThirdAccount::getSysUserId, userId);
        wrapper.eq(SysThirdAccount::getThirdType, THIRD_TYPE);
        long count = sysThirdAccountService.count(wrapper);
        if (count == 0) {
            return Result.error("该用户未绑定微信");
        }
        sysThirdAccountService.remove(wrapper);
        return Result.OK("解绑成功");
    }

    private void saveBinding(SysUser sysUser, String openid) {
        SysThirdAccount account = findByOpenid(openid);
        if (account == null) {
            account = new SysThirdAccount();
            account.setDelFlag(CommonConstant.DEL_FLAG_0);
            account.setStatus(1);
            account.setThirdType(THIRD_TYPE);
            account.setTenantId(CommonConstant.TENANT_ID_DEFAULT_VALUE);
        }
        account.setSysUserId(sysUser.getId());
        account.setThirdUserId(openid);
        account.setThirdUserUuid(openid);
        account.setRealname(sysUser.getRealname());
        sysThirdAccountService.saveOrUpdate(account);
    }

    /** 档案为空才回填。号码已在其他用户上（含已解绑未清号）则不改档案，交给管理员。 */
    private Result<String> fillEmptyUserPhone(SysUser workUser, String wxPhone) {
        if (workUser == null || oConvertUtils.isEmpty(workUser.getId()) || oConvertUtils.isEmpty(wxPhone)) {
            return Result.error("获取微信手机号失败");
        }
        SysUser occupied = sysUserService.getUserByPhone(wxPhone);
        if (occupied != null && !occupied.getId().equals(workUser.getId())) {
            log.warn("微信绑定回填跳过，手机号已被其他用户占用, userId={}, occupiedUserId={}",
                    workUser.getId(), occupied.getId());
            return Result.error("该手机号已被其他用户占用" + formatUserLabel(occupied) + "，请联系管理员处理");
        }
        sysUserService.update(new LambdaUpdateWrapper<SysUser>()
                .eq(SysUser::getId, workUser.getId())
                .set(SysUser::getPhone, wxPhone));
        workUser.setPhone(wxPhone);
        log.info("微信绑定回填空手机号, userId={}, username={}", workUser.getId(), workUser.getUsername());
        return Result.OK("ok");
    }

    private SysThirdAccount findByOpenid(String openid) {
        return sysThirdAccountService.getOneByUuidAndThirdType(
                openid, THIRD_TYPE, CommonConstant.TENANT_ID_DEFAULT_VALUE, openid);
    }

    private Result<JSONObject> issueAppToken(SysUser sysUser, boolean wechatBound) {
        Result<JSONObject> result = new Result<>();
        JSONObject obj = new JSONObject();
        String username = sysUser.getUsername();
        String syspassword = sysUser.getPassword();

        if (oConvertUtils.isEmpty(sysUser.getOrgCode())) {
            List<SysDepart> departs = sysDepartService.queryUserDeparts(sysUser.getId());
            if (departs != null && !departs.isEmpty()) {
                String orgCode = departs.get(0).getOrgCode();
                sysUser.setOrgCode(orgCode);
                sysUserService.updateUserDepart(username, orgCode, null);
            }
        }

        Result<JSONObject> loginTenantError = sysUserService.setLoginTenant(sysUser, obj, username, result);
        if (loginTenantError != null) {
            return loginTenantError;
        }

        String token = JwtUtil.sign(username, syspassword, CommonConstant.CLIENT_TYPE_APP);
        redisUtil.set(CommonConstant.PREFIX_USER_TOKEN + token, token);
        redisUtil.expire(CommonConstant.PREFIX_USER_TOKEN + token, JwtUtil.APP_EXPIRE_TIME * 2 / 1000);
        obj.put("token", token);
        obj.put("userInfo", sysUser);
        obj.put("bound", true);
        handleSingleSignOn(username, token);
        baseCommonService.addLog("用户名: " + username + ",登录成功[移动端" + (wechatBound ? "-微信" : "-工号手机号") + "]！",
                CommonConstant.LOG_TYPE_1, null);
        result.setResult(obj);
        result.setSuccess(true);
        result.setCode(200);
        result.setMessage("登录成功");
        return result;
    }

    private void handleSingleSignOn(String username, String newToken) {
        if (jeecgBaseConfig.getFirewall() == null || jeecgBaseConfig.getFirewall().getIsConcurrent() == null
                || Boolean.TRUE.equals(jeecgBaseConfig.getFirewall().getIsConcurrent())) {
            return;
        }
        String userTokenKey = CommonConstant.PREFIX_USER_TOKEN_APP + username;
        Object oldTokenObj = redisUtil.get(userTokenKey);
        if (oldTokenObj != null && !oldTokenObj.equals(newToken)) {
            redisUtil.del(CommonConstant.PREFIX_USER_TOKEN + oldTokenObj.toString());
        }
        redisUtil.set(userTokenKey, newToken);
        redisUtil.expire(userTokenKey, JwtUtil.APP_EXPIRE_TIME * 2 / 1000);
    }

    private Result<String> exchangeOpenId(String jsCode) {
        Result<String> cfg = requireWxConfig();
        if (!cfg.isSuccess()) {
            return cfg;
        }
        try {
            JSONObject vars = new JSONObject();
            vars.put("appid", appId);
            vars.put("secret", appSecret);
            vars.put("js_code", jsCode);
            vars.put("grant_type", "authorization_code");
            JSONObject body = getWeixinJson(JSCODE2SESSION_URL, vars);
            if (body == null) {
                return Result.error("微信登录失败，请稍后重试");
            }
            Integer errcode = body.getInteger("errcode");
            if (errcode != null && errcode != 0) {
                log.warn("jscode2session 失败: {}", body);
                return Result.error("微信登录失败：" + body.getString("errmsg"));
            }
            String openid = body.getString("openid");
            if (oConvertUtils.isEmpty(openid)) {
                return Result.error("微信登录失败，未获取到用户标识");
            }
            return Result.OK(openid);
        } catch (Exception e) {
            log.error("jscode2session 异常", e);
            return Result.error("微信登录失败，请稍后重试");
        }
    }

    private Result<String> fetchWechatPhone(String phoneCode) {
        Result<String> tokenRes = getAccessToken();
        if (!tokenRes.isSuccess()) {
            return tokenRes;
        }
        try {
            JSONObject vars = new JSONObject();
            vars.put("access_token", tokenRes.getResult());
            JSONObject payload = new JSONObject();
            payload.put("code", phoneCode);
            JSONObject body = postWeixinJson(PHONE_URL, vars, payload);
            if (body == null) {
                return Result.error("获取微信手机号失败，请稍后重试");
            }
            Integer errcode = body.getInteger("errcode");
            if (errcode != null && errcode != 0) {
                log.warn("getuserphonenumber 失败: {}", body);
                return Result.error("获取微信手机号失败：" + body.getString("errmsg"));
            }
            JSONObject phoneInfo = body.getJSONObject("phone_info");
            if (phoneInfo == null) {
                return Result.error("获取微信手机号失败");
            }
            String phone = normalizePhone(phoneInfo.getString("purePhoneNumber"));
            if (oConvertUtils.isEmpty(phone)) {
                phone = normalizePhone(phoneInfo.getString("phoneNumber"));
            }
            if (oConvertUtils.isEmpty(phone)) {
                return Result.error("获取微信手机号失败");
            }
            return Result.OK(phone);
        } catch (Exception e) {
            log.error("getuserphonenumber 异常", e);
            return Result.error("获取微信手机号失败，请稍后重试");
        }
    }

    private Result<String> getAccessToken() {
        Result<String> cfg = requireWxConfig();
        if (!cfg.isSuccess()) {
            return cfg;
        }
        String cacheKey = ACCESS_TOKEN_CACHE_KEY + appId;
        Object cached = redisUtil.get(cacheKey);
        if (cached != null && oConvertUtils.isNotEmpty(cached.toString())) {
            return Result.OK(cached.toString());
        }
        try {
            JSONObject vars = new JSONObject();
            vars.put("grant_type", "client_credential");
            vars.put("appid", appId);
            vars.put("secret", appSecret);
            JSONObject body = getWeixinJson(CGI_TOKEN_URL, vars);
            if (body == null) {
                return Result.error("获取微信凭证失败");
            }
            Integer errcode = body.getInteger("errcode");
            if (errcode != null && errcode != 0) {
                log.warn("cgi-bin/token 失败: {}", body);
                return Result.error("获取微信凭证失败：" + body.getString("errmsg"));
            }
            String accessToken = body.getString("access_token");
            Integer expiresIn = body.getInteger("expires_in");
            if (oConvertUtils.isEmpty(accessToken)) {
                return Result.error("获取微信凭证失败");
            }
            long ttl = expiresIn == null ? 7000L : Math.max(60L, expiresIn - 200L);
            redisUtil.set(cacheKey, accessToken, ttl);
            return Result.OK(accessToken);
        } catch (Exception e) {
            log.error("cgi-bin/token 异常", e);
            return Result.error("获取微信凭证失败，请稍后重试");
        }
    }

    /**
     * 微信接口常返回 Content-Type: text/plain，RestUtil 按 JSONObject 提取会失败。
     */
    private JSONObject getWeixinJson(String url, JSONObject query) {
        return callWeixin(HttpMethod.GET, url, query, null);
    }

    private JSONObject postWeixinJson(String url, JSONObject query, JSONObject payload) {
        return callWeixin(HttpMethod.POST, url, query, payload);
    }

    private JSONObject callWeixin(HttpMethod method, String url, JSONObject query, JSONObject payload) {
        String fullUrl = url;
        if (query != null && !query.isEmpty()) {
            fullUrl += "?" + RestUtil.asUrlVariables(query);
        }
        HttpHeaders headers = new HttpHeaders();
        HttpEntity<String> entity;
        if (payload != null) {
            headers.setContentType(MediaType.APPLICATION_JSON);
            entity = new HttpEntity<>(payload.toJSONString(), headers);
        } else {
            entity = new HttpEntity<>(headers);
        }
        ResponseEntity<String> response = RestUtil.getRestTemplate().exchange(
                URI.create(fullUrl), method, entity, String.class);
        String raw = response.getBody();
        if (oConvertUtils.isEmpty(raw)) {
            return null;
        }
        try {
            return JSONObject.parseObject(raw);
        } catch (Exception e) {
            String preview = raw.length() > 500 ? raw.substring(0, 500) : raw;
            log.warn("微信接口返回非 JSON, status={}, body={}", response.getStatusCode(), preview);
            throw e;
        }
    }

    private Result<String> requireWxConfig() {
        if (oConvertUtils.isEmpty(appId) || oConvertUtils.isEmpty(appSecret)) {
            return Result.error("未配置微信小程序 AppID/AppSecret");
        }
        return Result.OK("ok");
    }

    private String normalizePhone(String phone) {
        if (phone == null) {
            return "";
        }
        String digits = phone.replaceAll("[^0-9]", "");
        if (digits.startsWith("86") && digits.length() >= 13) {
            return digits.substring(2);
        }
        return digits;
    }

    private String formatUserLabel(SysUser user) {
        if (user == null) {
            return "";
        }
        String name = oConvertUtils.isNotEmpty(user.getRealname()) ? user.getRealname() : "";
        String workNo = oConvertUtils.isNotEmpty(user.getUsername()) ? user.getUsername() : "";
        if (oConvertUtils.isEmpty(name) && oConvertUtils.isEmpty(workNo)) {
            return "";
        }
        if (oConvertUtils.isEmpty(name)) {
            return "（" + workNo + "）";
        }
        if (oConvertUtils.isEmpty(workNo)) {
            return "（" + name + "）";
        }
        return "（" + name + " / " + workNo + "）";
    }

    private String trimToEmpty(String value) {
        return value == null ? "" : value.trim();
    }
}
