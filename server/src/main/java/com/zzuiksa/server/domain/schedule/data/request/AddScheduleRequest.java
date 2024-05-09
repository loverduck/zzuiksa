package com.zzuiksa.server.domain.schedule.data.request;

import java.time.LocalDate;
import java.time.LocalTime;

import com.zzuiksa.server.domain.schedule.data.PlaceDto;
import com.zzuiksa.server.domain.schedule.data.RepeatDto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
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
public class AddScheduleRequest {

    @Schema(description = "카테고리 ID")
    @NotNull
    private Long categoryId;

    @Schema(description = "일정 제목")
    @NotBlank
    private String title;

    @Schema(description = "일정 시작일")
    @NotNull
    private LocalDate startDate;

    @Schema(description = "일정 종료일")
    @NotNull
    private LocalDate endDate;

    @Schema(description = "일정 시작시간")
    private LocalTime startTime;

    @Schema(description = "일정 종료시간")
    private LocalTime endTime;

    @Schema(description = "알림 시간")
    private Integer alertBefore;

    @Schema(description = "메모")
    @NotNull
    private String memo;

    @Schema(description = "목적지")
    private PlaceDto toPlace;

    @Schema(description = "출발지")
    private PlaceDto fromPlace;

    @Schema(description = "반복")
    private RepeatDto repeat;

    public PlaceDto getToPlace() {
        return toPlace == null ? PlaceDto.EMPTY : toPlace;
    }

    public PlaceDto getFromPlace() {
        return fromPlace == null ? PlaceDto.EMPTY : fromPlace;
    }

    public boolean isRepeat() {
        return repeat != null;
    }
}
