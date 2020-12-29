package com.meta.framework.common.exception;

/**
 * AssertException
 *
 * @author lidongzhang
 */
public class AssertException extends RuntimeException
{
    private static final long serialVersionUID = 1L;

    private Integer code;

    private String message;

    public AssertException(String message)
    {
        this.message = message;
    }

    public AssertException(String message, Integer code)
    {
        this.message = message;
        this.code = code;
    }

    public AssertException(String message, Throwable e)
    {
        super(message, e);
        this.message = message;
    }

    @Override
    public String getMessage()
    {
        return message;
    }

    public Integer getCode()
    {
        return code;
    }
}
