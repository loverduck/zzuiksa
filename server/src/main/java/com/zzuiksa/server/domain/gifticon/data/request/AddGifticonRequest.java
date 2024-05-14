package com.zzuiksa.server.domain.gifticon.data.request;

import java.time.LocalDate;

import com.zzuiksa.server.domain.gifticon.constant.IsUsed;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
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
public class AddGifticonRequest {

    @Schema(description = "이미지주소")
    @NotBlank
    private String url;

    @Schema(description = "상품명")
    @Size(max = 100)
    private String name;

    @Schema(description = "브랜드명")
    private String store;

    @Schema(description = "바코드")
    @NotBlank
    private String couponNum;

    @Schema(description = "유효기한")
    private LocalDate endDate;

    @Schema(description = "사용 상태")
    @NotNull
    private IsUsed isUsed;

    @Schema(description = "금액")
    private Integer remainMoney;

    @Schema(description = "메모")
    private String memo;
}
