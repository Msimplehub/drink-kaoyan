package com.meta.framework.domain;

import com.meta.framework.copy.Copyable;
import com.meta.framework.domain.event.DomainEvent;

import java.util.List;

import static com.google.common.collect.Lists.newArrayList;

/**
 *  base aggregate
 * @Title:      BaseAggregate
 * @Package:    com.msimple.shared.model.BaseAggregate
 * @Author:     M.simple
 * @Remark:     The modified content
 * @CreateDate: 2019-10-11 17:12
 * @Version:    v2.0
 */
public abstract class BaseAggregate extends Copyable {

    /**
     * domain event
     */
    private List<DomainEvent> _events;

    /**
     * add domain event 
     * @method      addEvent
     * @param       event:
     * @return
     * @author      M.simple
     * @date        2019-10-11 17:12
     * @version     v2.0
     */
    protected final void addEvent(DomainEvent event) {
        get_events().add(event);
    }

    /**
     * clear all domain event
     * @method      clearEvents
     * @param       :
     * @return      
     * @author      M.simple
     * @date        2019-10-11 17:13
     * @version     v2.0
     */
    final void clearEvents() {
        get_events().clear();
    }

    /**
     * get all domain event list
     * @method      get_events
     * @param       :
     * @return      
     * @author      M.simple
     * @date        2019-10-11 17:13
     * @version     v2.0
     */
    final List<DomainEvent> get_events() {
        if (_events == null) {
            _events = newArrayList();
        }
        return _events;
    }

}
