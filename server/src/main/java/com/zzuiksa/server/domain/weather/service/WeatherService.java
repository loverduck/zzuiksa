package com.zzuiksa.server.domain.weather.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.zzuiksa.server.domain.weather.client.WeatherClient;
import com.zzuiksa.server.domain.weather.constant.PrecipitationType;
import com.zzuiksa.server.domain.weather.constant.SkyType;
import com.zzuiksa.server.domain.weather.constant.WeatherType;
import com.zzuiksa.server.domain.weather.data.GpsTransfer;
import com.zzuiksa.server.domain.weather.data.GridDto;
import com.zzuiksa.server.domain.weather.data.ItemInfoDto;
import com.zzuiksa.server.domain.weather.data.WeatherInfoDto;
import com.zzuiksa.server.domain.weather.data.request.WeatherRequest;
import com.zzuiksa.server.domain.weather.data.response.WeatherResponse;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class WeatherService {

    private final WeatherClient weatherClient;

    @Value("${api.weather.key}")
    private String serviceKey;

    public WeatherInfoDto getWeatherOfTime(LocalDate date, double lat, double lng, LocalTime startTime,
            LocalTime endTime) {
        List<ItemInfoDto> weatherItems = getWeatherItems(date, lat, lng).stream()
                .filter(weatherItem -> isWeatherItemBetween(weatherItem, startTime, endTime))
                .toList();

        WeatherInfo info = new WeatherInfo();
        for (ItemInfoDto weatherItem : weatherItems) {
            switch (weatherItem.getCategory()) {
                case "POP" -> info.addPop(weatherItem.getFcstValueAsInt());
                case "TMP" -> info.addTemp(weatherItem.getFcstValueAsInt());
                case "SKY" -> info.addSky(weatherItem.getFcstValueAsInt());
                case "PTY" -> info.addPrecipitation(weatherItem.getFcstValueAsInt());
            }
        }

        return WeatherInfoDto.builder()
                .maxPop(info.getMaxPop())
                .minTmp(info.getMinTemp())
                .maxTmp(info.getMaxTemp())
                .weatherType(info.getWeatherType())
                .build();
    }

    private List<ItemInfoDto> getWeatherItems(LocalDate date, double lat, double lng) {
        GridDto grid = GpsTransfer.transfer(lat, lng);
        WeatherRequest weatherRequest = WeatherRequest.of(serviceKey, date, grid.getX(), grid.getY());
        Map<String, Object> weatherRequestQuery = convertWeatherRequestToMap(weatherRequest);
        WeatherResponse weatherResponse = weatherClient.getWeather(weatherRequestQuery);
        return weatherResponse.getResponse().getBody().getItems().getItem();
    }

    private boolean isWeatherItemBetween(ItemInfoDto weatherItem, LocalTime startTime, LocalTime endTime) {
        int fcstHour = weatherItem.getFcstHour();
        return startTime.getHour() <= fcstHour && fcstHour <= endTime.getHour();
    }

    private Map<String, Object> convertWeatherRequestToMap(WeatherRequest weatherRequest) {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.convertValue(weatherRequest, new TypeReference<>() {
        });
    }

    static class WeatherInfo {
        private final List<Integer> pops = new ArrayList<>();
        private final List<Integer> temps = new ArrayList<>();
        private final List<SkyType> skys = new ArrayList<>();
        private final List<PrecipitationType> precipitations = new ArrayList<>();

        public void addPop(int pop) {
            pops.add(pop);
        }

        public void addTemp(int temp) {
            temps.add(temp);
        }

        public void addSky(int sky) {
            skys.add(SkyType.ofValue(sky));
        }

        public void addPrecipitation(int precipitation) {
            precipitations.add(PrecipitationType.ofValue(precipitation));
        }

        public Integer getMaxPop() {
            return pops.stream().max(Integer::compare).orElse(null);
        }

        public Integer getMinTemp() {
            return temps.stream().min(Integer::compare).orElse(null);
        }

        public Integer getMaxTemp() {
            return temps.stream().max(Integer::compare).orElse(null);
        }

        public WeatherType getWeatherType() {
            PrecipitationType precipitation = getPrecipitationType();
            return switch (precipitation) {
                case NONE -> getWeatherTypeBySkyType();
                case RAIN -> WeatherType.RAIN;
                case SNOW -> WeatherType.SNOW;
                case RAIN_AND_SNOW -> WeatherType.RAIN_AND_SNOW;
                default -> throw new IllegalStateException();
            };
        }

        public WeatherType getWeatherTypeBySkyType() {
            SkyType sky = getSkyType();
            return switch (sky) {
                case CLEAR -> WeatherType.CLEAR;
                case PARTLY_CLOUDY, CLOUDY -> WeatherType.CLOUDY;
            };
        }

        private SkyType getSkyType() {
            Map<SkyType, Integer> counts = new HashMap<>();
            counts.put(SkyType.CLEAR, 0);
            counts.put(SkyType.PARTLY_CLOUDY, 0);
            counts.put(SkyType.CLOUDY, 0);
            for (SkyType sky : skys) {
                counts.put(sky, counts.get(sky) + 1);
            }
            int clearCount = counts.get(SkyType.CLEAR);
            int cloudyCount = counts.get(SkyType.PARTLY_CLOUDY) + counts.get(SkyType.CLOUDY);
            if (clearCount >= cloudyCount) {
                return SkyType.CLEAR;
            } else {
                return SkyType.CLOUDY;
            }
        }

        private PrecipitationType getPrecipitationType() {
            boolean rain = false;
            boolean snow = false;
            for (PrecipitationType precipitation : precipitations) {
                rain |= precipitation.isRain();
                snow |= precipitation.isSnow();
            }
            return getPrecipitationTypeOfRainSnow(rain, snow);
        }

        private static PrecipitationType getPrecipitationTypeOfRainSnow(boolean rain, boolean snow) {
            if (rain && snow) {
                return PrecipitationType.RAIN_AND_SNOW;
            } else if (rain) {
                return PrecipitationType.RAIN;
            } else if (snow) {
                return PrecipitationType.SNOW;
            } else {
                return PrecipitationType.NONE;
            }
        }
    }
}
