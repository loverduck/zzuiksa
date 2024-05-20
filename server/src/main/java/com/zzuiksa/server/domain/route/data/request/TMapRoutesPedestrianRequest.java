package com.zzuiksa.server.domain.route.data.request;

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
    private Double startX;

    @NotNull
    private Double startY;

    @NotNull
    private Double endX;

    @NotNull
    private Double endY;

    @NotNull
    private String startName;

    @NotNull
    private String endName;

    public static TMapRoutesPedestrianRequest of(double startLat, double startLng, double endLat, double endLng) {
        return TMapRoutesPedestrianRequest.builder()
                .startX(startLng)
                .startY(startLat)
                .endX(endLng)
                .endY(endLat)
                .startName("start")
                .endName("end")
                .build();
    }
}
