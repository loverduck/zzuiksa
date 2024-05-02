package com.zzuiksa.server.global.oauth.service;

import com.zzuiksa.server.global.oauth.client.KakaoTokenClient;
import com.zzuiksa.server.global.oauth.client.KakaoUserInfoClient;
import com.zzuiksa.server.global.oauth.data.OauthUserDto;
import com.zzuiksa.server.global.oauth.data.request.KakaoTokenRequest;
import com.zzuiksa.server.global.oauth.data.response.KakaoTokenResponse;
import com.zzuiksa.server.global.oauth.data.response.KakaoUserInfoResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class KakaoLoginApiService {

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

        KakaoTokenResponse kakaoTokenResponse = kakaoTokenClient.getKakaoToken(kakaoTokenRequest);
        return kakaoTokenResponse.getAccessToken();
    }

    public OauthUserDto getUserInfo(String accessToken) {
        KakaoUserInfoResponse kakaoUserInfoResponse = kakaoUserInfoClient.getUserInfo("Bearer " + accessToken);
        return OauthUserDto.builder()
                .id(kakaoUserInfoResponse.getId())
                .email(kakaoUserInfoResponse.getKakaoAccount().getEmail())
                .name(kakaoUserInfoResponse.getKakaoAccount().getName())
                .nickname(kakaoUserInfoResponse.getKakaoAccount().getProfile().getNickname())
                .profileImageUrl(kakaoUserInfoResponse.getKakaoAccount().getProfile().getProfileImageUrl())
                .build();
    }
}
