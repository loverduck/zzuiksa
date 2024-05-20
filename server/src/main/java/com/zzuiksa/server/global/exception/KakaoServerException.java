package com.zzuiksa.server.global.exception;

import com.zzuiksa.server.global.exception.custom.CustomException;
import com.zzuiksa.server.global.exception.custom.ErrorCode;

public class KakaoServerException extends CustomException {
    public KakaoServerException(ErrorCode errorCode) {
        super(errorCode);
    }

    public KakaoServerException(ErrorCode errorCode, String message) {
        super(errorCode, message);
    }
}
