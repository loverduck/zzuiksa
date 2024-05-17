package com.zzuiksa.server.domain.route.data;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class LatLngDto {

    @NotNull
    private Double lat;

    @NotNull
    private Double lng;

    public static LatLngDto of(Double lat, Double lng) {
        if (lat == null || lng == null) {
            return null;
        }
        return new LatLngDto(lat, lng);
    }
}
