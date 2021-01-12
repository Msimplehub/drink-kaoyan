package com.meta.framework.http.config;

import com.meta.framework.http.constants.Constants;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.net.Proxy;
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class HttpConfig {
	/**
	 * 超时时长，单位毫秒
	 */
	private int timeout = Constants.DEFAULT_TIMEOUT;
	/**
	 * 代理配置
	 */
	private Proxy proxy;
}
