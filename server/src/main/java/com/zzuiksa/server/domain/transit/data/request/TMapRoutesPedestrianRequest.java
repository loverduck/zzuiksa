package com.zzuiksa.server.domain.transit.data.request;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TMapRoutesPedestrianRequest {

    @NotNull
    private Float startX;

    @NotNull
    private Float startY;

    @NotNull
    private Float endX;

    @NotNull
    private Float endY;

    @NotNull
    private String startName;

    @NotNull
    private String endName;

    public static TMapRoutesPedestrianRequest of(float startLat, float startLng, float endLat, float endLng) {
        return TMapRoutesPedestrianRequest.builder()
                .startX(startLat)
                .startY(startLng)
                .endX(endLat)
                .endY(endLng)
                .startName("start")
                .endName("end")
                .build();
    }
}
