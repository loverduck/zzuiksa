package com.zzuiksa.server.domain.place.data.response;

import com.zzuiksa.server.domain.place.entity.Place;

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
public class GetPlaceResponse {

    @NotNull
    private Long placeId;

    @NotBlank
    private String name;

    @NotNull
    private Float lat;

    @NotNull
    private Float lng;

    public static GetPlaceResponse from(Place place) {
        return GetPlaceResponse.builder()
                .placeId(place.getId())
                .name(place.getName())
                .lat(place.getLat())
                .lng(place.getLng())
                .build();
    }
}
