package com.zzuiksa.server.global.oauth.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.cloud.openfeign.SpringQueryMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;

import com.zzuiksa.server.global.oauth.data.request.KakaoTokenRequest;
import com.zzuiksa.server.global.oauth.data.response.KakaoTokenResponse;

@FeignClient(name = "KakaoTokenClient", url = "${oauth.kakao.auth-url}")
public interface KakaoTokenClient {

	@PostMapping(value = "/oauth/token", consumes = "application/json")
	KakaoTokenResponse getKakaoToken(
		@RequestHeader("Content-type") String contentType,
		@SpringQueryMap KakaoTokenRequest kakaoTokenRequest);
}
