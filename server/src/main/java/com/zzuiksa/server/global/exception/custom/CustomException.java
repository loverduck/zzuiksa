package com.zzuiksa.server.global.exception.custom;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatusCode;

@Getter
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public class CustomException extends RuntimeException {

    private final HttpStatusCode status;

    private final String errorCode;

    private final String message;

    public CustomException(ErrorCode errorCode) {
        this(errorCode.getStatus(), errorCode.getCode(), errorCode.getDefaultMessage());
    }

    public CustomException(ErrorCode errorCode, String message) {
        this(errorCode.getStatus(), errorCode.getCode(), message);
    }
}
