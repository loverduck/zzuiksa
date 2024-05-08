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

    @Schema(description = "장소명")
    @NotNull
    private String name;

    @Schema(description = "위도")
    private Float lat;

    @Schema(description = "경도")
    private Float lng;

    public static PlaceDto of(String name, Float lat, Float lng) {
        return new PlaceDto(name, lat, lng);
    }
}
