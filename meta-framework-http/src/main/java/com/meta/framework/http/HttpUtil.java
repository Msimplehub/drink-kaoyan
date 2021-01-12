
package com.meta.framework.http;

import com.meta.framework.http.config.HttpConfig;
import com.meta.framework.http.constants.Constants;
import com.meta.framework.http.exception.FrameworkHttpException;
import com.meta.framework.http.support.AbstractHttp;
import com.meta.framework.http.support.Http;
import com.meta.framework.http.support.HttpHeader;
import com.meta.framework.http.util.ClassUtil;
import lombok.experimental.UtilityClass;

import java.util.Map;

@UtilityClass
public class HttpUtil {
	private static AbstractHttp proxy;

	private void selectHttpProxy() {
		AbstractHttp defaultProxy = null;
		ClassLoader classLoader = HttpUtil.class.getClassLoader();
		// 基于 java 11 HttpClient
		if (ClassUtil.isPresent("java.net.http.HttpClient", classLoader)) {
			defaultProxy = getHttpProxy(com.meta.framework.http.support.java11.HttpClientImpl.class);
		}
		// 基于 okhttp3
		if (null == defaultProxy && ClassUtil.isPresent("okhttp3.OkHttpClient", classLoader)) {
			defaultProxy = getHttpProxy(com.meta.framework.http.support.okhttp3.OkHttp3Impl.class);
		}
		// 基于 httpclient
		if (null == defaultProxy && ClassUtil.isPresent("org.apache.http.impl.client.HttpClients", classLoader)) {
			defaultProxy = getHttpProxy(com.meta.framework.http.support.httpclient.HttpClientImpl.class);
		}
		// 基于 hutool
		if (null == defaultProxy && ClassUtil.isPresent("cn.hutool.http.HttpRequest", classLoader)) {
			defaultProxy = getHttpProxy(com.meta.framework.http.support.hutool.HutoolImpl.class);
		}

		if (defaultProxy == null) {
			throw new FrameworkHttpException("Has no HttpImpl defined in environment!");
		}

		proxy = defaultProxy;
	}

	private static <T extends AbstractHttp> AbstractHttp getHttpProxy(Class<T> clazz) {
		try {
			return clazz.newInstance();
		} catch (Throwable e) {
			return null;
		}
	}

	public void setHttp(AbstractHttp http) {
		proxy = http;
	}

	private void checkHttpNotNull(Http proxy) {
		if (null == proxy) {
			selectHttpProxy();
		}
	}

	public void setConfig(HttpConfig httpConfig) {
		checkHttpNotNull(proxy);
		if (null == httpConfig) {
			httpConfig = HttpConfig.builder().timeout(Constants.DEFAULT_TIMEOUT).build();
		}
		proxy.setHttpConfig(httpConfig);
	}

	/**
	 * GET 请求
	 *
	 * @param url URL
	 * @return 结果
	 */
	public String get(String url) {
		checkHttpNotNull(proxy);
		return proxy.get(url);
	}

	/**
	 * GET 请求
	 *
	 * @param url    URL
	 * @param params 参数
	 * @param encode 是否需要 url encode
	 * @return 结果
	 */
	public String get(String url, Map<String, String> params, boolean encode) {
		checkHttpNotNull(proxy);
		return proxy.get(url, params, encode);
	}

	/**
	 * GET 请求
	 *
	 * @param url    URL
	 * @param params 参数
	 * @param header 请求头
	 * @param encode 是否需要 url encode
	 * @return 结果
	 */
	public String get(String url, Map<String, String> params, HttpHeader header, boolean encode) {
		checkHttpNotNull(proxy);
		return proxy.get(url, params, header, encode);
	}

	/**
	 * POST 请求
	 *
	 * @param url URL
	 * @return 结果
	 */
	public String post(String url) {
		checkHttpNotNull(proxy);
		return proxy.post(url);
	}

	/**
	 * POST 请求
	 *
	 * @param url  URL
	 * @param data JSON 参数
	 * @return 结果
	 */
	public String post(String url, String data) {
		checkHttpNotNull(proxy);
		return proxy.post(url, data);
	}

	/**
	 * POST 请求
	 *
	 * @param url    URL
	 * @param data   JSON 参数
	 * @param header 请求头
	 * @return 结果
	 */
	public String post(String url, String data, HttpHeader header) {
		checkHttpNotNull(proxy);
		return proxy.post(url, data, header);
	}

	/**
	 * POST 请求
	 *
	 * @param url    URL
	 * @param params form 参数
	 * @param encode 是否需要 url encode
	 * @return 结果
	 */
	public String post(String url, Map<String, String> params, boolean encode) {
		checkHttpNotNull(proxy);
		return proxy.post(url, params, encode);
	}

	/**
	 * POST 请求
	 *
	 * @param url    URL
	 * @param params form 参数
	 * @param header 请求头
	 * @param encode 是否需要 url encode
	 * @return 结果
	 */
	public String post(String url, Map<String, String> params, HttpHeader header, boolean encode) {
		checkHttpNotNull(proxy);
		return proxy.post(url, params, header, encode);
	}
}
