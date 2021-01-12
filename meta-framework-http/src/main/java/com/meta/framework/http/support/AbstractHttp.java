package com.meta.framework.http.support;

import com.meta.framework.http.config.HttpConfig;

public abstract class AbstractHttp implements Http {
	protected HttpConfig httpConfig;

	public AbstractHttp(HttpConfig httpConfig) {
		this.httpConfig = httpConfig;
	}

	public void setHttpConfig(HttpConfig httpConfig) {
		this.httpConfig = httpConfig;
	}
}
