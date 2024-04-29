package com.zzuiksa.server.domain.schedule.data.request;

import com.zzuiksa.server.domain.schedule.data.PlaceDto;
import com.zzuiksa.server.domain.schedule.data.RepeatDto;
import jakarta.validation.constraints.NotBlank;
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
@ToString
@EqualsAndHashCode
public class AddScheduleRequest {

    @NotNull
    private Integer categoryId;

    @NotBlank
    private String title;

    @NotNull
    private LocalDate startDate;

    private LocalDate endDate;

    private LocalTime startTime;

    private LocalTime endTime;

    @DurationUnit(ChronoUnit.SECONDS)
    private Duration alertBefore;

    @NotNull
    private String memo;

    private PlaceDto toPlace;

    private PlaceDto fromPlace;

    private RepeatDto repeat;
}
