package com.zzuiksa.server.domain.gifticon.data.request;

import com.zzuiksa.server.domain.gifticon.constant.IsUsed;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDate;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@EqualsAndHashCode
public class AddGifticonRequest {

    @NotBlank
    @Min(1)
    @Max(100)
    private String name;

    @NotNull
    private String url;

    private String store;

    @NotBlank
    private String couponNum;

    @NotNull
    private LocalDate endDate;

    @NotNull
    private IsUsed isUsed;

    private int remainMoney;

    private String memo;
}
