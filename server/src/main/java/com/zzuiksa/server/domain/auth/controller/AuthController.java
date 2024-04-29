package com.zzuiksa.server.domain.auth.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zzuiksa.server.domain.auth.data.request.LoginRequest;
import com.zzuiksa.server.domain.auth.data.response.LoginResponse;
import com.zzuiksa.server.domain.auth.service.LoginService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

	private final LoginService loginService;

	@PostMapping("/login/kakao")
	public ResponseEntity<LoginResponse> login(@Valid @RequestBody LoginRequest loginRequest) {
		LoginResponse loginResponse = loginService.oauthLogin(loginRequest.getAccessToken());
		return ResponseEntity.ok(loginResponse);
	}

	@PostMapping("/login/guest")
	public ResponseEntity<LoginResponse> guestLogin() {
		LoginResponse loginResponse = loginService.guestLogin();
		return ResponseEntity.ok(loginResponse);
	}
}
