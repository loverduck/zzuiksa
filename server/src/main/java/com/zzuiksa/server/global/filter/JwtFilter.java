package com.zzuiksa.server.global.filter;

import java.io.IOException;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.zzuiksa.server.global.api.ErrorResponse;
import com.zzuiksa.server.global.exception.AuthException;
import com.zzuiksa.server.global.exception.custom.ErrorCodes;
import com.zzuiksa.server.global.token.TokenProvider;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class JwtFilter extends OncePerRequestFilter {

    private final TokenProvider tokenProvider;

    public JwtFilter(TokenProvider tokenProvider) {
        this.tokenProvider = tokenProvider;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
            FilterChain filterChain) throws ServletException, IOException {
        try {
            if ("OPTIONS".equals(request.getMethod())) {
                filterChain.doFilter(request, response);
                return;
            }

            String authorizationHeader = request.getHeader("Authorization");
            if (!StringUtils.hasText(authorizationHeader)) {
                filterChain.doFilter(request, response);
                return;
            }

            String[] authorizations = authorizationHeader.split(" ");
            if (authorizations.length < 2 || (!"Bearer".equals(authorizations[0]))) {
                throw new AuthException(ErrorCodes.NOT_VALID_BEARER_TYPE);
            }

            String token = authorizationHeader.split(" ")[1];
            tokenProvider.validateToken(token);

            Authentication authentication = tokenProvider.authenticate(
                    new UsernamePasswordAuthenticationToken(tokenProvider.getMemberId(token), ""));
            SecurityContextHolder.getContext().setAuthentication(authentication);

            filterChain.doFilter(request, response);
        } catch (AuthException e) {
            handleException(response, e);
        }
    }

    public void handleException(HttpServletResponse response, AuthException ex) throws
            IOException {
        response.setStatus(ex.getStatus().value());
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String json = new ObjectMapper().writeValueAsString(new ErrorResponse(ex.getErrorCode(), ex.getMessage()));
        response.getWriter().write(json);
    }
}
