package com.zzuiksa.server.domain.transit.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

import com.zzuiksa.server.domain.transit.data.request.TMapTransitRoutesSubRequest;
import com.zzuiksa.server.domain.transit.data.response.TMapTransitRoutesSubResponse;

@FeignClient(name = "TMapTransitRoutesSubClient", url = "${api.tmap.url}")
public interface TMapTransitRoutesSubClient {

    @PostMapping(value = "/transit/routes/sub", consumes = "application/json")
    TMapTransitRoutesSubResponse getTransitRoutes(@RequestBody TMapTransitRoutesSubRequest request,
            @RequestHeader("appKey") String appKey);
}
