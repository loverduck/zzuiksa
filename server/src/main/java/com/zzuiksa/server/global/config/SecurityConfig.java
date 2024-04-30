package com.zzuiksa.server.global.config;

import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.annotation.web.configurers.HeadersConfigurer;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.zzuiksa.server.global.filter.JwtFilter;
import com.zzuiksa.server.global.token.TokenProvider;

import jakarta.servlet.DispatcherType;
import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

	private final TokenProvider tokenProvider;

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http
			.csrf(AbstractHttpConfigurer::disable)
			.formLogin(AbstractHttpConfigurer::disable)
			.authorizeHttpRequests(authorizeRequest ->
				authorizeRequest
					.requestMatchers(
						"/auth/login/**",
						"/api/health",
						"/h2-console/**",
						"/error"
					).permitAll()
					.anyRequest().authenticated()
			)
			.addFilterBefore(new JwtFilter(tokenProvider), UsernamePasswordAuthenticationFilter.class)
			.headers(
				headersConfigurer ->
					headersConfigurer
						.frameOptions(
							HeadersConfigurer.FrameOptionsConfig::sameOrigin
						)
			);
		return http.build();
	}

	@Bean
	public WebSecurityCustomizer webSecurityCustomizer() {
		return (web) ->
			web
				.ignoring()
				.requestMatchers(
					PathRequest.toStaticResources().atCommonLocations()
				);
	}
}
