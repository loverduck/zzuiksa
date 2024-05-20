package com.zzuiksa.server.domain.auth.data.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;

@Getter
public class KakaoLoginRequest {

    @Schema(description = "Kakao Access Token")
    @NotNull(message = "accessToken이 필요합니다.")
    private String accessToken;
}
