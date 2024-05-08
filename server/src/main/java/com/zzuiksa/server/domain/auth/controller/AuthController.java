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

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@Tag(name = "Auth", description = "로그인/로그아웃 API")
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final LoginService loginService;

    @Operation(
            summary = "카카오 로그인",
            description = "카카오로 로그인을 진행합니다."
    )
    @PostMapping("/login/kakao")
    public LoginResponse kakaoLogin(@RequestBody @Valid KakaoLoginRequest loginRequest) {
        return loginService.kakaoLogin(loginRequest.getAccessToken());
    }

    @Operation(
            summary = "게스트 로그인",
            description = "게스트로 로그인을 진행합니다."
    )
    @PostMapping("/login/guest")
    public LoginResponse guestLogin() {
        return loginService.guestLogin();
    }

    @Operation(
            summary = "카카오 계정 연동",
            description = "게스트 계정을 카카오 계정과 연동합니다."
    )
    @PostMapping("/connect")
    public void connectKakao(@RequestBody @Valid KakaoLoginRequest loginRequest,
            @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        loginService.connectKakaoAccount(loginRequest.getAccessToken(), member);
    }
}
