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
    private Float startX;

    @NotNull
    private Float startY;

    @NotNull
    private Float endX;

    @NotNull
    private Float endY;

    private Integer totalValue;

    public static TMapRoutesRequest of(float startLat, float startLng, float endLat, float endLng) {
        return TMapRoutesRequest.builder()
                .startX(startLng)
                .startY(startLat)
                .endX(endLng)
                .endY(endLat)
                .totalValue(2)
                .build();
    }
}
