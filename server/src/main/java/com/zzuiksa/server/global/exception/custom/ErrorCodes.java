package com.zzuiksa.server.global.exception.custom;

import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public enum ErrorCodes implements ErrorCode {

    NOT_VALID_KAKAO_TOKEN(HttpStatus.UNAUTHORIZED, "ZAE001", "Kakao access token이 유효하지 않습니다."),
    NOT_EXISTS_AUTHORIZATION(HttpStatus.UNAUTHORIZED, "ZAE002", "Authorization Header가 빈값입니다."),
    NOT_VALID_BEARER_TYPE(HttpStatus.UNAUTHORIZED, "ZAE003", "인증 타입이 Bearer 타입이 아닙니다."),
    NOT_VALID_TOKEN(HttpStatus.UNAUTHORIZED, "ZAE004", "token이 유효하지 않습니다."),
    TOKEN_EXPIRED(HttpStatus.UNAUTHORIZED, "ZAE005", "token이 만료되었습니다."),
    KAKAO_MEMBER_ALREADY_EXIST(HttpStatus.BAD_REQUEST, "ZAE006", "이미 가입되어있는 kakao 계정입니다."),
    KAKAO_MEMBER_ALREADY_CONNECTED(HttpStatus.BAD_REQUEST, "ZAE007", "이미 연동된 kakao 계정이 있습니다."),

    MEMBER_NOT_FOUND(HttpStatus.NOT_FOUND, "ZME001", "사용자가 존재하지 않습니다."),

    KAKAO_CLIENT_EXCEPTION(HttpStatus.BAD_REQUEST, "ZKE001", "형식에 맞지 않는 요청입니다."),
    KAKAO_SERVER_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "ZKE002", "Kakao Server Error."),

    SCHEDULE_NOT_FOUND(HttpStatus.NOT_FOUND, "ZSE001", "해당하는 일정이 없습니다."),
    SCHEDULE_TOO_FAR(HttpStatus.BAD_REQUEST, "ZSE004", "2년 뒤까지의 일정만 추가할 수 있습니다."),
    BAD_SCHEDULE_REPEAT(HttpStatus.BAD_REQUEST, "ZSE005", "잘못된 반복 일정입니다. (기간 내에 생성된 일정이 없음)"),

    PLACE_NOT_FOUND(HttpStatus.NOT_FOUND, "ZPE001", "장소를 찾을 수 없습니다."),
    PLACE_FORBIDDEN(HttpStatus.FORBIDDEN, "ZPE002", "장소 접근 권한이 없습니다."),
    ;

    private final HttpStatusCode status;

    private final String code;

    private final String defaultMessage;
}
