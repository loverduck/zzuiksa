package com.zzuiksa.server.domain.auth.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.zzuiksa.server.domain.auth.data.request.LoginRequest;
import com.zzuiksa.server.domain.auth.data.response.LoginResponse;
import com.zzuiksa.server.domain.auth.service.LoginService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
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

	@GetMapping("/test")
	public ResponseEntity<String> test() {
		return ResponseEntity.ok("test");
	}
}
