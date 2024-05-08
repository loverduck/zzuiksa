package com.zzuiksa.server.domain.gifticon.data.response;

import com.querydsl.core.annotations.QueryProjection;
import com.zzuiksa.server.domain.gifticon.constant.IsUsed;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDate;

@Getter
@NoArgsConstructor
@Builder
@ToString
@EqualsAndHashCode
public class GifticonPreviewDto {

    @NotNull
    private Long gifticonId;

    @NotBlank
    private String url;

    @NotBlank
    private String name;

    private String store;

    @NotNull
    private LocalDate endDate;

    @NotNull
    private IsUsed isUsed;

    @QueryProjection
    public GifticonPreviewDto(Long gifticonId, String name, String store, String url, LocalDate endDate, IsUsed isUsed) {
        this.gifticonId = gifticonId;
        this.name = name;
        this.store = store;
        this.url = url;
        this.endDate = endDate;
        this.isUsed = isUsed;
    }

    // public static GifticonPreviewDto of (Long gifticonId, String name, String store, String url, LocalDate endDate, IsUsed isUsed) {
    //     return new GifticonPreviewDto(gifticonId, name, store, url, endDate, isUsed);
    // }
}



