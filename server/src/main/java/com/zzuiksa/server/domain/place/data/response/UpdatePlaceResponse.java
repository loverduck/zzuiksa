package com.zzuiksa.server.domain.place.data.response;

import com.zzuiksa.server.domain.place.entity.Place;

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
public class UpdatePlaceResponse {

    @NotNull
    private Long placeId;

    public static UpdatePlaceResponse from(Place place) {
        return UpdatePlaceResponse.builder()
                .placeId(place.getId())
                .build();
    }
}
