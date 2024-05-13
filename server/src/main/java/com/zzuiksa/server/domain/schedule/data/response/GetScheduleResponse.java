package com.zzuiksa.server.domain.schedule.data.response;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;

import io.swagger.v3.oas.annotations.media.Schema;

import org.springframework.boot.convert.DurationUnit;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.zzuiksa.server.domain.schedule.data.PlaceDto;
import com.zzuiksa.server.domain.schedule.data.RepeatDto;
import com.zzuiksa.server.domain.schedule.entity.Schedule;

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
@JsonInclude(JsonInclude.Include.NON_NULL)
public class GetScheduleResponse {

    @Schema(description = "카테고리 ID")
    private Long categoryId;

    @Schema(description = "일정 제목")
    @NotNull
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

    @Schema(description = "알림 시간 (분)")
    private Long alertBefore;

    @Schema(description = "메모")
    @NotNull
    private String memo;

    @Schema(description = "도착지")
    private PlaceDto toPlace;

    @Schema(description = "출발지")
    private PlaceDto fromPlace;

    @Schema(description = "반복")
    private RepeatDto repeat;

    @Schema(description = "완료 여부")
    private Boolean isDone;

    public static GetScheduleResponse from(Schedule schedule) {
        return GetScheduleResponse.builder()
                .categoryId(schedule.getCategory().getId())
                .title(schedule.getTitle())
                .startDate(schedule.getStartDate())
                .endDate(schedule.getEndDate())
                .startTime(schedule.getStartTime())
                .endTime(schedule.getEndTime())
                .alertBefore(getAlertBeforeMinutes(schedule))
                .memo(schedule.getMemo())
                .toPlace(getToPlace(schedule))
                .fromPlace(getFromPlace(schedule))
                .repeat(getRepeat(schedule))
                .isDone(schedule.isDone())
                .build();
    }

    private static Long getAlertBeforeMinutes(Schedule schedule) {
        if (schedule.getAlertBefore() == null) {
            return null;
        }
        return schedule.getAlertBefore().toMinutes();
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
        return RepeatDto.of(schedule.getRoutine().getRepeatCycle(), schedule.getRoutine().getRepeatEndDate(),
                schedule.getRoutine().getRepeatAt());
    }
}
