package com.zzuiksa.server.domain.transport.client;

import java.time.LocalDateTime;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.zzuiksa.server.domain.transport.data.request.TMapRoutesPedestrianRequest;
import com.zzuiksa.server.domain.transport.data.request.TMapRoutesRequest;
import com.zzuiksa.server.domain.transport.data.request.TMapTransitRoutesSubRequest;
import com.zzuiksa.server.domain.transport.data.response.TMapRoutesPedestrianResponse;
import com.zzuiksa.server.domain.transport.data.response.TMapRoutesResponse;
import com.zzuiksa.server.domain.transport.data.response.TMapTransitRoutesSubResponse;

@SpringBootTest
@ExtendWith(SpringExtension.class)
public class TMapRoutesClientTests {

    @Value("${api.tmap.app-key}")
    private String tmapAppKey;

    @Autowired
    private TMapRoutesClient client;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    public void getTransitRoutesSub__success() throws Exception {
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
        TMapTransitRoutesSubResponse response = client.getTransitRoutesSub(request, tmapAppKey);
        objectMapper.writeValue(System.out, response);

        // then
        Assertions.assertThat(response.findMinTotalTime()).isNotNull().isGreaterThan(0);
    }

    @Test
    public void getRoutes__success() throws Exception {
        // given
        float startLat = 126.936928f;
        float startLng = 37.555162f;
        float endLat = 127.029281f;
        float endLng = 37.564436f;
        TMapRoutesRequest request = TMapRoutesRequest.of(startLat, startLng, endLat, endLng);

        // when
        TMapRoutesResponse response = client.getRoutes(request, tmapAppKey);
        objectMapper.writeValue(System.out, response);

        // then
        Assertions.assertThat(response.findMinTotalTime()).isNotNull().isGreaterThan(0);
    }

    @Test
    public void getRoutesPedestrian__success() throws Exception {
        // given
        float startLat = 126.936928f;
        float startLng = 37.555162f;
        float endLat = 127.029281f;
        float endLng = 37.564436f;
        TMapRoutesPedestrianRequest request = TMapRoutesPedestrianRequest.of(startLat, startLng, endLat, endLng);

        // when
        TMapRoutesPedestrianResponse response = client.getRoutesPedestrian(request, tmapAppKey);
        objectMapper.writeValue(System.out, response);

        // then
        Assertions.assertThat(response.findMinTotalTime()).isNotNull().isGreaterThan(0);
    }
}