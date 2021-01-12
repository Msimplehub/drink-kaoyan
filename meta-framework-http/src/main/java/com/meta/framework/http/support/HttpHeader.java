
package com.meta.framework.http.support;

import java.util.HashMap;
import java.util.Map;

public class HttpHeader {
	private final Map<String, String> headers;

	public HttpHeader() {
		this.headers = new HashMap<>(16);
	}

	public HttpHeader(Map<String, String> headers) {
		this.headers = headers;
	}

	public HttpHeader add(String key, String value) {
		this.headers.put(key, value);
		return this;
	}

	public HttpHeader addAll(Map<String, String> headers) {
		this.headers.putAll(headers);
		return this;
	}

	public Map<String, String> getHeaders() {
		return this.headers;
	}
}
