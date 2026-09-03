package org.jeecg.modules.sale.config;

import com.fasterxml.jackson.databind.JsonMappingException;
import lombok.extern.slf4j.Slf4j;
import org.jeecg.common.api.vo.Result;
import org.jeecg.modules.sale.config.BaseException;
import org.jeecg.modules.sale.config.FieldCnUtil;
import org.springframework.core.annotation.Order;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Order(1)
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public Result<?> handleHttpMsgReadErr(HttpMessageNotReadableException e) {
        log.error("JSON请求体解析失败", e);
        Throwable root = e.getRootCause();
        if (root != null) {
            String rootMsg = root.getMessage();
            if (rootMsg != null && rootMsg.startsWith("NUM_FIELD|")) {
                // 第一步：按换行\n截断，只取前面标记部分，丢弃后面堆栈文本
                String pureTag = rootMsg.split("\n")[0];
                // 第二步：再按 | 分割纯净标记
                String[] splitArr = pureTag.split("\\|");
                String entityFullClass = splitArr[1];
                String fieldEn = splitArr[2];
                // 通用工具获取中文名称
                String fieldCn = FieldCnUtil.getFieldCn(entityFullClass, fieldEn);
                String tip = String.format("【%s】必须输入合法数字，不能输入文字/符号", fieldCn);
                return Result.error(500, tip);
            }
            // 兼容自定义BaseException
            if (root instanceof BaseException) {
                BaseException baseEx = (BaseException) root;
                return Result.error(baseEx.getCode(), baseEx.getMsg());
            }
        }
        // 兜底通用错误
        return Result.error(500, "请求JSON格式错误，数值字段请勿输入文字、特殊符号");
    }

    //捕获自定义业务异常
    @ExceptionHandler(BaseException.class)
    public Result<?> bizException(BaseException e){
        log.error("业务异常：{}",e.getMsg(),e);
        return Result.error(e.getCode(),e.getMsg());
    }

    //捕获自定义业务异常
/*    @ExceptionHandler(BusinessException.class)
    public Result<?> busException(BusinessException e){
        log.error("业务异常：{}",e.getMessage(),e);
        return Result.error(400,e.getMessage());
    }*/

    //原生JeecgBootException兼容
    @ExceptionHandler(org.jeecg.common.exception.JeecgBootException.class)
    public Result<?> jeecgException(Exception e){
        log.error("系统异常",e);
        return Result.error(500,e.getMessage());
    }

    //兜底未知异常
    @ExceptionHandler(Exception.class)
    public Result<?> otherException(Exception e){
        log.error("未知异常",e);
        return Result.error(500, e.getMessage());
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Result<?> validException(MethodArgumentNotValidException e) {
        log.error("参数校验失败：", e);
        FieldError error = e.getBindingResult().getFieldError();
        String msg = error.getDefaultMessage();
        return Result.error(500, msg);
    }

    /**
     * JSON反序列化数字转换失败（前端传文字到数字字段）
     */
    @ExceptionHandler(JsonMappingException.class)
    public Result<?> handleJsonMappingException(JsonMappingException e) {
        String msg = e.getMessage();
        // 提取自定义解析器抛出的友好提示，兜底默认文案
        if (msg.contains("必须输入合法")) {
            return Result.error(msg);
        }
        return Result.error("数值字段输入格式错误，请检查不要输入文字、特殊符号");
    }
}