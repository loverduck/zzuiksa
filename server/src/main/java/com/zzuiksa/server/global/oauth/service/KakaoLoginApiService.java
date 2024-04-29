package com.zzuiksa.server.global.oauth.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.zzuiksa.server.global.oauth.client.KakaoTokenClient;
import com.zzuiksa.server.global.oauth.client.KakaoUserInfoClient;
import com.zzuiksa.server.global.oauth.data.request.KakaoTokenRequest;
import com.zzuiksa.server.global.oauth.data.response.KakaoTokenResponse;
import com.zzuiksa.server.global.oauth.data.response.KakaoUserInfoResponse;
import com.zzuiksa.server.global.oauth.data.OauthUserDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class KakaoLoginApiService {

	private final String CONTENT_TYPE = "application/x-www-form-urlencoded;charset=utf8";
	private final KakaoTokenClient kakaoTokenClient;
	private final KakaoUserInfoClient kakaoUserInfoClient;

	@Value("${oauth.kakao.client.id}")
	private String clientId;

	@Value("${oauth.kakao.client.secret}")
	private String clientSecret;

	public String getAccessToken(String code) {
		KakaoTokenRequest kakaoTokenRequest = KakaoTokenRequest.builder()
			.grant_type("authorization_code")
			.client_id(clientId)
			.client_secret(clientSecret)
			.redirect_uri("localhost:8080/api/auth/login/kakao")
			.code(code)
			.build();

		KakaoTokenResponse kakaoTokenResponse = kakaoTokenClient.getKakaoToken(CONTENT_TYPE, kakaoTokenRequest);
		return kakaoTokenResponse.getAccessToken();
	}

	public OauthUserDto getUserInfo(String accessToken) {
		KakaoUserInfoResponse kakaoUserInfoResponse = kakaoUserInfoClient.getUserInfo(CONTENT_TYPE, "Bearer " + accessToken);
		return OauthUserDto.builder()
			.id(kakaoUserInfoResponse.getId())
			.email(kakaoUserInfoResponse.getKakaoAccount().getEmail())
			.name(kakaoUserInfoResponse.getKakaoAccount().getName())
			.nickname(kakaoUserInfoResponse.getKakaoAccount().getProfile().getNickname())
			.profileImageUrl(kakaoUserInfoResponse.getKakaoAccount().getProfile().getProfileImageUrl())
			.build();
	}
}
