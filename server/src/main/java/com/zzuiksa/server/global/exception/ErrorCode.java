package com.zzuiksa.server.global.exception;

import org.springframework.http.HttpStatusCode;

public interface ErrorCode {
    HttpStatusCode getStatus();

    String getCode();

    String getDefaultMessage();
}
