package com.zzuiksa.server.global.token;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.zzuiksa.server.global.exception.AuthenticationException;

@SpringBootTest
public class TokenProviderTest {

	@Autowired
	public TokenProvider tokenProvider;

	@Test
	public void generateToken__success() {
		// given
		long memberId = 1L;

		// when
		String token = tokenProvider.generateToken(memberId);

		// then
		Assertions.assertThat(token).isNotBlank();
	}

	@Test
	public void getTokenClaims_invalidToken_throwAuthenticationException() {
		// givin
		String token = "alf9EE3iflf25qAD15d76do9d657miu4sld6yt";

		// when & then
		Assertions.assertThatThrownBy(() -> tokenProvider.getTokenClaims(token))
			.isInstanceOf(AuthenticationException.class);
	}
}
