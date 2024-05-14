package com.zzuiksa.server.domain.weather.constant;

import java.util.Arrays;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
public enum PrecipitationType {
    NONE(0, false, false),
    RAIN(1, true, false),
    RAIN_AND_SNOW(2, true, true),
    SNOW(3, false, true),
    SHOWER(4, true, false),
    ;

    private final int value;

    @Getter
    private final boolean rain;

    @Getter
    private final boolean snow;

    public static PrecipitationType ofValue(int value) {
        return Arrays.stream(PrecipitationType.values())
                .filter(type -> type.value == value)
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException(String.valueOf(value)));
    }
}
