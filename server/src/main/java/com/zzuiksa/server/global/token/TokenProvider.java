package com.zzuiksa.server.global.token;

import java.time.Instant;
import java.util.Base64;
import java.util.Date;

import javax.crypto.SecretKey;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.zzuiksa.server.domain.auth.data.MemberDetail;
import com.zzuiksa.server.domain.auth.service.MemberDetailService;
import com.zzuiksa.server.global.config.TokenConfig;
import com.zzuiksa.server.global.exception.AuthException;
import com.zzuiksa.server.global.exception.custom.ErrorCodes;
import com.zzuiksa.server.global.token.data.Jwt;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TokenProvider implements AuthenticationProvider {

    private final TokenConfig tokenConfig;
    private final MemberDetailService memberDetailService;

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

    public void validateToken(String token) {
        try {
            Jwts.parser()
                    .verifyWith(getSigningKey())
                    .build()
                    .parseSignedClaims(token);
        } catch (ExpiredJwtException e) {
            throw new AuthException(ErrorCodes.TOKEN_EXPIRED);
        } catch (Exception e) {
            throw new AuthException(ErrorCodes.NOT_VALID_TOKEN);
        }
    }

    public Claims getTokenClaims(String token) {
        try {
            return Jwts.parser()
                    .verifyWith(getSigningKey())
                    .build()
                    .parseSignedClaims(token)
                    .getPayload();
        } catch (ExpiredJwtException e) {
            throw new AuthException(ErrorCodes.TOKEN_EXPIRED);
        } catch (Exception e) {
            throw new AuthException(ErrorCodes.NOT_VALID_TOKEN);
        }
    }

    public String getMemberId(String token) {
        return getTokenClaims(token)
                .getSubject();
    }

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        try {
            MemberDetail memberDetail = (MemberDetail)memberDetailService.loadUserByUsername(
                    (String)authentication.getPrincipal());

            return new UsernamePasswordAuthenticationToken(
                    memberDetail,
                    memberDetail.getPassword(),
                    memberDetail.getAuthorities()
            );
        } catch (UsernameNotFoundException ex) {
            throw new AuthException(ErrorCodes.MEMBER_NOT_FOUND);
        }
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return false;
    }
}
