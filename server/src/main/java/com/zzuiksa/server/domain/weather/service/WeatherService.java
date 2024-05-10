package com.zzuiksa.server.domain.weather.service;

import com.zzuiksa.server.domain.weather.client.WeatherClient;

import com.zzuiksa.server.domain.weather.data.GpsTransfer;

import com.zzuiksa.server.domain.weather.data.GridDto;

import com.zzuiksa.server.domain.weather.data.ItemInfoDto;
import com.zzuiksa.server.domain.weather.data.WeatherInfoDto;
import com.zzuiksa.server.domain.weather.data.request.WeatherRequest;

import com.zzuiksa.server.domain.weather.data.response.WeatherResponse;

import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class WeatherService {

    private final WeatherClient weatherClient;

    @Value("${api.weather.key}")
    private String serviceKey;

    public WeatherInfoDto getWeatherOfTime(LocalDate date, double lat, double lng, LocalTime startTime, LocalTime endTime) {
        List<ItemInfoDto> weatherItems = getWeatherItems(date, lat, lng).stream()
                .filter(weatherItem -> isWeatherItemBetween(weatherItem, startTime, endTime))
                .toList();

        int maxPop = 0;
        int minTmp = 100;
        int maxTmp = -100;
        for (ItemInfoDto weatherItem : weatherItems) {
            switch (weatherItem.getCategory()) {
                case "POP" -> maxPop = Math.max(maxPop, weatherItem.getFcstValueAsInt());
                case "TMP" -> {
                    int fcstValue = weatherItem.getFcstValueAsInt();
                    maxTmp = Math.max(maxTmp, fcstValue);
                    minTmp = Math.min(minTmp, fcstValue);
                }
            }
        }

        return WeatherInfoDto.builder()
                .maxPop(maxPop)
                .minTmp(minTmp)
                .maxTmp(maxTmp)
                .build();
    }

    private List<ItemInfoDto> getWeatherItems(LocalDate date, double lat, double lng) {
        GridDto grid = GpsTransfer.transfer(lat, lng);
        WeatherRequest weatherRequest = WeatherRequest.of(serviceKey, date, grid.getX(), grid.getY());
        WeatherResponse weatherResponse = weatherClient.getWeather(weatherRequest);
        return weatherResponse.getResponse().getBody().getItems().getItem();
    }

    private boolean isWeatherItemBetween(ItemInfoDto weatherItem, LocalTime startTime, LocalTime endTime) {
        int fcstHour = weatherItem.getFcstHour();
        return startTime.getHour() <= fcstHour && fcstHour <= endTime.getHour();
    }
}
