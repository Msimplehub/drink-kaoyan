
package com.meta.framework.http.support.httpclient;

import com.meta.framework.http.config.HttpConfig;
import com.meta.framework.http.constants.Constants;
import com.meta.framework.http.exception.FrameworkHttpException;
import com.meta.framework.http.support.AbstractHttp;
import com.meta.framework.http.support.HttpHeader;
import com.meta.framework.http.util.MapUtil;
import com.meta.framework.http.util.StringUtil;
import org.apache.http.Header;
import org.apache.http.HttpHost;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.Proxy;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class HttpClientImpl extends AbstractHttp {
	private final CloseableHttpClient httpClient;

	public HttpClientImpl() {
		this(HttpClients.createDefault(), new HttpConfig());
	}

	public HttpClientImpl(HttpConfig httpConfig) {
		this(HttpClients.createDefault(), httpConfig);
	}

	public HttpClientImpl(CloseableHttpClient httpClient, HttpConfig httpConfig) {
		super(httpConfig);
		this.httpClient = httpClient;
	}

	private String exec(HttpRequestBase request) {
		this.addHeader(request);
		// 设置超时时长
		RequestConfig.Builder configBuilder = RequestConfig.custom().setConnectTimeout(httpConfig.getTimeout()).setSocketTimeout(httpConfig.getTimeout()).setConnectionRequestTimeout(httpConfig.getTimeout());
		// 设置代理
		if (null != httpConfig.getProxy()) {
			Proxy proxy = httpConfig.getProxy();
			InetSocketAddress address = (InetSocketAddress) proxy.address();
			HttpHost host = new HttpHost(address.getHostName(), address.getPort(), proxy.type().name().toLowerCase());
			configBuilder.setProxy(host);
		}

		request.setConfig(configBuilder.build());

		try (CloseableHttpResponse response = this.httpClient.execute(request)) {
			if (!isSuccess(response)) {
				throw new FrameworkHttpException("Unexpected code " + response);
			}

			StringBuffer body = new StringBuffer();
			if (response.getEntity() != null) {
				body.append(EntityUtils.toString(response.getEntity(), Constants.DEFAULT_ENCODING));
			}

			return body.toString();
		} catch (IOException e) {
			throw new FrameworkHttpException(e);
		}
	}

	/**
	 * 添加request header
	 *
	 * @param request HttpRequestBase
	 */
	private void addHeader(HttpRequestBase request) {
		String ua = Constants.USER_AGENT;
		Header[] headers = request.getHeaders(ua);
		if (null == headers || headers.length == 0) {
			request.addHeader(ua, Constants.USER_AGENT_DATA);
		}
	}

	private boolean isSuccess(CloseableHttpResponse response) {
		if (response == null) {
			return false;
		}
		if (response.getStatusLine() == null) {
			return false;
		}
		return response.getStatusLine().getStatusCode() >= 200 && response.getStatusLine().getStatusCode() < 300;
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

		HttpGet httpGet = new HttpGet(url);

		if (header != null) {
			MapUtil.forEach(header.getHeaders(), httpGet::addHeader);
		}

		return exec(httpGet);
	}

	/**
	 * POST 请求
	 *
	 * @param url URL
	 * @return 结果
	 */
	@Override
	public String post(String url) {
		HttpPost httpPost = new HttpPost(url);
		return this.exec(httpPost);
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
		HttpPost httpPost = new HttpPost(url);

		if (StringUtil.isNotEmpty(data)) {
			StringEntity entity = new StringEntity(data, Constants.DEFAULT_ENCODING);
			entity.setContentEncoding(Constants.DEFAULT_ENCODING.displayName());
			entity.setContentType(Constants.CONTENT_TYPE_JSON);
			httpPost.setEntity(entity);
		}

		if (header != null) {
			MapUtil.forEach(header.getHeaders(), httpPost::addHeader);
		}

		return this.exec(httpPost);
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
		HttpPost httpPost = new HttpPost(url);

		if (MapUtil.isNotEmpty(params)) {
			List<NameValuePair> form = new ArrayList<>();
			MapUtil.forEach(params, (k, v) -> form.add(new BasicNameValuePair(k, v)));
			httpPost.setEntity(new UrlEncodedFormEntity(form, Constants.DEFAULT_ENCODING));
		}

		if (header != null) {
			MapUtil.forEach(header.getHeaders(), httpPost::addHeader);
		}

		return this.exec(httpPost);
	}
}
