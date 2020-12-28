package com.meta.framework.domain.event;

import com.meta.framework.util.ApplicationContextUtil;
import com.meta.framework.util.UuidGenerator;
import lombok.Getter;
import org.springframework.context.ApplicationEvent;

import java.time.Instant;

import static java.time.Instant.now;


@Getter
public abstract class DomainEvent extends ApplicationEvent {
    
    private String _id = UuidGenerator.newUuid();
    
    private Instant _createdAt = now();

    public void publish(){
        DomainEventPulish domainEventPulish = ApplicationContextUtil.getBean(DomainEventPulish.class);
        domainEventPulish.publish(this);
    };

    public DomainEvent(Object source) {
        super(source);
    }

    @Override
    public String toString() {
        return this.getClass().getSimpleName() + "[" + _id + "]";
    }

}
