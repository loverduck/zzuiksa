package com.zzuiksa.server.domain.schedule.data;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@EqualsAndHashCode
public class PlaceDto {

    public static final PlaceDto EMPTY = new PlaceDto();

    @Schema(description = "장소명")
    @NotNull
    private String name;

    @Schema(description = "위도")
    private Double lat;

    @Schema(description = "경도")
    private Double lng;

    public static PlaceDto of(String name, Double lat, Double lng) {
        return new PlaceDto(name, lat, lng);
    }
}
