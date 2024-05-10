package com.zzuiksa.server.domain.weather.data;

import lombok.Getter;

@Getter
public class ItemInfoDto {

    private String baseDate;
    private String baseTime;
    private String category;
    private String fcstDate;
    private String fcstTime;
    private String fcstValue;
    private Integer nx;
    private Integer ny;

    public int getFcstHour() {
        return Integer.parseInt(fcstTime) / 100;
    }

    public int getFcstValueAsInt() {
        return Integer.parseInt(fcstValue);
    }
}
