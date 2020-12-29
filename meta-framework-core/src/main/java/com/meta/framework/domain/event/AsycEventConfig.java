package com.meta.framework.domain.event;

import com.google.common.util.concurrent.ThreadFactoryBuilder;
import org.springframework.scheduling.annotation.AsyncConfigurer;

import java.util.concurrent.*;

/**
 * java类简单作用描述
 *
 * @Title:
 * @Package: com.meta.act.app.event.
 * @Author: M.simple
 * @Remark: The modified content
 * @CreateDate: 2020/11/26 3:43 下午
 * @Version: v2.0
 */
public class AsycEventConfig implements AsyncConfigurer {

	/**
	 * 默认线程池
	 *     如果处理器无定制线程池，则使用此默认
	 */
	ExecutorService defaultExecutor = new ThreadPoolExecutor(Runtime.getRuntime().availableProcessors() + 1,
			Runtime.getRuntime().availableProcessors() + 1,
			0L, TimeUnit.MILLISECONDS,
			new LinkedBlockingQueue<Runnable>(1000),new ThreadFactoryBuilder().setNameFormat("event-bus-pool-%d").build());


	@Override
	public Executor getAsyncExecutor() {
		return defaultExecutor;
	}
}
