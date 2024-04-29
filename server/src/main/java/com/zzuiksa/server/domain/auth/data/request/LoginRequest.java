package com.zzuiksa.server.domain.auth.data.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;

@Getter
public class LoginRequest {

	@NotNull
	private String accessToken;
}
