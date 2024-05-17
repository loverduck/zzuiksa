package com.zzuiksa.server.domain.schedule.data.request;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;

import com.zzuiksa.server.domain.schedule.data.PlaceDto;
import com.zzuiksa.server.domain.schedule.entity.Schedule;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateScheduleRequest {

    @Size(min = 1, max = 100)
    private String title;

    private LocalDate startDate;

    private LocalDate endDate;

    private LocalTime startTime;

    private LocalTime endTime;

    private Long alertBefore;

    @Size(max = 1000)
    private String memo;

    private PlaceDto toPlace;

    private PlaceDto fromPlace;

    @NotNull
    private Boolean isDone;

    public Schedule update(Schedule schedule) {
        schedule.setTitle(title);
        schedule.setStartDate(startDate);
        schedule.setEndDate(endDate);
        if (startTime != null && endTime != null) {
            schedule.setTime(startTime, endTime);
        } else {
            schedule.setAllDay();
        }
        if (alertBefore != null && alertBefore > 0) {
            schedule.setAlertBefore(Duration.ofMinutes(alertBefore));
        } else {
            schedule.removeAlert();
        }
        schedule.setMemo(memo);
        if (toPlace != null) {
            if (toPlace.getLat() != null && toPlace.getLng() != null) {
                schedule.setToPlace(toPlace.getName(), toPlace.getLat(), toPlace.getLng());
            } else {
                schedule.setToPlace(toPlace.getName());
            }
        } else {
            schedule.removeToPlace();
        }
        if (fromPlace != null) {
            if (fromPlace.getLat() != null && fromPlace.getLng() != null) {
                schedule.setFromPlace(fromPlace.getName(), fromPlace.getLat(), fromPlace.getLng());
            } else {
                schedule.setFromPlace(fromPlace.getName());
            }
        } else {
            schedule.removeFromPlace();
        }
        schedule.setDone(isDone);
        return schedule;
    }
}
