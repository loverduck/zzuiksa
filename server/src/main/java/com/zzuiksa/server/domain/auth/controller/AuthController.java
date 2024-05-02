package com.zzuiksa.server.domain.auth.controller;

import com.zzuiksa.server.domain.auth.data.request.KakaoLoginRequest;
import com.zzuiksa.server.domain.auth.data.response.LoginResponse;
import com.zzuiksa.server.domain.auth.service.LoginService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final LoginService loginService;

    @PostMapping("/login/kakao")
    public LoginResponse kakaoLogin(@Valid @RequestBody KakaoLoginRequest loginRequest) {
        return loginService.kakaoLogin(loginRequest.getAccessToken());
    }

    @PostMapping("/login/guest")
    public LoginResponse guestLogin() {
        return loginService.guestLogin();
    }
}
