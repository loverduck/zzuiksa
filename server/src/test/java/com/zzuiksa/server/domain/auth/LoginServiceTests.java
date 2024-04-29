package com.zzuiksa.server.domain.auth;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.transaction.annotation.Transactional;

import com.zzuiksa.server.domain.auth.service.LoginService;
import com.zzuiksa.server.domain.member.repository.MemberRepository;
import com.zzuiksa.server.global.oauth.service.KakaoLoginApiService;
import com.zzuiksa.server.global.token.TokenProvider;

@ExtendWith(MockitoExtension.class)
public class LoginServiceTests {

	@InjectMocks
	private LoginService loginService;

	@Mock
	private KakaoLoginApiService kakaoLoginApiService;

	@Mock
	private MemberRepository memberRepository;

	@Mock
	private TokenProvider tokenProvider;

	@Test
	@Transactional
	void oauthLogin_success() {

	}

}
