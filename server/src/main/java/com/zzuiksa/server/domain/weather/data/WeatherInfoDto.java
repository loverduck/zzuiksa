package com.zzuiksa.server.domain.weather.data;

import com.zzuiksa.server.domain.weather.constant.WeatherType;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class WeatherInfoDto {

    @Schema(description = "강수 확률, (0 ~ 100)")
    private Integer maxPop;

    @Schema(description = "최저 기온")
    private Integer minTmp;

    @Schema(description = "최고 기온")
    private Integer maxTmp;

    @Schema(description = "날씨 상태")
    private WeatherType weatherType;
}
