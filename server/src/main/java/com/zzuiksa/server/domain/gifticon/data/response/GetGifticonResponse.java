package com.zzuiksa.server.domain.gifticon.data.response;

import com.zzuiksa.server.domain.gifticon.constant.IsUsed;

import com.zzuiksa.server.domain.gifticon.entity.Gifticon;
import com.zzuiksa.server.domain.place.data.response.GetPlaceResponse;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDate;
import java.util.OptionalInt;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@EqualsAndHashCode
public class GetGifticonResponse {

    @NotNull
    private Long gifticonId;

    @NotBlank
    private String url;

    @NotBlank
    private String name;

    private String store;

    @NotBlank
    private String couponNum;

    @NotNull
    private LocalDate endDate;

    @NotNull
    private IsUsed isUsed;

    private OptionalInt remainMoney;

    private String memo;

    public static GetGifticonResponse from(Gifticon gifticon) {
        GetGifticonResponseBuilder builder = GetGifticonResponse.builder()
                .gifticonId(gifticon.getId())
                .name(gifticon.getName())
                .url(gifticon.getUrl())
                .couponNum(gifticon.getCouponNum())
                .endDate(gifticon.getEndDate())
                .isUsed(gifticon.getIsUsed());
        if (gifticon.getStore() != null) {
            builder.store(gifticon.getStore());
        }
        // builder.remainMoney(OptionalInt.of(gifticon.getRemainMoney()));
        // if (gifticon.getRemainMoney() != null) { // remainMoney가 null이 아닐 때만 값 설정
        //     builder.remainMoney(OptionalInt.of(gifticon.getRemainMoney()));
        // }
        builder.remainMoney(OptionalInt.of(gifticon.getRemainMoney()));
        if (gifticon.getMemo() != null) {
            builder.memo(gifticon.getMemo());
        }

        return builder.build();
    }
}
