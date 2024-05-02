package com.zzuiksa.server.domain.schedule;

import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.schedule.constant.RoutineCycle;
import com.zzuiksa.server.domain.schedule.data.PlaceDto;
import com.zzuiksa.server.domain.schedule.data.RepeatDto;
import com.zzuiksa.server.domain.schedule.data.request.AddScheduleRequest;
import com.zzuiksa.server.domain.schedule.data.response.GetScheduleResponse;
import com.zzuiksa.server.domain.schedule.entity.Category;
import com.zzuiksa.server.domain.schedule.entity.Routine;
import com.zzuiksa.server.domain.schedule.entity.Schedule;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;

public class ScheduleSource {

    public static final Long id = 3L;
    public static final Member member = null;
    public static final Category category = null;
    public static final Routine routine = null;
    public static final String title = "Title";
    public static final LocalDate startDate = LocalDate.of(2024, 4, 15);
    public static final LocalDate endDate = LocalDate.of(2024, 4, 19);
    public static final LocalTime startTime = LocalTime.of(8, 50, 30);
    public static final LocalTime endTime = LocalTime.of(15, 59, 40);
    public static final Duration alertBefore = Duration.ofMinutes(10);
    public static final String memo = "memo";
    public static final String toPlaceName = "To place";
    public static final Float toPlaceLat = 123.4f;
    public static final Float toPlaceLng = 34.5f;
    public static final String fromPlaceName = "From place";
    public static final Float fromPlaceLat = 132.4f;
    public static final Float fromPlaceLng = 43.5f;
    public static final Boolean isDone = false;
    public static final RoutineCycle repeatCycle = RoutineCycle.WEEKLY;
    public static final LocalDate repeatStartDate = startDate;
    public static final LocalDate repeatEndDate = LocalDate.of(2024, 4, 25);
    public static final Integer repeatTerm = 1;
    public static final Integer repeatAt = 0b1110;

    public static Schedule.ScheduleBuilder getTestScheduleBuilder() {
        return Schedule.builder()
            .id(id)
            .member(member)
            .category(category)
            .routine(routine)
            .title(title)
            .startDate(startDate)
            .endDate(endDate)
            .startTime(startTime)
            .endTime(endTime)
            .alertBefore(alertBefore)
            .memo(memo)
            .toPlaceName(toPlaceName)
            .toPlaceLat(toPlaceLat)
            .toPlaceLng(toPlaceLng)
            .fromPlaceName(fromPlaceName)
            .fromPlaceLat(fromPlaceLat)
            .fromPlaceLng(fromPlaceLng)
            .isDone(isDone);
    }

    public static Routine.RoutineBuilder getTestRoutineBuilder() {
        return Routine.builder()
            .id(id)
            .member(member)
            .category(category)
            .title(title)
            .startDate(startDate)
            .endDate(endDate)
            .startTime(startTime)
            .endTime(endTime)
            .alertBefore(alertBefore)
            .memo(memo)
            .toPlaceName(toPlaceName)
            .toPlaceLat(toPlaceLat)
            .toPlaceLng(toPlaceLng)
            .fromPlaceName(fromPlaceName)
            .fromPlaceLat(fromPlaceLat)
            .fromPlaceLng(fromPlaceLng)
            .repeatCycle(repeatCycle)
            .repeatStartDate(repeatStartDate)
            .repeatEndDate(repeatEndDate)
            .repeatTerm(repeatTerm)
            .repeatAt(repeatAt);
    }

    public static AddScheduleRequest.AddScheduleRequestBuilder getTestAddScheduleRequestBuilder() {
        return AddScheduleRequest.builder()
            .categoryId(null)
            .title(title)
            .startDate(startDate)
            .endDate(endDate)
            .startTime(startTime)
            .endTime(endTime)
            .alertBefore(alertBefore)
            .memo(memo)
            .toPlace(getTestToPlaceDto())
            .fromPlace(getTestFromPlaceDto());
    }

    public static GetScheduleResponse.GetScheduleResponseBuilder getTestGetScheduleResponseBuilder() {
        return GetScheduleResponse.builder()
            .categoryId(null)
            .title(title)
            .startDate(startDate)
            .endDate(endDate)
            .startTime(startTime)
            .endTime(endTime)
            .alertBefore(alertBefore)
            .memo(memo)
            .toPlace(getTestToPlaceDto())
            .fromPlace(getTestFromPlaceDto())
            .isDone(isDone);
    }

    public static PlaceDto getTestToPlaceDto() {
        return PlaceDto.of(toPlaceName, toPlaceLat, toPlaceLng);
    }

    public static PlaceDto getTestFromPlaceDto() {
        return PlaceDto.of(fromPlaceName, fromPlaceLat, fromPlaceLng);
    }

    public static RepeatDto getTestRepeatDto() {
        return RepeatDto.of(repeatCycle, repeatEndDate, repeatTerm, repeatAt);
    }
}
