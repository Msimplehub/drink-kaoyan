
package com.meta.framework.http.exception;
public class FrameworkHttpException extends RuntimeException {
	public FrameworkHttpException(Throwable cause) {
		super(cause);
	}

	public FrameworkHttpException(String message) {
		super(message);
	}

	public FrameworkHttpException(String message, Throwable cause) {
		super(message, cause);
	}
}
