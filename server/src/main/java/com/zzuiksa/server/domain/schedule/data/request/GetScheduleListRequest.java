package com.zzuiksa.server.domain.schedule.data.request;

import java.time.LocalDate;

import io.swagger.v3.oas.annotations.media.Schema;
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
public class GetScheduleListRequest {

    @Schema(description = "시작일")
    @NotNull
    private LocalDate from;

    @Schema(description = "종료일")
    @NotNull
    private LocalDate to;

    @Schema(description = "카테고리 ID")
    private Long categoryId;
}
