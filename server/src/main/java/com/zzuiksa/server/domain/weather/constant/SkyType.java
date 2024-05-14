package com.zzuiksa.server.domain.weather.constant;

import java.util.Arrays;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public enum SkyType {
    CLEAR(1),
    PARTLY_CLOUDY(3),
    CLOUDY(4),
    ;

    private final int value;

    public static SkyType ofValue(int value) {
        return Arrays.stream(SkyType.values())
                .filter(type -> type.value == value)
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException(String.valueOf(value)));
    }
}
