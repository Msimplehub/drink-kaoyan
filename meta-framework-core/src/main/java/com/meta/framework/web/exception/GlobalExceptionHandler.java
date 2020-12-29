package com.meta.framework.web.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.validation.BindException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.NoHandlerFoundException;
import com.meta.framework.common.constant.HttpStatus;
import com.meta.framework.core.CommonRes;
import com.meta.framework.common.exception.BaseException;
import com.meta.framework.common.exception.CustomException;
import com.meta.framework.common.exception.DemoModeException;
import com.meta.framework.common.utils.StringUtils;

/**
 * 全局异常处理器
 * 
 * @author ruoyi
 */
@RestControllerAdvice
public class GlobalExceptionHandler
{
    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    /**
     * 基础异常
     */
    @ExceptionHandler(BaseException.class)
    public CommonRes baseException(BaseException e)
    {
        return CommonRes.error(e.getMessage());
    }

    /**
     * 业务异常
     */
    @ExceptionHandler(CustomException.class)
    public CommonRes businessException(CustomException e)
    {
        if (StringUtils.isNull(e.getCode()))
        {
            return CommonRes.error(e.getMessage());
        }
        return CommonRes.error(e.getCode(), e.getMessage());
    }

    @ExceptionHandler(NoHandlerFoundException.class)
    public CommonRes handlerNoFoundException(Exception e)
    {
        log.error(e.getMessage(), e);
        return CommonRes.error(HttpStatus.NOT_FOUND, "路径不存在，请检查路径是否正确");
    }

    @ExceptionHandler(AccessDeniedException.class)
    public CommonRes handleAuthorizationException(AccessDeniedException e)
    {
        log.error(e.getMessage());
        return CommonRes.error(HttpStatus.FORBIDDEN, "没有权限，请联系管理员授权");
    }

    @ExceptionHandler(AccountExpiredException.class)
    public CommonRes handleAccountExpiredException(AccountExpiredException e)
    {
        log.error(e.getMessage(), e);
        return CommonRes.error(e.getMessage());
    }

    @ExceptionHandler(UsernameNotFoundException.class)
    public CommonRes handleUsernameNotFoundException(UsernameNotFoundException e)
    {
        log.error(e.getMessage(), e);
        return CommonRes.error(e.getMessage());
    }

    @ExceptionHandler(Exception.class)
    public CommonRes handleException(Exception e)
    {
        log.error(e.getMessage(), e);
        return CommonRes.error(e.getMessage());
    }

    /**
     * 自定义验证异常
     */
    @ExceptionHandler(BindException.class)
    public CommonRes validatedBindException(BindException e)
    {
        log.error(e.getMessage(), e);
        String message = e.getAllErrors().get(0).getDefaultMessage();
        return CommonRes.error(message);
    }

    /**
     * 自定义验证异常
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Object validExceptionHandler(MethodArgumentNotValidException e)
    {
        log.error(e.getMessage(), e);
        String message = e.getBindingResult().getFieldError().getDefaultMessage();
        return CommonRes.error(message);
    }

    /**
     * 演示模式异常
     */
    @ExceptionHandler(DemoModeException.class)
    public CommonRes demoModeException(DemoModeException e)
    {
        return CommonRes.error("演示模式，不允许操作");
    }
}
