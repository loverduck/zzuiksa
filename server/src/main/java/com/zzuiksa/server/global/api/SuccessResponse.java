package com.zzuiksa.server.global.api;

import lombok.Getter;

@Getter
public class SuccessResponse<T> {

    private final String status = "success";

    private final T data;

    public SuccessResponse(T data) {
        this.data = data;
    }
}
