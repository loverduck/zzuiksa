package com.zzuiksa.server.domain.auth.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.zzuiksa.server.domain.auth.data.response.LoginResponse;
import com.zzuiksa.server.domain.auth.service.LoginService;

import lombok.RequiredArgsConstructor;

@Tag(name = "Test", description = "테스트 API")
@RestController
@RequestMapping("/api/auth/test")
@RequiredArgsConstructor
public class AuthTestController {

    private final LoginService loginService;

    @Operation(
            summary = "테스트용 토큰 발급",
            description = "테스트용 토큰을 발급합니다."
    )
    @PostMapping("/login/{userId}")
    public LoginResponse getToken(@PathVariable long userId) {
        return loginService.generateAccessToken(userId);
    }
}
