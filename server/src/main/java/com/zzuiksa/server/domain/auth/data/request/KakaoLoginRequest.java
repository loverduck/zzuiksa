package com.zzuiksa.server.domain.auth.data.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;

@Getter
public class KakaoLoginRequest {

    @NotNull(message = "accessToken이 필요합니다.")
    private String accessToken;
}
