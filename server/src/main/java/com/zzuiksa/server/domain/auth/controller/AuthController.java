package com.zzuiksa.server.domain.auth.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.zzuiksa.server.domain.auth.data.MemberDetail;
import com.zzuiksa.server.domain.auth.data.request.KakaoLoginRequest;
import com.zzuiksa.server.domain.auth.data.response.LoginResponse;
import com.zzuiksa.server.domain.auth.service.LoginService;
import com.zzuiksa.server.domain.member.entity.Member;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final LoginService loginService;

    @PostMapping("/login/kakao")
    public LoginResponse kakaoLogin(@RequestBody @Valid KakaoLoginRequest loginRequest) {
        return loginService.kakaoLogin(loginRequest.getAccessToken());
    }

    @PostMapping("/login/guest")
    public LoginResponse guestLogin() {
        return loginService.guestLogin();
    }

    @PostMapping("/connect")
    public void connectKakao(@RequestBody @Valid KakaoLoginRequest loginRequest,
            @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        loginService.connectKakaoAccount(loginRequest.getAccessToken(), member);
    }
}
