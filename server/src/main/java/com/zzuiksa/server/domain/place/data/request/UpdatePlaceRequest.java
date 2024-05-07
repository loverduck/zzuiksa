package com.zzuiksa.server.domain.place.data.request;

import com.zzuiksa.server.domain.place.entity.Place;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@EqualsAndHashCode
public class UpdatePlaceRequest {

    @NotBlank
    @Min(1)
    @Max(100)
    private String name;

    @NotNull
    private Float lat;

    @NotNull
    private Float lng;

    public Place update(Place place) {
        place.setName(name);
        place.setLatLng(lat, lng);
        return place;
    }
}
