package com.zzuiksa.server.domain.route.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

import com.zzuiksa.server.domain.route.data.request.TMapRoutesPedestrianRequest;
import com.zzuiksa.server.domain.route.data.request.TMapRoutesRequest;
import com.zzuiksa.server.domain.route.data.request.TMapTransitRoutesSubRequest;
import com.zzuiksa.server.domain.route.data.response.TMapRoutesPedestrianResponse;
import com.zzuiksa.server.domain.route.data.response.TMapRoutesResponse;
import com.zzuiksa.server.domain.route.data.response.TMapTransitRoutesSubResponse;

@FeignClient(name = "TMapRoutesClient", url = "${api.tmap.url}")
public interface TMapRoutesClient {

    @PostMapping(value = "/transit/routes/sub", consumes = "application/json")
    TMapTransitRoutesSubResponse getTransitRoutesSub(@RequestBody TMapTransitRoutesSubRequest request,
            @RequestHeader("appKey") String appKey);

    @PostMapping(value = "/tmap/routes", consumes = "application/json")
    TMapRoutesResponse getRoutes(@RequestBody TMapRoutesRequest request, @RequestHeader("appKey") String appKey);

    @PostMapping(value = "/tmap/routes/pedestrian", consumes = "application/json")
    TMapRoutesPedestrianResponse getRoutesPedestrian(@RequestBody TMapRoutesPedestrianRequest request,
            @RequestHeader("appKey") String appKey);
}
