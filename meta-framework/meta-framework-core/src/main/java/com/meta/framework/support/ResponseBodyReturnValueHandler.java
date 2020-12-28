package com.meta.framework.support;

import com.meta.framework.common.core.page.TableDataInfo;
import com.meta.framework.core.CommonRes;
import org.springframework.core.MethodParameter;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodReturnValueHandler;
import org.springframework.web.method.support.ModelAndViewContainer;

import java.lang.annotation.Annotation;

/**
 * 响应结果处理类
 *
 * @author lidongzhang
 */
public class ResponseBodyReturnValueHandler implements HandlerMethodReturnValueHandler {
    private static final String VOID = "void";

    /**
     * controller中返回void的方法统一返回值
     */
    private final CommonRes voidSuccess;
    private HandlerMethodReturnValueHandler target;

    public ResponseBodyReturnValueHandler(HandlerMethodReturnValueHandler target) {
        this.target = target;
        this.voidSuccess = CommonRes.success();
    }

    @Override
    public boolean supportsReturnType(MethodParameter returnType) {
        return target.supportsReturnType(returnType);
    }

    @Override
    public void handleReturnValue(@Nullable Object returnValue, MethodParameter returnType, ModelAndViewContainer mavContainer, NativeWebRequest webRequest) throws Exception {
        // void方法统一返回
        if (VOID.equals(returnType.getParameterType().getName())) {
            target.handleReturnValue(voidSuccess, returnType, mavContainer, webRequest);
            return;
        }

        boolean isResponseVo = returnType.getMethod().getReturnType() == CommonRes.class
                || TableDataInfo.class == returnType.getMethod().getReturnType();
        boolean noWrap = returnType.getMethodAnnotation(OriginalControllerReturnValue.class) != null;
        if (isResponseVo || noWrap || !isController(returnType.getMethod().getDeclaringClass())) {
            target.handleReturnValue(returnValue, returnType, mavContainer, webRequest);
            return;
        }

        CommonRes<Object> responseVo = CommonRes.success(returnValue);
        target.handleReturnValue(responseVo, returnType, mavContainer, webRequest);
    }

    private boolean isController(Class<?> declaringClass) {
        Annotation[] annotations = declaringClass.getAnnotations();
        if (annotations != null) {
            for (Annotation annotation : annotations) {
                if (annotation instanceof Controller || annotation instanceof RestController) {
                    return true;
                }
            }
        }
        return false;
    }
}
