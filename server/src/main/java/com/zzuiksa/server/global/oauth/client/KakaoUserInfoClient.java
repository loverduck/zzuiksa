package com.zzuiksa.server.global.oauth.client;

import com.zzuiksa.server.global.oauth.data.response.KakaoUserInfoResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;

@FeignClient(name = "KakaoUserInfoClient", url = "${oauth.kakao.url}")
public interface KakaoUserInfoClient {

    @GetMapping(value = "/v2/user/me", consumes = "application/json", headers = {"Content-type=application/x-www-form-urlencoded"})
    KakaoUserInfoResponse getUserInfo(@RequestHeader("Authorization") String accessToken);
}
