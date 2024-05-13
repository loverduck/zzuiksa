package com.zzuiksa.server.domain.weather.client;

import java.util.Map;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.cloud.openfeign.SpringQueryMap;
import org.springframework.web.bind.annotation.GetMapping;

import com.zzuiksa.server.domain.weather.data.response.WeatherResponse;

@FeignClient(name = "WeatherClient", url = "${api.weather.url}")
public interface WeatherClient {

    @GetMapping(consumes = "application/json", path = "?{weatherRequest}")
    WeatherResponse getWeather(@SpringQueryMap Map<String, Object> weatherRequest);
}
