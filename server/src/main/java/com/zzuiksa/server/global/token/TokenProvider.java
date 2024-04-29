package com.zzuiksa.server.global.token;

import java.time.Instant;
import java.util.Base64;
import java.util.Date;

import javax.crypto.SecretKey;

import org.springframework.stereotype.Service;

import com.zzuiksa.server.global.config.TokenConfig;
import com.zzuiksa.server.global.exception.AuthenticationException;
import com.zzuiksa.server.global.exception.custom.ErrorCodes;
import com.zzuiksa.server.global.token.data.Jwt;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TokenProvider {

	private final TokenConfig tokenConfig;

	private SecretKey getSigningKey() {
		byte[] keyBytes = Base64.getDecoder().decode(tokenConfig.getSecret());
		return Keys.hmacShaKeyFor(keyBytes);
	}

	public Jwt generateToken(long memberId) {
		Instant issuedAt = Instant.now();
		Instant expiresAt = issuedAt.plus(tokenConfig.getTimeToLive());

		String token = Jwts.builder()
			.issuer(tokenConfig.getIssuer())
			.subject(String.valueOf(memberId))
			.expiration(Date.from(expiresAt))
			.issuedAt(Date.from(issuedAt))
			.signWith(getSigningKey())
			.compact();

		return Jwt.builder()
			.token(token)
			.expiresIn(tokenConfig.getTimeToLive().toSeconds())
			.build();
	}

	public Claims getTokenClaims(String token) {
		try {
			return Jwts.parser()
				.verifyWith(getSigningKey())
				.build()
				.parseSignedClaims(token)
				.getPayload();
		} catch (ExpiredJwtException e) {
			throw new AuthenticationException(ErrorCodes.TOKEN_EXPIRED);
		} catch (Exception e) {
			throw new AuthenticationException(ErrorCodes.NOT_VALID_TOKEN);
		}
	}
}
