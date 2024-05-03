package com.zzuiksa.server.domain.auth.controller;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.zzuiksa.server.domain.auth.data.response.LoginResponse;
import com.zzuiksa.server.domain.auth.service.LoginService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/auth/test")
@RequiredArgsConstructor
public class AuthTestController {

    private final LoginService loginService;

    @PostMapping("/login/{userId}")
    public LoginResponse getToken(@PathVariable long userId) {
        return loginService.generateAccessToken(userId);
    }
}
