package com.zzuiksa.server.global.exception.custom;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatusCode;

@Getter
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public enum ErrorCodes implements ErrorCode {
    ;

    private final HttpStatusCode status;

    private final String code;

    private final String defaultMessage;
}
