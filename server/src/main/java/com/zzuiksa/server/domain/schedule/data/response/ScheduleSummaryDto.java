package com.zzuiksa.server.domain.schedule.data.response;

import java.time.LocalDate;
import java.time.LocalTime;

import com.querydsl.core.annotations.QueryProjection;
import com.zzuiksa.server.domain.schedule.data.PlaceDto;

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

    @NotNull
    private Long scheduleId;

    private Long categoryId;

    @NotBlank
    private String title;

    @NotNull
    private LocalDate startDate;

    @NotNull
    private LocalDate endDate;

    private LocalTime startTime;

    private LocalTime endTime;

    private PlaceDto toPlace;

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
