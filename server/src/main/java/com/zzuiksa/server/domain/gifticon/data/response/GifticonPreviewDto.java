package com.zzuiksa.server.domain.gifticon.data.response;

import java.time.LocalDate;

import com.querydsl.core.annotations.QueryProjection;
import com.zzuiksa.server.domain.gifticon.constant.IsUsed;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

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
    public GifticonPreviewDto(Long gifticonId, String url, String name, String store, LocalDate endDate, IsUsed isUsed, Integer remainMoney) {
        this.gifticonId = gifticonId;
        this.url = url;
        this.name = name;
        this.store = store;
        this.endDate = endDate;
        this.isUsed = isUsed;
        this.remainMoney = remainMoney;
    }

}



