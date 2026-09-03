package org.jeecg.modules.sale.config;

import lombok.Data;

@Data
public class BaseException extends RuntimeException{
    private Integer code;
    private String msg;

    public BaseException(Integer code, String msg){
        super(msg);
        this.code = code;
        this.msg = msg;
    }

    public BaseException(String msg){
        super(msg);
        this.code = 500;
        this.msg = msg;
    }
}