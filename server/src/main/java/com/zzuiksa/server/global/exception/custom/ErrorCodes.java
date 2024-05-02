package com.zzuiksa.server.global.exception.custom;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;

@Getter
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public enum ErrorCodes implements ErrorCode {

    NOT_VALID_KAKAO_TOKEN(HttpStatus.UNAUTHORIZED, "ZAE001", "Kakao access token이 유효하지 않습니다."),
    NOT_EXISTS_AUTHORIZATION(HttpStatus.UNAUTHORIZED, "ZAE002", "Authorization Header가 빈값입니다."),
    NOT_VALID_TOKEN(HttpStatus.UNAUTHORIZED, "ZAE003", "token이 유효하지 않습니다."),
    TOKEN_EXPIRED(HttpStatus.UNAUTHORIZED, "ZAE004", "token이 만료되었습니다."),

    SCHEDULE_NOT_FOUND(HttpStatus.NOT_FOUND, "ZSE001", "해당하는 일정이 없습니다."),
    ;

    private final HttpStatusCode status;

    private final String code;

    private final String defaultMessage;
}
