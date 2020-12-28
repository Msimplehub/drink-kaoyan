package com.meta.framework.domain.event;

import com.meta.framework.aop.define.MethodLogLevel;
import com.meta.framework.aop.define.anno.MethodLog;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Component;

/**
 * java类简单作用描述
 *
 * @Title:
 * @Package: com.meta.act.app.event.
 * @Author: M.simple
 * @Remark: The modified content
 * @CreateDate: 2020/11/26 4:46 下午
 * @Version: v2.0
 */
@Slf4j
@Component
public class DomainEventPulish {

	@Autowired
	private ApplicationEventPublisher applicationEventPublisher;

	@MethodLog(methodLogLevel = MethodLogLevel.INFO)
	public void publish(DomainEvent event){
		applicationEventPublisher.publishEvent(event);
	}
}
