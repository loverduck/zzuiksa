package com.zzuiksa.server.global.api;

import lombok.Getter;

@Getter
public class ErrorResponse {

    private final String status = "error";

    private final String errorCode;

    private final String message;

    public ErrorResponse(String errorCode, String message) {
        this.errorCode = errorCode;
        this.message = message;
    }
}
