package com.zzuiksa.server.domain.place.data;

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
public class MemberPlaceDto {

    @NotNull
    private Long placeId;

    @NotBlank
    private String name;

    @NotNull
    private Double lat;

    @NotNull
    private Double lng;

    public static MemberPlaceDto from(Place place) {
        return MemberPlaceDto.builder()
                .placeId(place.getId())
                .name(place.getName())
                .lat(place.getLat())
                .lng(place.getLng())
                .build();
    }
}
