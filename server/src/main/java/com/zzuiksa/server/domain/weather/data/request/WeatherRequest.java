package com.zzuiksa.server.domain.weather.data.request;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

public class WeatherRequest {

    private String serviceKey;

    private Integer pageNo;

    private Integer numOfRows;

    private String dataType;

    private String baseDate;

    private Integer baseTime;

    private Integer nx;

    private Integer ny;

    public static Map<String, Object> of(String serviceKey, LocalDate date, int nx, int ny) {
        LocalDate dayBefore = date.minusDays(1);
        String baseDate = dayBefore.format(DateTimeFormatter.ofPattern("yyyyMMdd"));

        Map<String, Object> query = new HashMap<>();
        query.put("serviceKey", serviceKey);
        query.put("pageNo", 1);
        query.put("numOfRows", 290);
        query.put("dataType", "JSON");
        query.put("base_date", baseDate);
        query.put("base_time", 2300);
        query.put("nx", nx);
        query.put("ny", ny);

        return query;
    }
}
