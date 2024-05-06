package com.zzuiksa.server.domain.schedule.data.request;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;

import org.springframework.boot.convert.DurationUnit;

import com.zzuiksa.server.domain.schedule.data.PlaceDto;
import com.zzuiksa.server.domain.schedule.data.RepeatDto;

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

    @NotNull
    private Long categoryId;

    @NotBlank
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

    public boolean isRepeat() {
        return repeat != null;
    }
}
