package com.zzuiksa.server.domain.schedule.data.response;

import java.time.LocalDate;
import java.time.LocalTime;

import com.querydsl.core.annotations.QueryProjection;
import com.zzuiksa.server.domain.schedule.data.PlaceDto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
@ToString
@EqualsAndHashCode
public class ScheduleSummaryDto {

    @Schema(description = "일정 ID")
    @NotNull
    private Long scheduleId;

    @Schema(description = "카테고리 ID")
    private Long categoryId;

    @Schema(description = "일정 제목")
    @NotBlank
    private String title;

    @Schema(description = "시작일")
    @NotNull
    private LocalDate startDate;

    @Schema(description = "종료일")
    @NotNull
    private LocalDate endDate;

    @Schema(description = "시작시간")
    private LocalTime startTime;

    @Schema(description = "종료시간")
    private LocalTime endTime;

    @Schema(description = "목적지")
    private PlaceDto toPlace;

    @Schema(description = "출발지")
    @NotNull
    private Boolean isDone;

    @QueryProjection
    public ScheduleSummaryDto(Long scheduleId, Long categoryId, String title, LocalDate startDate, LocalDate endDate,
            LocalTime startTime, LocalTime endTime, String toPlaceName, Float toPlaceLat, Float toPlaceLng,
            Boolean isDone) {
        this.scheduleId = scheduleId;
        this.categoryId = categoryId;
        this.title = title;
        this.startDate = startDate;
        this.endDate = endDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.toPlace = PlaceDto.of(toPlaceName, toPlaceLat, toPlaceLng);
        this.isDone = isDone;
    }
}
