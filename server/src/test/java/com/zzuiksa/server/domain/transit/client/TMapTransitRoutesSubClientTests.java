package com.zzuiksa.server.domain.transit.client;

import java.time.LocalDateTime;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.zzuiksa.server.domain.transit.data.request.TMapTransitRoutesSubRequest;
import com.zzuiksa.server.domain.transit.data.response.TMapTransitRoutesSubResponse;

@SpringBootTest
@ExtendWith(SpringExtension.class)
public class TMapTransitRoutesSubClientTests {

    @Value("${api.tmap.app-key}")
    private String tmapAppKey;

    @Autowired
    private TMapTransitRoutesSubClient client;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    public void getTransitRoutes__success() throws Exception {
        // given
        float startLat = 126.936928f;
        float startLng = 37.555162f;
        float endLat = 127.029281f;
        float endLng = 37.564436f;
        int count = 10;
        LocalDateTime at = LocalDateTime.now();
        TMapTransitRoutesSubRequest request = TMapTransitRoutesSubRequest.of(startLat, startLng, endLat, endLng, at,
                count);

        // when
        TMapTransitRoutesSubResponse routes = client.getTransitRoutes(request, tmapAppKey);
        objectMapper.writeValue(System.out, routes);

        // then
        Assertions.assertThat(routes.findMinTotalTime()).isNotNull().isGreaterThanOrEqualTo(0);
    }
}