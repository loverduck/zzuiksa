package com.zzuiksa.server.domain.gifticon.data.response;

import com.zzuiksa.server.domain.gifticon.constant.IsUsed;
import com.zzuiksa.server.domain.gifticon.entity.Gifticon;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.Id;
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
public class AddGifticonResponse {

    @Schema(description = "기프티콘 ID")
    @NotNull
    private Long gifticonId;

    public static AddGifticonResponse from(Long gifticonId) {
        return new AddGifticonResponse(gifticonId);
    }
}
