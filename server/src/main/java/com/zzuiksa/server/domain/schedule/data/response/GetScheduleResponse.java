package com.zzuiksa.server.domain.schedule.data.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.zzuiksa.server.domain.schedule.data.PlaceDto;
import com.zzuiksa.server.domain.schedule.data.RepeatDto;
import com.zzuiksa.server.domain.schedule.entity.Schedule;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.springframework.boot.convert.DurationUnit;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@EqualsAndHashCode
@JsonInclude(JsonInclude.Include.NON_NULL)
public class GetScheduleResponse {

    private Long categoryId;

    @NotNull
    private String title;

    @NotNull
    private LocalDate startDate;

    @NotNull
    private LocalDate endDate;

    private LocalTime startTime;

    private LocalTime endTime;

    @DurationUnit(ChronoUnit.MINUTES)
    private Duration alertBefore;

    @NotNull
    private String memo;

    private PlaceDto toPlace;

    private PlaceDto fromPlace;

    private RepeatDto repeat;

    private Boolean isDone;

    public static GetScheduleResponse of(Schedule schedule) {
        return GetScheduleResponse.builder()
            .categoryId(schedule.getCategory().getId())
            .title(schedule.getTitle())
            .startDate(schedule.getStartDate())
            .endDate(schedule.getEndDate())
            .startTime(schedule.getStartTime())
            .endTime(schedule.getEndTime())
            .alertBefore(schedule.getAlertBefore())
            .memo(schedule.getMemo())
            .toPlace(getToPlace(schedule))
            .fromPlace(getFromPlace(schedule))
            .repeat(getRepeat(schedule))
            .isDone(schedule.isDone())
            .build();
    }

    private static PlaceDto getToPlace(Schedule schedule) {
        if (schedule.getToPlaceName() == null) {
            return null;
        }
        return PlaceDto.of(schedule.getToPlaceName(), schedule.getToPlaceLat(), schedule.getToPlaceLng());
    }

    private static PlaceDto getFromPlace(Schedule schedule) {
        if (schedule.getFromPlaceName() == null) {
            return null;
        }
        return PlaceDto.of(schedule.getFromPlaceName(), schedule.getFromPlaceLat(), schedule.getFromPlaceLng());
    }

    private static RepeatDto getRepeat(Schedule schedule) {
        if (schedule.getRoutine() == null) {
            return null;
        }
        return RepeatDto.of(schedule.getRoutine().getRepeatCycle(), schedule.getRoutine().getRepeatEndDate(), schedule.getRoutine().getRepeatTerm(), schedule.getRoutine().getRepeatAt());
    }
}
