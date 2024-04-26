package com.zzuiksa.server.global.exception;

import com.zzuiksa.server.global.exception.custom.CustomException;
import com.zzuiksa.server.global.exception.custom.ErrorCode;

public class AuthenticationException extends CustomException {

	public AuthenticationException(ErrorCode errorCode) {
		super(errorCode);
	}
}
