
package com.meta.framework.http.support.hutool;

import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpResponse;
import com.meta.framework.http.config.HttpConfig;
import com.meta.framework.http.exception.FrameworkHttpException;
import com.meta.framework.http.support.AbstractHttp;
import com.meta.framework.http.support.HttpHeader;
import com.meta.framework.http.util.MapUtil;
import com.meta.framework.http.util.StringUtil;
import com.meta.framework.http.util.UrlUtil;

import java.util.Map;

public class HutoolImpl extends AbstractHttp {
	public HutoolImpl() {
		this(new HttpConfig());
	}

	public HutoolImpl(HttpConfig httpConfig) {
		super(httpConfig);
	}

	private String exec(HttpRequest request) {
		// 设置超时时长
		request = request.timeout(httpConfig.getTimeout());
		// 设置代理
		if (null != httpConfig.getProxy()) {
			request = request.setProxy(httpConfig.getProxy());
		}

		try (HttpResponse response = request.execute()) {
			if (!response.isOk()) {
				throw new FrameworkHttpException("Unexpected code " + response);
			}

			return response.body();
		}
	}

	/**
	 * GET 请求
	 *
	 * @param url URL
	 * @return 结果
	 */
	@Override
	public String get(String url) {
		return this.get(url, null, false);
	}

	/**
	 * GET 请求
	 *
	 * @param url    URL
	 * @param params 参数
	 * @param encode 是否需要 url encode
	 * @return 结果
	 */
	@Override
	public String get(String url, Map<String, String> params, boolean encode) {
		return this.get(url, params, null, encode);
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
	@Override
	public String get(String url, Map<String, String> params, HttpHeader header, boolean encode) {
		String baseUrl = StringUtil.appendIfNotContain(url, "?", "&");
		url = baseUrl + MapUtil.parseMapToString(params, encode);

		HttpRequest request = HttpRequest.get(url);

		if (header != null) {
			MapUtil.forEach(header.getHeaders(), request::header);
		}

		return exec(request);
	}

	/**
	 * POST 请求
	 *
	 * @param url URL
	 * @return 结果
	 */
	@Override
	public String post(String url) {
		HttpRequest request = HttpRequest.post(url);
		return this.exec(request);
	}

	/**
	 * POST 请求
	 *
	 * @param url  URL
	 * @param data JSON 参数
	 * @return 结果
	 */
	@Override
	public String post(String url, String data) {
		return this.post(url, data, null);
	}

	/**
	 * POST 请求
	 *
	 * @param url    URL
	 * @param data   JSON 参数
	 * @param header 请求头
	 * @return 结果
	 */
	@Override
	public String post(String url, String data, HttpHeader header) {
		HttpRequest request = HttpRequest.post(url);

		if (StringUtil.isNotEmpty(data)) {
			request.body(data);
		}

		if (header != null) {
			MapUtil.forEach(header.getHeaders(), request::header);
		}
		return this.exec(request);
	}

	/**
	 * POST 请求
	 *
	 * @param url    URL
	 * @param params form 参数
	 * @param encode 是否需要 url encode
	 * @return 结果
	 */
	@Override
	public String post(String url, Map<String, String> params, boolean encode) {
		return this.post(url, params, null, encode);
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
	@Override
	public String post(String url, Map<String, String> params, HttpHeader header, boolean encode) {
		HttpRequest request = HttpRequest.post(url);

		if (encode) {
			MapUtil.forEach(params, (k, v) -> request.form(k, UrlUtil.urlEncode(v)));
		} else {
			MapUtil.forEach(params, request::form);
		}

		if (header != null) {
			MapUtil.forEach(header.getHeaders(), request::header);
		}
		return this.exec(request);
	}
}
