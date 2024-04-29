package com.zzuiksa.server.domain.auth.data.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@Getter
@Builder
@ToString
public class LoginResponse {

	private String accessToken;
	private long expiresIn;
}
