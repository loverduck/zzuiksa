package com.zzuiksa.server.domain.transit.data;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class LatLngDto {

    @NotNull
    private Float lat;

    @NotNull
    private Float lng;

    public static LatLngDto of(float lat, float lng) {
        return new LatLngDto(lat, lng);
    }
}
