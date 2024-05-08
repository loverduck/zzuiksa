package com.zzuiksa.server.domain.auth.data.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@Getter
@Builder
@ToString
public class LoginResponse {

    @Schema(description = "Access Token")
    private String accessToken;

    @Schema(description = "유효기간")
    private long expiresIn;
}
