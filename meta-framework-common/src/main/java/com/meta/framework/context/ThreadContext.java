package com.meta.framework.context;

import com.alibaba.ttl.TransmittableThreadLocal;
import org.slf4j.MDC;

import java.util.UUID;

/**
 * ThreadContext
 *
 * @author lidongzhang
 */
public class ThreadContext {
    private static final ThreadLocal<String> THREAD_LOCAL = new TransmittableThreadLocal<String>() {
        @Override
        protected void beforeExecute() {
            restoreTraceId();
        }

        @Override
        protected void afterExecute() {
            removeTraceId();
        }
    };

    private static final String TRACE_ID = "traceId";

    private static String newTraceId() {
        String traceId = UUID.randomUUID().toString().replace("-", "");
        MDC.put(TRACE_ID, traceId);
        return traceId;
    }

    public static String getTraceId() {
        return THREAD_LOCAL.get();
    }

    /**
     * 和removeTraceId成对出现
     */
    public static void restoreTraceId() {
        if (THREAD_LOCAL.get() != null) {
            MDC.put(TRACE_ID, THREAD_LOCAL.get());
        }
    }

    public static void removeTraceId() {
        MDC.remove(TRACE_ID);
    }

    public static void create() {
        String traceId = newTraceId();
        THREAD_LOCAL.set(traceId);
    }

    public static void destroy() {
        THREAD_LOCAL.remove();
        removeTraceId();
    }
}
