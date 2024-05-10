package com.zzuiksa.server.domain.weather.data.request;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import feign.form.FormProperty;
import lombok.Builder;

@Builder
public class WeatherRequest {

    private String serviceKey;

    private Integer pageNo;

    private Integer numOfRows;

    @FormProperty("dataType")
    private String dataType;

    @FormProperty("base_date")
    private String baseDate;

    @FormProperty("base_time")
    private Integer baseTime;

    private Integer nx;

    private Integer ny;

    public static WeatherRequest of(String serviceKey, LocalDate date, int nx, int ny) {
        LocalDate dayBefore = date.minusDays(1);
        String baseDate = dayBefore.format(DateTimeFormatter.ofPattern("yyyyMMdd"));

        return WeatherRequest.builder()
                .serviceKey(serviceKey)
                .pageNo(1)
                .numOfRows(290)
                .dataType("JSON")
                .baseDate(baseDate)
                .baseTime(2300)
                .nx(nx)
                .ny(ny)
                .build();
    }
}
