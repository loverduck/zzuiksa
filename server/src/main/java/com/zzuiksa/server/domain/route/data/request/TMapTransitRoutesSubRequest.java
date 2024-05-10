package com.zzuiksa.server.domain.route.data.request;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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
public class TMapTransitRoutesSubRequest {

    @NotNull
    private String startX;

    @NotNull
    private String startY;

    @NotNull
    private String endX;

    @NotNull
    private String endY;

    private String format;

    private Integer count;

    private String searchDttm;

    public static TMapTransitRoutesSubRequest of(float startLat, float startLng, float endLat, float endLng,
            LocalDateTime startDateTime, int count) {
        DateTimeFormatter searchDttmFormatter = DateTimeFormatter.ofPattern("yyyyMMddhhmm");
        return TMapTransitRoutesSubRequest.builder()
                .startX(String.valueOf(startLng))
                .startY(String.valueOf(startLat))
                .endX(String.valueOf(endLng))
                .endY(String.valueOf(endLat))
                .format("json")
                .searchDttm(startDateTime.format(searchDttmFormatter))
                .count(count)
                .build();
    }
}
