package com.zzuiksa.server.global.oauth;

import static org.mockito.BDDMockito.*;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.BDDMockito;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.cloud.contract.wiremock.AutoConfigureWireMock;

import com.zzuiksa.server.global.oauth.client.KakaoTokenClient;
import com.zzuiksa.server.global.oauth.client.KakaoUserInfoClient;
import com.zzuiksa.server.global.oauth.service.KakaoLoginApiService;

@AutoConfigureWireMock(port = 0)
@ExtendWith(MockitoExtension.class)
public class KakaoLoginApiServiceTests {

	@InjectMocks
	private KakaoLoginApiService kakaoLoginApiService;

	@Test
	void getAccessToken_success() {

	}
}
