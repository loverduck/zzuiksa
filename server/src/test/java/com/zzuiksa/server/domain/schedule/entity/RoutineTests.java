package com.zzuiksa.server.domain.schedule.entity;

import static org.assertj.core.api.Assertions.*;

import java.time.DayOfWeek;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.NullAndEmptySource;
import org.junit.jupiter.params.provider.ValueSource;

import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.schedule.ScheduleSource;
import com.zzuiksa.server.domain.schedule.constant.RoutineCycle;

public class RoutineTests {

    Schedule.ScheduleBuilder scheduleBuilder;
    Routine.RoutineBuilder routineBuilder;
    Member member;

    @BeforeEach
    public void setUp() {
        scheduleBuilder = ScheduleSource.getTestScheduleBuilder();
        routineBuilder = ScheduleSource.getTestRoutineBuilder();
        member = new Member();
    }

    @Test
    public void setTitle__success() {
        // given
        String title = "저녁 먹기";
        Routine routine = new Routine();

        // when
        routine.setTitle(title);

        // then
        assertThat(routine.getTitle()).isEqualTo(title);
    }

    @Test
    public void setTitle_null_throwIllegalArgumentException() {
        // given
        String title = null;
        Routine routine = new Routine();

        // when & then
        assertThatThrownBy(() -> routine.setTitle(title)).isInstanceOf(IllegalArgumentException.class);
    }

    @ParameterizedTest
    @ValueSource(strings = {"", " ", "   ", "\n", "\t", "\t \n   \n"})
    public void setTitle_empty_throwIllegalArgumentException(String title) {
        // given
        Routine routine = new Routine();

        // when & then
        assertThatThrownBy(() -> routine.setTitle(title)).isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void setTitle_lengthGreaterThan100_throwIllegalArgumentException() {
        // given
        String title = StringUtils.repeat("a", 101);
        Routine routine = new Routine();

        // when & then
        assertThatThrownBy(() -> routine.setTitle(title)).isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void setStartDate__success() {
        // given
        LocalDate startDate = LocalDate.of(2024, 4, 26);
        Routine routine = new Routine();

        // when
        routine.setStartDate(startDate);

        // then
        assertThat(routine.getStartDate()).isEqualTo(startDate);
    }

    @Test
    public void setStartDate_null_throwIllegalArgumentException() {
        // given
        LocalDate startDate = null;
        Routine routine = new Routine();

        // when & then
        assertThatThrownBy(() -> routine.setStartDate(startDate)).isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void setEndDate__success() {
        // given
        LocalDate EndDate = LocalDate.of(2024, 4, 26);
        Routine routine = new Routine();

        // when
        routine.setEndDate(EndDate);

        // then
        assertThat(routine.getEndDate()).isEqualTo(EndDate);
    }

    @Test
    public void setEndDate_null_throwIllegalArgumentException() {
        // given
        LocalDate EndDate = null;
        Routine routine = new Routine();

        // when & then
        assertThatThrownBy(() -> routine.setEndDate(EndDate)).isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void removeEndDate__success() {
        // given
        Routine routine = new Routine();
        routine.setEndDate(LocalDate.of(2024, 4, 26));

        // when
        routine.removeEndDate();

        // then
        assertThat(routine.getEndDate()).isNull();
    }

    @Test
    public void setTime__success() {
        // given
        LocalTime startTime = LocalTime.of(9, 0);
        LocalTime endTime = LocalTime.of(18, 0);
        Routine routine = new Routine();

        // when
        routine.setTime(startTime, endTime);

        // then
        assertThat(routine.getStartTime()).isEqualTo(startTime);
        assertThat(routine.getEndTime()).isEqualTo(endTime);
    }

    @Test
    public void setTime_anyNull_throwIllegalArgumentException() {
        // given
        LocalTime startTime = LocalTime.of(9, 0);
        LocalTime endTime = LocalTime.of(18, 0);
        Routine routine = new Routine();

        // when & then
        assertThatThrownBy(() -> routine.setTime(null, null)).isInstanceOf(IllegalArgumentException.class);
        assertThatThrownBy(() -> routine.setTime(startTime, null)).isInstanceOf(IllegalArgumentException.class);
        assertThatThrownBy(() -> routine.setTime(null, endTime)).isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void setAllDay__success() {
        // given
        Routine routine = new Routine();
        routine.setTime(LocalTime.of(9, 0), LocalTime.of(18, 0));

        // when
        routine.setAllDay();

        // then
        assertThat(routine.getStartTime()).isNull();
        assertThat(routine.getEndTime()).isNull();
    }

    @ParameterizedTest
    @ValueSource(longs = {1, 10, 50, /* 일주일 */ 60 * 24 * 7})
    public void setAlertBefore__success(long minutes) {
        // given
        Duration alertBefore = Duration.ofMinutes(minutes);
        Routine routine = new Routine();

        // when
        routine.setAlertBefore(alertBefore);

        // then
        assertThat(routine.getAlertBefore()).isEqualTo(alertBefore);
    }

    @Test
    public void setAlertBefore_null_success() {
        // given
        Duration alertBefore = null;
        Routine routine = new Routine();

        // when
        routine.setAlertBefore(alertBefore);

        // then
        assertThat(routine.getAlertBefore()).isEqualTo(alertBefore);
    }

    @Test
    public void setAlertBefore_greaterThan7Days_throwIllegalArgumentException() {
        // given
        Duration alertBefore = Duration.ofDays(7).plus(Duration.ofMinutes(1));
        Routine routine = new Routine();

        // when & then
        assertThatThrownBy(() -> routine.setAlertBefore(alertBefore)).isInstanceOf(IllegalArgumentException.class);
    }

    @ParameterizedTest
    @ValueSource(longs = {59, 0, -30, -999999})
    public void setAlertBefore_lessThan1minute_throwIllegalArgumentException(long seconds) {
        // given
        Duration alertBefore = Duration.ofSeconds(seconds);
        Routine routine = new Routine();

        // when & then
        assertThatThrownBy(() -> routine.setAlertBefore(alertBefore)).isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void removeAlert__success() {
        // given
        Routine routine = new Routine();
        routine.setAlertBefore(Duration.ofMinutes(30));

        // when
        routine.removeAlert();

        // then
        assertThat(routine.getAlertBefore()).isNull();
    }

    @Test
    public void setMemo_notEmpty_success() {
        // given
        String memo = "Hello";
        Routine routine = new Routine();

        // when
        routine.setMemo(memo);

        // then
        assertThat(routine.getMemo()).isEqualTo(memo);
    }

    @Test
    public void setMemo_empty_success() {
        // given
        String empty = "";
        Routine routine = new Routine();
        routine.setMemo("Before.");

        // when
        routine.setMemo(empty);

        // then
        assertThat(routine.getMemo()).isEqualTo(empty);
    }

    @Test
    public void setMemo_null_throwIllegalArgumentException() {
        // given
        Routine routine = new Routine();

        // when & then
        assertThatThrownBy(() -> routine.setMemo(null)).isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void setToPlace_nameOnly_success() {
        // given
        String toPlaceName = "Seoul";
        Routine routine = new Routine();

        // when
        routine.setToPlace(toPlaceName);

        // then
        assertThat(routine.getToPlaceName()).isEqualTo(toPlaceName);
        assertThat(routine.getFromPlaceLat()).isNull();
        assertThat(routine.getFromPlaceLng()).isNull();
    }

    @Test
    public void setToPlace_nameAndLatLng_success() {
        // given
        String toPlaceName = "Seoul";
        float lat = 123.4567f;
        float lng = 35.79f;
        Routine routine = new Routine();

        // when
        routine.setToPlace(toPlaceName, lat, lng);

        // then
        assertThat(routine.getToPlaceName()).isEqualTo(toPlaceName);
        assertThat(routine.getToPlaceLat()).isEqualTo(lat);
        assertThat(routine.getToPlaceLng()).isEqualTo(lng);
    }

    @ParameterizedTest
    @NullAndEmptySource
    public void setToPlace_nullOrEmpty_throwIllegalArgumentException(String toPlaceName) {
        // given
        Routine routine = new Routine();

        // when & then
        assertThatThrownBy(() -> routine.setToPlace(toPlaceName)).isInstanceOf(IllegalArgumentException.class);
        assertThatThrownBy(() -> routine.setToPlace(toPlaceName, 1.0f, 1.0f)).isInstanceOf(
                IllegalArgumentException.class);
    }

    @Test
    public void setToPlace_lengthGreaterThan100_throwIllegalArgumentException() {
        // given
        String toPlaceName = StringUtils.repeat("a", 101);
        Routine routine = new Routine();

        // when & then
        assertThatThrownBy(() -> routine.setToPlace(toPlaceName)).isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void removeToPlace__success() {
        // given
        Routine routine = new Routine();
        routine.setToPlace("Seoul", 1.0f, 2.0f);

        // when
        routine.removeToPlace();

        // then
        assertThat(routine.getToPlaceName()).isNull();
        assertThat(routine.getToPlaceLat()).isNull();
        assertThat(routine.getToPlaceLng()).isNull();
    }

    @Test
    public void setFromPlace_nameOnly_success() {
        // given
        String fromPlaceName = "Seoul";
        Routine routine = new Routine();

        // when
        routine.setFromPlace(fromPlaceName);

        // then
        assertThat(routine.getFromPlaceName()).isEqualTo(fromPlaceName);
        assertThat(routine.getFromPlaceLat()).isNull();
        assertThat(routine.getFromPlaceLng()).isNull();
    }

    @Test
    public void setFromPlace_nameAndLatLng_success() {
        // given
        String fromPlaceName = "Seoul";
        float lat = 123.4567f;
        float lng = 35.79f;
        Routine routine = new Routine();

        // when
        routine.setFromPlace(fromPlaceName, lat, lng);

        // then
        assertThat(routine.getFromPlaceName()).isEqualTo(fromPlaceName);
        assertThat(routine.getFromPlaceLat()).isEqualTo(lat);
        assertThat(routine.getFromPlaceLng()).isEqualTo(lng);
    }

    @ParameterizedTest
    @NullAndEmptySource
    public void setFromPlace_nullOrEmpty_throwIllegalArgumentException(String fromPlaceName) {
        // given
        Routine routine = new Routine();

        // when & then
        assertThatThrownBy(() -> routine.setFromPlace(fromPlaceName)).isInstanceOf(IllegalArgumentException.class);
        assertThatThrownBy(() -> routine.setFromPlace(fromPlaceName, 1.0f, 1.0f)).isInstanceOf(
                IllegalArgumentException.class);
    }

    @Test
    public void setFromPlace_lengthGreaterThan100_throwIllegalArgumentException() {
        // given
        String fromPlaceName = StringUtils.repeat("a", 101);
        Routine routine = new Routine();

        // when & then
        assertThatThrownBy(() -> routine.setFromPlace(fromPlaceName)).isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void removeFromPlace__success() {
        // given
        Routine routine = new Routine();
        routine.setFromPlace("Seoul", 1.0f, 2.0f);

        // when
        routine.removeFromPlace();

        // then
        assertThat(routine.getFromPlaceName()).isNull();
        assertThat(routine.getFromPlaceLat()).isNull();
        assertThat(routine.getFromPlaceLng()).isNull();
    }

    @Test
    public void createSchedules_createdSchedule_equalsRoutineProperties() {
        // given
        RoutineCycle cycle = RoutineCycle.DAILY;
        LocalDate startDate = LocalDate.of(2024, 4, 1);
        LocalDate endDate = LocalDate.of(2024, 4, 1);
        LocalDate repeatStartDate = LocalDate.of(2024, 4, 1);
        LocalDate repeatEndDate = LocalDate.of(2024, 4, 1);
        LocalDate from = LocalDate.of(2024, 4, 1);
        LocalDate to = LocalDate.of(2024, 4, 1);
        Routine routine = routineBuilder.member(member)
                .startDate(startDate)
                .endDate(endDate)
                .repeatCycle(cycle)
                .repeatStartDate(repeatStartDate)
                .repeatEndDate(repeatEndDate)
                .repeatAt(1)
                .build();
        Schedule schedule = scheduleBuilder.id(null)
                .member(member)
                .routine(routine)
                .startDate(startDate)
                .endDate(endDate)
                .build();

        // when
        List<Schedule> schedules = routine.createSchedules(from, to);
        Schedule created = schedules.get(0);

        // then
        assertThat(created).isEqualTo(schedule);
    }

    @Test
    public void createSchedules_daily_success() {
        // given
        RoutineCycle cycle = RoutineCycle.DAILY;
        LocalDate repeatStartDate = LocalDate.of(2024, 4, 1);
        LocalDate repeatEndDate = LocalDate.of(2024, 4, 4);
        LocalDate from = LocalDate.of(2024, 3, 1);
        LocalDate to = LocalDate.of(2024, 5, 1);
        int repeatAt = 1;
        Routine routine = routineBuilder.member(member)
                .repeatCycle(cycle)
                .repeatStartDate(repeatStartDate)
                .repeatEndDate(repeatEndDate)
                .repeatAt(repeatAt)
                .build();

        // when
        List<Schedule> schedules = routine.createSchedules(from, to);

        // then
        assertThat(schedules.size()).isEqualTo(4);
        assertThat(schedules.get(0).getStartDate()).isEqualTo(repeatStartDate);
        assertThat(schedules.get(schedules.size() - 1).getStartDate()).isEqualTo(repeatEndDate);
    }

    @Test
    public void createSchedules_dailyRepeat4For9_return3Schedules() {
        // given
        RoutineCycle cycle = RoutineCycle.DAILY;
        LocalDate repeatStartDate = LocalDate.of(2024, 4, 1);
        LocalDate repeatEndDate = LocalDate.of(2024, 4, 9);
        LocalDate from = LocalDate.of(2024, 3, 1);
        LocalDate to = LocalDate.of(2024, 5, 1);
        int repeatAt = 4;
        Routine routine = routineBuilder.member(member)
                .repeatCycle(cycle)
                .repeatStartDate(repeatStartDate)
                .repeatEndDate(repeatEndDate)
                .repeatAt(repeatAt)
                .build();

        // when
        List<Schedule> schedules = routine.createSchedules(from, to);

        // then
        assertThat(schedules.size()).isEqualTo(3);
        assertThat(schedules.get(0).getStartDate()).isEqualTo(repeatStartDate);
        assertThat(schedules.get(schedules.size() - 1).getStartDate()).isEqualTo(repeatEndDate);
    }

    @Test
    public void createSchedules_daily_returnBetweenDates() {
        // given
        RoutineCycle cycle = RoutineCycle.DAILY;
        LocalDate repeatStartDate = LocalDate.of(2024, 3, 1);
        LocalDate repeatEndDate = LocalDate.of(2024, 5, 1);
        LocalDate from = LocalDate.of(2024, 4, 3);
        LocalDate to = LocalDate.of(2024, 6, 19);
        int repeatAt = 3;
        Routine routine = routineBuilder.member(member)
                .repeatCycle(cycle)
                .repeatStartDate(repeatStartDate)
                .repeatEndDate(repeatEndDate)
                .repeatAt(repeatAt)
                .build();

        // when
        List<Schedule> schedules = routine.createSchedules(from, to);

        // then
        assertThat(schedules).allSatisfy(schedule -> {
            assertThat(schedule.getStartDate()).isAfterOrEqualTo(repeatStartDate);
            assertThat(schedule.getStartDate()).isAfterOrEqualTo(from);
            assertThat(schedule.getStartDate()).isBeforeOrEqualTo(repeatEndDate);
            assertThat(schedule.getStartDate()).isBeforeOrEqualTo(to);
        });
    }

    @Test
    public void createSchedules_weekly_success() {
        // given
        RoutineCycle cycle = RoutineCycle.WEEKLY;
        LocalDate repeatStartDate = LocalDate.of(2024, 4, 1);
        LocalDate repeatEndDate = LocalDate.of(2024, 4, 5);
        LocalDate from = LocalDate.of(2024, 3, 1);
        LocalDate to = LocalDate.of(2024, 5, 1);
        int repeatAt = Routine.weeklyRepeatAtOf(DayOfWeek.MONDAY, DayOfWeek.WEDNESDAY, DayOfWeek.FRIDAY);
        Routine routine = routineBuilder.member(member)
                .repeatCycle(cycle)
                .repeatStartDate(repeatStartDate)
                .repeatEndDate(repeatEndDate)
                .repeatAt(repeatAt)
                .build();

        // when
        List<Schedule> schedules = routine.createSchedules(from, to);

        // then
        assertThat(schedules.size()).isEqualTo(3);
        assertThat(schedules.get(0).getStartDate().getDayOfWeek()).isEqualTo(DayOfWeek.MONDAY);
        assertThat(schedules.get(schedules.size() - 1).getStartDate().getDayOfWeek()).isEqualTo(DayOfWeek.FRIDAY);
    }

    @Test
    public void createSchedules_weekly_returnBetweenDates() {
        // given
        RoutineCycle cycle = RoutineCycle.WEEKLY;
        LocalDate repeatStartDate = LocalDate.of(2024, 3, 1);
        LocalDate repeatEndDate = LocalDate.of(2024, 5, 1);
        LocalDate from = LocalDate.of(2024, 4, 3);
        LocalDate to = LocalDate.of(2024, 6, 19);
        int repeatAt = Routine.weeklyRepeatAtOf(DayOfWeek.MONDAY, DayOfWeek.WEDNESDAY, DayOfWeek.FRIDAY,
                DayOfWeek.SUNDAY);
        Routine routine = routineBuilder.member(member)
                .repeatCycle(cycle)
                .repeatStartDate(repeatStartDate)
                .repeatEndDate(repeatEndDate)
                .repeatAt(repeatAt)
                .build();

        // when
        List<Schedule> schedules = routine.createSchedules(from, to);

        // then
        assertThat(schedules).allSatisfy(schedule -> {
            assertThat(schedule.getStartDate()).isAfterOrEqualTo(repeatStartDate);
            assertThat(schedule.getStartDate()).isAfterOrEqualTo(from);
            assertThat(schedule.getStartDate()).isBeforeOrEqualTo(repeatEndDate);
            assertThat(schedule.getStartDate()).isBeforeOrEqualTo(to);
        });
    }

    @ParameterizedTest
    @ValueSource(ints = {5, 20})
    public void createSchedules_monthly_success(int repeatAt) {
        // given
        RoutineCycle cycle = RoutineCycle.MONTHLY;
        LocalDate repeatStartDate = LocalDate.of(2024, 2, 10);
        LocalDate repeatEndDate = LocalDate.of(2024, 5, 15);
        LocalDate from = LocalDate.of(2024, 1, 1);
        LocalDate to = LocalDate.of(2024, 12, 1);
        Routine routine = routineBuilder.member(member)
                .repeatCycle(cycle)
                .repeatStartDate(repeatStartDate)
                .repeatEndDate(repeatEndDate)
                .repeatAt(repeatAt)
                .build();

        // when
        List<Schedule> schedules = routine.createSchedules(from, to);

        // then
        assertThat(schedules.size()).isEqualTo(3);
    }

    @Test
    public void createSchedules_monthlyRepeatAt31For1Year_return7Schedules() {
        // given
        RoutineCycle cycle = RoutineCycle.MONTHLY;
        LocalDate repeatStartDate = LocalDate.of(2024, 1, 1);
        LocalDate repeatEndDate = LocalDate.of(2024, 12, 31);
        LocalDate from = LocalDate.of(2024, 1, 1);
        LocalDate to = LocalDate.of(2024, 12, 31);
        int repeatAt = 31;
        Routine routine = routineBuilder.member(member)
                .repeatCycle(cycle)
                .repeatStartDate(repeatStartDate)
                .repeatEndDate(repeatEndDate)
                .repeatAt(repeatAt)
                .build();

        // when
        List<Schedule> schedules = routine.createSchedules(from, to);

        // then
        assertThat(schedules.size()).isEqualTo(7);
    }

    @Test
    public void createSchedules_monthly_returnBetweenDates() {
        // given
        RoutineCycle cycle = RoutineCycle.MONTHLY;
        LocalDate repeatStartDate = LocalDate.of(2024, 3, 1);
        LocalDate repeatEndDate = LocalDate.of(2024, 5, 1);
        LocalDate from = LocalDate.of(2024, 4, 3);
        LocalDate to = LocalDate.of(2024, 6, 19);
        int repeatAt = 5;
        Routine routine = routineBuilder.member(member)
                .repeatCycle(cycle)
                .repeatStartDate(repeatStartDate)
                .repeatEndDate(repeatEndDate)
                .repeatAt(repeatAt)
                .build();

        // when
        List<Schedule> schedules = routine.createSchedules(from, to);

        // then
        assertThat(schedules).allSatisfy(schedule -> {
            assertThat(schedule.getStartDate()).isAfterOrEqualTo(repeatStartDate);
            assertThat(schedule.getStartDate()).isAfterOrEqualTo(from);
            assertThat(schedule.getStartDate()).isBeforeOrEqualTo(repeatEndDate);
            assertThat(schedule.getStartDate()).isBeforeOrEqualTo(to);
        });
    }

    @Test
    public void createSchedules_yearly_success() {
        // given
        RoutineCycle cycle = RoutineCycle.YEARLY;
        LocalDate repeatStartDate = LocalDate.of(2024, 2, 10);
        LocalDate repeatEndDate = LocalDate.of(2024, 5, 15);
        LocalDate from = LocalDate.of(2024, 1, 1);
        LocalDate to = LocalDate.of(2024, 12, 1);
        int repeatAt = 413;
        LocalDate expected = LocalDate.of(2024, 4, 13);
        Routine routine = routineBuilder.member(member)
                .repeatCycle(cycle)
                .repeatStartDate(repeatStartDate)
                .repeatEndDate(repeatEndDate)
                .repeatAt(repeatAt)
                .build();

        // when
        List<Schedule> schedules = routine.createSchedules(from, to);

        // then
        assertThat(schedules.size()).isEqualTo(1);
        assertThat(schedules.get(0).getStartDate()).isEqualTo(expected);
    }

    @Test
    public void createSchedules_yearlyFor10Years_return10Schedules() {
        // given
        RoutineCycle cycle = RoutineCycle.YEARLY;
        LocalDate repeatStartDate = LocalDate.of(2013, 1, 1);
        LocalDate repeatEndDate = LocalDate.of(2024, 12, 31);
        LocalDate from = LocalDate.of(2015, 1, 1);
        LocalDate to = LocalDate.of(2026, 12, 31);
        int repeatAt = 619;
        Routine routine = routineBuilder.member(member)
                .repeatCycle(cycle)
                .repeatStartDate(repeatStartDate)
                .repeatEndDate(repeatEndDate)
                .repeatAt(repeatAt)
                .build();

        // when
        List<Schedule> schedules = routine.createSchedules(from, to);

        // then
        assertThat(schedules.size()).isEqualTo(10);
    }

    @Test
    public void createSchedules_yearlyRepeatAt229For12Years_return3Schedules() {
        // given
        RoutineCycle cycle = RoutineCycle.YEARLY;
        LocalDate repeatStartDate = LocalDate.of(2011, 1, 1);
        LocalDate repeatEndDate = LocalDate.of(2023, 12, 31);
        LocalDate from = LocalDate.of(2011, 1, 1);
        LocalDate to = LocalDate.of(2023, 12, 31);
        int repeatAt = 229;
        Routine routine = routineBuilder.member(member)
                .repeatCycle(cycle)
                .repeatStartDate(repeatStartDate)
                .repeatEndDate(repeatEndDate)
                .repeatAt(repeatAt)
                .build();

        // when
        List<Schedule> schedules = routine.createSchedules(from, to);

        // then
        assertThat(schedules.size()).isEqualTo(3);
    }
}
