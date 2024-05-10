package com.zzuiksa.server.domain.weather.data;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;

@Builder
public class WeatherInfoDto {

    @Schema(description = "강수 확률, (0 ~ 100)")
    private Integer maxPop;

    @Schema(description = "최저 기온")
    private Integer minTmp;

    @Schema(description = "최고 기온")
    private Integer maxTmp;
}
