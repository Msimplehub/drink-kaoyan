package com.meta.framework.support;

import org.apache.commons.lang3.reflect.FieldUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;
import org.springframework.web.method.support.HandlerMethodReturnValueHandler;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter;
import org.springframework.web.servlet.mvc.method.annotation.RequestResponseBodyMethodProcessor;

import java.lang.reflect.Field;
import java.util.List;
import java.util.Optional;

/**
 * Mvc配置
 *
 * @author lidongzhang
 */
@Component
public class MvcConfigurer implements ApplicationContextAware, ApplicationListener<ContextRefreshedEvent> {
    /**
     * logger
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(MvcConfigurer.class);

    private static final String RETURN_VALUE_HANDLERS = "returnValueHandlers";
    private static final String REQUEST_MAPPING_HANDLER_ADAPTER = "requestMappingHandlerAdapter";

    private ApplicationContext applicationContext;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) {
        this.applicationContext = applicationContext;
    }

    @Override
    public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
        RequestMappingHandlerAdapter adapter = (RequestMappingHandlerAdapter) applicationContext.getBean(REQUEST_MAPPING_HANDLER_ADAPTER);
        List<HandlerMethodReturnValueHandler> handlerList = null;

        try {
            Field f = FieldUtils.getDeclaredField(adapter.getClass(), RETURN_VALUE_HANDLERS, true);
            Object h = FieldUtils.readField(f, adapter);
            if (h != null) {
                Field field = FieldUtils.getDeclaredField(h.getClass(), RETURN_VALUE_HANDLERS, true);
                handlerList = (List<HandlerMethodReturnValueHandler>) field.get(h);
            }
        } catch (Exception e) {
            LOGGER.warn("Fail to replace default returnValueHandler for ResponseBody annotation");
        }

        Optional<List<HandlerMethodReturnValueHandler>> optional = Optional.ofNullable(handlerList);
        if (optional.isPresent()) {
            HandlerMethodReturnValueHandler requestHandler = optional.get().stream()
                    .filter(o -> o instanceof RequestResponseBodyMethodProcessor).findFirst().orElse(null);
            if (requestHandler != null) {
                ResponseBodyReturnValueHandler decoratorHandler = new ResponseBodyReturnValueHandler(requestHandler);
                handlerList.set(handlerList.indexOf(requestHandler), decoratorHandler);
                adapter.setReturnValueHandlers(handlerList);
            }
        }
    }
}
