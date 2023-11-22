package com.meta.crm.intf.exception;

/**
 * @ClassName HouseException
 * @Description House 异常类
 * @Author M.simple
 * @Date 2019/6/13 3:28
 * @Version 1.0
 **/
public class BusinessException extends RuntimeException{

    /**
     * @Author M.simple
     * @Description //TODO
     * @param []
     * @return
     **/
    public BusinessException() {
    }

    /**
     * @Author M.simple
     * @Description //TODO
     * @param [message]
     * @return
     **/
    public BusinessException(String message) {
        super(message);

    }

    /**
     * @Author M.simple
     * @Description //TODO
     * @param [message, cause]
     * @return
     **/
    public BusinessException(String message, Throwable cause) {
        super(message, cause);

    }

    /**
     * @Author M.simple
     * @Description //TODO
     * @param [message, cause, enableSuppression, writableStackTrace]
     * @return
     **/
    public BusinessException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);

    }

    /**
     * @Author M.simple
     * @Description //TODO
     * @param [cause]
     * @return
     **/
    public BusinessException(Throwable cause) {
        super(cause);

    }
}
