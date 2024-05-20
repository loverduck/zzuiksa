package com.zzuiksa.server.domain.gifticon.data.response;

import com.zzuiksa.server.domain.gifticon.entity.Gifticon;

import io.swagger.v3.oas.annotations.media.Schema;
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
public class UpdateGifticonResponse {

    @Schema(description = "기프티콘 ID")
    @NotNull
    private Long gifticonId;

    public static UpdateGifticonResponse from(Gifticon gifticon) {
        return UpdateGifticonResponse.builder()
                .gifticonId(gifticon.getId())
                .build();
    }
}
