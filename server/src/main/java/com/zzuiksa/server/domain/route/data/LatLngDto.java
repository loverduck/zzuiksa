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

    public static LatLngDto of(double lat, double lng) {
        return new LatLngDto(lat, lng);
    }
}
