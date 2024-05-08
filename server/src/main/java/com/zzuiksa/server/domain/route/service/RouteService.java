package com.zzuiksa.server.domain.route.service;

import java.time.Duration;
import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.zzuiksa.server.domain.route.client.TMapRoutesClient;
import com.zzuiksa.server.domain.route.data.request.RouteTimeRequest;
import com.zzuiksa.server.domain.route.data.request.TMapRoutesPedestrianRequest;
import com.zzuiksa.server.domain.route.data.request.TMapRoutesRequest;
import com.zzuiksa.server.domain.route.data.request.TMapTransitRoutesSubRequest;
import com.zzuiksa.server.domain.route.data.response.TMapRoutesPedestrianResponse;
import com.zzuiksa.server.domain.route.data.response.TMapRoutesResponse;
import com.zzuiksa.server.domain.route.data.response.TMapTransitRoutesSubResponse;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RouteService {

    @Value("${api.tmap.app-key}")
    private String tmapAppKey;

    private final TMapRoutesClient tmapRoutesClient;

    /**
     * @return 소요 시간 (초)
     */
    public Integer calcRouteTime(RouteTimeRequest request) {
        return switch (request.getType()) {
            case TRANSIT -> calcTransitRouteTime(request);
            case CAR -> calcCarRouteTime(request);
            case WALK -> calcWalkRouteTime(request);
        };
    }

    protected Integer calcTransitRouteTime(RouteTimeRequest request) {
        LocalDateTime startDateTime = request.getArrivalTime().minus(Duration.ofHours(2));
        TMapTransitRoutesSubRequest tmapRequest = TMapTransitRoutesSubRequest.of(
                request.getFrom().getLat(),
                request.getFrom().getLng(),
                request.getTo().getLat(),
                request.getTo().getLng(),
                startDateTime,
                10
        );
        TMapTransitRoutesSubResponse tmapResponse = tmapRoutesClient.getTransitRoutesSub(tmapRequest, tmapAppKey);
        return tmapResponse.findMinTotalTime();
    }

    protected Integer calcCarRouteTime(RouteTimeRequest request) {
        TMapRoutesRequest tmapRequest = TMapRoutesRequest.of(
                request.getFrom().getLat(),
                request.getFrom().getLng(),
                request.getTo().getLat(),
                request.getTo().getLng()
        );
        TMapRoutesResponse tmapResponse = tmapRoutesClient.getRoutes(tmapRequest, tmapAppKey);
        return tmapResponse.findMinTotalTime();
    }

    protected Integer calcWalkRouteTime(RouteTimeRequest request) {
        TMapRoutesPedestrianRequest tmapRequest = TMapRoutesPedestrianRequest.of(
                request.getFrom().getLat(),
                request.getFrom().getLng(),
                request.getTo().getLat(),
                request.getTo().getLng()
        );
        TMapRoutesPedestrianResponse tmapResponse = tmapRoutesClient.getRoutesPedestrian(tmapRequest, tmapAppKey);
        return tmapResponse.findMinTotalTime();
    }
}
