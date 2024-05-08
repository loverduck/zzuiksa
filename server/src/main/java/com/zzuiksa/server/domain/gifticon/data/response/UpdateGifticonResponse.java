package com.zzuiksa.server.domain.gifticon.data.response;

import com.zzuiksa.server.domain.gifticon.constant.IsUsed;

import com.zzuiksa.server.domain.gifticon.entity.Gifticon;
import com.zzuiksa.server.domain.place.data.response.UpdatePlaceResponse;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.LocalDate;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@EqualsAndHashCode
public class UpdateGifticonResponse {

    @NotNull
    private Long gifticonId;

    public static UpdateGifticonResponse from(Gifticon gifticon) {
        return UpdateGifticonResponse.builder()
                .gifticonId(gifticon.getId())
                .build();
    }
}
