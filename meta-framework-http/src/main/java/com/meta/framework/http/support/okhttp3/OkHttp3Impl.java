
package com.meta.framework.http.support.okhttp3;

import com.meta.framework.http.config.HttpConfig;
import com.meta.framework.http.constants.Constants;
import com.meta.framework.http.exception.FrameworkHttpException;
import com.meta.framework.http.support.AbstractHttp;
import com.meta.framework.http.support.HttpHeader;
import com.meta.framework.http.util.MapUtil;
import com.meta.framework.http.util.StringUtil;
import okhttp3.*;

import java.io.IOException;
import java.time.Duration;
import java.util.Map;

public class OkHttp3Impl extends AbstractHttp {
	public static final MediaType CONTENT_TYPE_JSON = MediaType.get(Constants.CONTENT_TYPE_JSON);
	private final OkHttpClient.Builder httpClientBuilder;

	public OkHttp3Impl() {
		this(new HttpConfig());
	}

	public OkHttp3Impl(HttpConfig httpConfig) {
		this(new OkHttpClient().newBuilder(), httpConfig);
	}

	public OkHttp3Impl(OkHttpClient.Builder httpClientBuilder, HttpConfig httpConfig) {
		super(httpConfig);
		this.httpClientBuilder = httpClientBuilder;
	}

	private String exec(Request.Builder requestBuilder) {
		this.addHeader(requestBuilder);
		Request request = requestBuilder.build();

		OkHttpClient httpClient;
		// 设置代理
		if (null != httpConfig.getProxy()) {
			httpClient = httpClientBuilder.connectTimeout(Duration.ofMillis(httpConfig.getTimeout())).writeTimeout(Duration.ofMillis(httpConfig.getTimeout())).readTimeout(Duration.ofMillis(httpConfig.getTimeout())).proxy(httpConfig.getProxy()).build();
		} else {
			httpClient = httpClientBuilder.connectTimeout(Duration.ofMillis(httpConfig.getTimeout())).writeTimeout(Duration.ofMillis(httpConfig.getTimeout())).readTimeout(Duration.ofMillis(httpConfig.getTimeout())).build();
		}

		try (Response response = httpClient.newCall(request).execute()) {
			if (!response.isSuccessful()) {
				throw new FrameworkHttpException("Unexpected code " + response);
			}

			return response.body().string();
		} catch (IOException e) {
			throw new FrameworkHttpException(e);
		}
	}

	/**
	 * 添加request header
	 *
	 * @param builder Request.Builder
	 */
	private void addHeader(Request.Builder builder) {
		builder.header(Constants.USER_AGENT, Constants.USER_AGENT_DATA);
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
		HttpUrl.Builder urlBuilder = HttpUrl.parse(url).newBuilder();
		if (encode) {
			MapUtil.forEach(params, urlBuilder::addEncodedQueryParameter);
		} else {
			MapUtil.forEach(params, urlBuilder::addQueryParameter);
		}
		HttpUrl httpUrl = urlBuilder.build();

		Request.Builder requestBuilder = new Request.Builder().url(httpUrl);
		if (header != null) {
			MapUtil.forEach(header.getHeaders(), requestBuilder::addHeader);
		}
		requestBuilder = requestBuilder.get();

		return exec(requestBuilder);
	}

	/**
	 * POST 请求
	 *
	 * @param url URL
	 * @return 结果
	 */
	@Override
	public String post(String url) {
		return this.post(url, Constants.EMPTY);
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
		if (StringUtil.isEmpty(data)) {
			data = Constants.EMPTY;
		}
		RequestBody body = RequestBody.create(CONTENT_TYPE_JSON, data);

		Request.Builder requestBuilder = new Request.Builder().url(url);
		if (header != null) {
			MapUtil.forEach(header.getHeaders(), requestBuilder::addHeader);
		}
		requestBuilder = requestBuilder.post(body);

		return exec(requestBuilder);
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
		FormBody.Builder formBuilder = new FormBody.Builder();
		if (encode) {
			MapUtil.forEach(params, formBuilder::addEncoded);
		} else {
			MapUtil.forEach(params, formBuilder::add);
		}
		FormBody body = formBuilder.build();

		Request.Builder requestBuilder = new Request.Builder().url(url);
		if (header != null) {
			MapUtil.forEach(header.getHeaders(), requestBuilder::addHeader);
		}
		requestBuilder = requestBuilder.post(body);

		return exec(requestBuilder);
	}
}
