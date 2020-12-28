package com.meta.framework.common.utils;


import com.meta.framework.common.exception.AssertException;
import com.meta.framework.common.exception.CustomException;

/**
 * @author lidongzhang
 */
public class AssertUtils {

    public static void isTrue(boolean b, String message) {
        if (!b) {
            throw new AssertException(message);
        }
    }

    public static void isTrue(boolean b, String message, String... args) {
        if (!b) {
            throw new AssertException(String.format(message, args));
        }
    }

    public static void isFalse(boolean b, String message) {
        if (b) {
            throw new AssertException(message);
        }
    }

    public static void notNull(Object object, String message) {
        if (object == null) {
            throw new AssertException(message);
        }
    }

    public static void isNull(Object object, String message) {
        if (object != null) {
            throw new AssertException(message);
        }
    }

    public static void throwCustomException(String message) {
        throw new CustomException(message);
    }
}
