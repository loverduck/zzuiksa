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
public class TMapRoutesRequest {

    @NotNull
    private Double startX;

    @NotNull
    private Double startY;

    @NotNull
    private Double endX;

    @NotNull
    private Double endY;

    private Integer totalValue;

    public static TMapRoutesRequest of(double startLat, double startLng, double endLat, double endLng) {
        return TMapRoutesRequest.builder()
                .startX(startLng)
                .startY(startLat)
                .endX(endLng)
                .endY(endLat)
                .totalValue(2)
                .build();
    }
}
