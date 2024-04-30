package com.zzuiksa.server.domain.schedule.data;

import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@EqualsAndHashCode
public class PlaceDto {

    @NotNull
    private String name;

    private Float lat;

    private Float lng;

    public static PlaceDto of(String name, Float lat, Float lng) {
        return new PlaceDto(name, lat, lng);
    }
}
