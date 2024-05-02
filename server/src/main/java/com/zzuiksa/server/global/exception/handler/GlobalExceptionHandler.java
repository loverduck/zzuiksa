package com.zzuiksa.server.global.exception.handler;

import com.zzuiksa.server.global.api.ErrorResponse;
import com.zzuiksa.server.global.exception.custom.CustomException;
import feign.FeignException;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(CustomException.class)
    public ResponseEntity<ErrorResponse> handleCustomException(CustomException ex) {
        return new ResponseEntity<>(new ErrorResponse(ex.getErrorCode(), ex.getMessage()), ex.getStatus());
    }

    @ExceptionHandler(FeignException.class)
    public ResponseEntity<ErrorResponse> handlemethodValidException(FeignException ex) {
        return new ResponseEntity<>(new ErrorResponse("ZKE001", ex.getMessage()), HttpStatusCode.valueOf(ex.status()));
    }
}
