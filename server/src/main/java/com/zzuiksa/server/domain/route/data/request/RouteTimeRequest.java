package com.zzuiksa.server.domain.route.data.request;

import java.time.LocalDateTime;

import com.zzuiksa.server.domain.route.constant.TransportType;
import com.zzuiksa.server.domain.route.data.LatLngDto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class RouteTimeRequest {

    @Schema(description = "교통 수단")
    @NotNull
    private TransportType type;

    @Schema(description = "출발지 좌표")
    @NotNull
    private LatLngDto from;

    @Schema(description = "도착지 좌표")
    @NotNull
    private LatLngDto to;

    @Schema(description = "약속 시간 (도착 시간, \"yyyy-MM-ddThh:mm:ss\")")
    @NotNull
    private LocalDateTime time;
}
