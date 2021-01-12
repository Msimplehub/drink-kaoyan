package com.meta.framework.http.support.java11;

import com.meta.framework.http.config.HttpConfig;
import com.meta.framework.http.exception.FrameworkHttpException;

import java.io.IOException;
import java.net.Proxy;
import java.net.ProxySelector;
import java.net.SocketAddress;
import java.net.URI;
import java.util.Collections;
import java.util.List;

public class DefaultProxySelector extends ProxySelector {
	private HttpConfig httpConfig;

	public DefaultProxySelector(HttpConfig httpConfig) {
		this.httpConfig = httpConfig;
	}

	@Override
	public List<Proxy> select(URI uri) {
		return Collections.singletonList(httpConfig.getProxy());
	}

	@Override
	public void connectFailed(URI uri, SocketAddress sa, IOException ioe) {
		throw new FrameworkHttpException("Proxy connect failed!");
	}
}
