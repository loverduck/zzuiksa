package com.zzuiksa.server.domain.gifticon.data.response;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AddGifticonResponse {

    @Schema(description = "기프티콘 ID")
    @NotNull
    private Long gifticonId;

    public static AddGifticonResponse from(Long gifticonId) {
        return new AddGifticonResponse(gifticonId);
    }
}
