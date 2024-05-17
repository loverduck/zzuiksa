package com.zzuiksa.server.domain.gifticon.data.response;

import com.querydsl.core.annotations.QueryProjection;
import com.zzuiksa.server.domain.gifticon.constant.IsUsed;

import io.swagger.v3.oas.annotations.media.Schema;
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

    @Schema(description = "기프티콘 ID")
    @NotNull
    private Long gifticonId;

    @Schema(description = "이미지주소")
    @NotBlank
    private String url;

    @Schema(description = "상품명")
    private String name;

    @Schema(description = "브랜드명")
    private String store;

    @Schema(description = "유효기한")
    private LocalDate endDate;

    @Schema(description = "사용 상태")
    @NotNull
    private IsUsed isUsed;

    @Schema(description = "금액")
    private Integer remainMoney;

    @QueryProjection
    public GifticonPreviewDto(Long gifticonId, String name, String store, String url, LocalDate endDate, IsUsed isUsed, Integer remainMoney) {
        this.gifticonId = gifticonId;
        this.name = name;
        this.store = store;
        this.url = url;
        this.endDate = endDate;
        this.isUsed = isUsed;
        this.remainMoney = remainMoney;
    }

}



