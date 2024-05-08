package com.zzuiksa.server.domain.gifticon.data.request;

import com.zzuiksa.server.domain.gifticon.constant.IsUsed;

import com.zzuiksa.server.domain.gifticon.entity.Gifticon;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
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
public class UpdateGifticonRequest {

    @NotBlank
    @Min(1)
    @Max(100)
    private String name;

    @NotBlank
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

    public Gifticon update(Gifticon gifticon) {
        gifticon.setName(name);
        return gifticon;
    }
}
