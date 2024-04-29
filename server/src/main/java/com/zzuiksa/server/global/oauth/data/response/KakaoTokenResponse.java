package com.zzuiksa.server.global.oauth.data.response;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;

@Getter
public class KakaoTokenResponse {

	@JsonProperty("token_type")
	private String tokenType;

	@JsonProperty("access_token")
	private String accessToken;

	@JsonProperty("expires_in")
	private int expiresIn;

	@JsonProperty("refresh_token")
	private String refreshToken;

	@JsonProperty("refresh_token_expires_in")
	private int refreshExpiresIn;

	private String scope;

	@Override
	public String toString() {
		return "Response{" +
			"token_type='" + tokenType + '\'' +
			", access_token='" + accessToken + '\'' +
			", expires_in=" + expiresIn +
			", refresh_token='" + refreshToken + '\'' +
			", refresh_token_expires_in=" + refreshExpiresIn +
			", scope='" + scope + '\'' +
			'}';
	}
}
