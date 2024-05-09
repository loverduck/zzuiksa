package com.zzuiksa.server.domain.schedule.entity;

import static org.assertj.core.api.Assertions.*;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;

import org.apache.commons.lang3.StringUtils;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.NullAndEmptySource;
import org.junit.jupiter.params.provider.ValueSource;

public class ScheduleTests {

    @Test
    public void setTitle__success() {
        // given
        String title = "저녁 먹기";
        Schedule schedule = new Schedule();

        // when
        schedule.setTitle(title);

        // then
        assertThat(schedule.getTitle()).isEqualTo(title);
    }

    @Test
    public void setTitle_null_throwIllegalArgumentException() {
        // given
        String title = null;
        Schedule schedule = new Schedule();

        // when & then
        assertThatThrownBy(() -> schedule.setTitle(title))
                .isInstanceOf(IllegalArgumentException.class);
    }

    @ParameterizedTest
    @ValueSource(strings = {"", " ", "   ", "\n", "\t", "\t \n   \n"})
    public void setTitle_empty_throwIllegalArgumentException(String title) {
        // given
        Schedule schedule = new Schedule();

        // when & then
        assertThatThrownBy(() -> schedule.setTitle(title))
                .isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void setTitle_lengthGreaterThan100_throwIllegalArgumentException() {
        // given
        String title = StringUtils.repeat("a", 101);
        Schedule schedule = new Schedule();

        // when & then
        assertThatThrownBy(() -> schedule.setTitle(title))
                .isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void setStartDate__success() {
        // given
        LocalDate startDate = LocalDate.of(2024, 4, 26);
        Schedule schedule = new Schedule();

        // when
        schedule.setStartDate(startDate);

        // then
        assertThat(schedule.getStartDate()).isEqualTo(startDate);
    }

    @Test
    public void setStartDate_null_throwIllegalArgumentException() {
        // given
        LocalDate startDate = null;
        Schedule schedule = new Schedule();

        // when & then
        assertThatThrownBy(() -> schedule.setStartDate(startDate))
                .isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void setEndDate__success() {
        // given
        LocalDate EndDate = LocalDate.of(2024, 4, 26);
        Schedule schedule = new Schedule();

        // when
        schedule.setEndDate(EndDate);

        // then
        assertThat(schedule.getEndDate()).isEqualTo(EndDate);
    }

    @Test
    public void setEndDate_null_throwIllegalArgumentException() {
        // given
        LocalDate EndDate = null;
        Schedule schedule = new Schedule();

        // when & then
        assertThatThrownBy(() -> schedule.setEndDate(EndDate))
                .isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void removeEndDate__success() {
        // given
        Schedule schedule = new Schedule();
        schedule.setEndDate(LocalDate.of(2024, 4, 26));

        // when
        schedule.removeEndDate();

        // then
        assertThat(schedule.getEndDate()).isNull();
    }

    @Test
    public void setTime__success() {
        // given
        LocalTime startTime = LocalTime.of(9, 0);
        LocalTime endTime = LocalTime.of(18, 0);
        Schedule schedule = new Schedule();

        // when
        schedule.setTime(startTime, endTime);

        // then
        assertThat(schedule.getStartTime()).isEqualTo(startTime);
        assertThat(schedule.getEndTime()).isEqualTo(endTime);
    }

    @Test
    public void setTime_anyNull_throwIllegalArgumentException() {
        // given
        LocalTime startTime = LocalTime.of(9, 0);
        LocalTime endTime = LocalTime.of(18, 0);
        Schedule schedule = new Schedule();

        // when & then
        assertThatThrownBy(() -> schedule.setTime(null, null))
                .isInstanceOf(IllegalArgumentException.class);
        assertThatThrownBy(() -> schedule.setTime(startTime, null))
                .isInstanceOf(IllegalArgumentException.class);
        assertThatThrownBy(() -> schedule.setTime(null, endTime))
                .isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void setAllDay__success() {
        // given
        Schedule schedule = new Schedule();
        schedule.setTime(LocalTime.of(9, 0), LocalTime.of(18, 0));

        // when
        schedule.setAllDay();

        // then
        assertThat(schedule.getStartTime()).isNull();
        assertThat(schedule.getEndTime()).isNull();
    }

    @ParameterizedTest
    @ValueSource(longs = {1, 10, 50, /* 일주일 */ 60 * 24 * 7})
    public void setAlertBefore__success(long minutes) {
        // given
        Duration alertBefore = Duration.ofMinutes(minutes);
        Schedule schedule = new Schedule();

        // when
        schedule.setAlertBefore(alertBefore);

        // then
        assertThat(schedule.getAlertBefore()).isEqualTo(alertBefore);
    }

    @Test
    public void setAlertBefore_null_success() {
        // given
        Duration alertBefore = null;
        Schedule schedule = new Schedule();

        // when
        schedule.setAlertBefore(alertBefore);

        // then
        assertThat(schedule.getAlertBefore()).isEqualTo(alertBefore);
    }

    @Test
    public void setAlertBefore_greaterThan7Days_throwIllegalArgumentException() {
        // given
        Duration alertBefore = Duration.ofDays(7).plus(Duration.ofMinutes(1));
        Schedule schedule = new Schedule();

        // when & then
        assertThatThrownBy(() -> schedule.setAlertBefore(alertBefore))
                .isInstanceOf(IllegalArgumentException.class);
    }

    @ParameterizedTest
    @ValueSource(longs = {59, 0, -30, -999999})
    public void setAlertBefore_lessThan1minute_throwIllegalArgumentException(long seconds) {
        // given
        Duration alertBefore = Duration.ofSeconds(seconds);
        Schedule schedule = new Schedule();

        // when & then
        assertThatThrownBy(() -> schedule.setAlertBefore(alertBefore))
                .isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void removeAlert__success() {
        // given
        Schedule schedule = new Schedule();
        schedule.setAlertBefore(Duration.ofMinutes(30));

        // when
        schedule.removeAlert();

        // then
        assertThat(schedule.getAlertBefore()).isNull();
    }

    @Test
    public void setMemo_notEmpty_success() {
        // given
        String memo = "Hello";
        Schedule schedule = new Schedule();

        // when
        schedule.setMemo(memo);

        // then
        assertThat(schedule.getMemo()).isEqualTo(memo);
    }

    @Test
    public void setMemo_empty_success() {
        // given
        String empty = "";
        Schedule schedule = new Schedule();
        schedule.setMemo("Before.");

        // when
        schedule.setMemo(empty);

        // then
        assertThat(schedule.getMemo()).isEqualTo(empty);
    }

    @Test
    public void setMemo_null_throwIllegalArgumentException() {
        // given
        Schedule schedule = new Schedule();

        // when & then
        assertThatThrownBy(() -> schedule.setMemo(null))
                .isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void setToPlace_nameOnly_success() {
        // given
        String toPlaceName = "Seoul";
        Schedule schedule = new Schedule();

        // when
        schedule.setToPlace(toPlaceName);

        // then
        assertThat(schedule.getToPlaceName()).isEqualTo(toPlaceName);
        assertThat(schedule.getFromPlaceLat()).isNull();
        assertThat(schedule.getFromPlaceLng()).isNull();
    }

    @Test
    public void setToPlace_nameAndLatLng_success() {
        // given
        String toPlaceName = "Seoul";
        float lat = 123.4567f;
        float lng = 35.79f;
        Schedule schedule = new Schedule();

        // when
        schedule.setToPlace(toPlaceName, lat, lng);

        // then
        assertThat(schedule.getToPlaceName()).isEqualTo(toPlaceName);
        assertThat(schedule.getToPlaceLat()).isEqualTo(lat);
        assertThat(schedule.getToPlaceLng()).isEqualTo(lng);
    }

    @ParameterizedTest
    @NullAndEmptySource
    public void setToPlace_nullOrEmpty_throwIllegalArgumentException(String toPlaceName) {
        // given
        Schedule schedule = new Schedule();

        // when & then
        assertThatThrownBy(() -> schedule.setToPlace(toPlaceName))
                .isInstanceOf(IllegalArgumentException.class);
        assertThatThrownBy(() -> schedule.setToPlace(toPlaceName, 1.0f, 1.0f))
                .isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void setToPlace_lengthGreaterThan100_throwIllegalArgumentException() {
        // given
        String toPlaceName = StringUtils.repeat("a", 101);
        Schedule schedule = new Schedule();

        // when & then
        assertThatThrownBy(() -> schedule.setToPlace(toPlaceName))
                .isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void removeToPlace__success() {
        // given
        Schedule schedule = new Schedule();
        schedule.setToPlace("Seoul", 1.0f, 2.0f);

        // when
        schedule.removeToPlace();

        // then
        assertThat(schedule.getToPlaceName()).isNull();
        assertThat(schedule.getToPlaceLat()).isNull();
        assertThat(schedule.getToPlaceLng()).isNull();
    }

    @Test
    public void setFromPlace_nameOnly_success() {
        // given
        String fromPlaceName = "Seoul";
        Schedule schedule = new Schedule();

        // when
        schedule.setFromPlace(fromPlaceName);

        // then
        assertThat(schedule.getFromPlaceName()).isEqualTo(fromPlaceName);
        assertThat(schedule.getFromPlaceLat()).isNull();
        assertThat(schedule.getFromPlaceLng()).isNull();
    }

    @Test
    public void setFromPlace_nameAndLatLng_success() {
        // given
        String fromPlaceName = "Seoul";
        float lat = 123.4567f;
        float lng = 35.79f;
        Schedule schedule = new Schedule();

        // when
        schedule.setFromPlace(fromPlaceName, lat, lng);

        // then
        assertThat(schedule.getFromPlaceName()).isEqualTo(fromPlaceName);
        assertThat(schedule.getFromPlaceLat()).isEqualTo(lat);
        assertThat(schedule.getFromPlaceLng()).isEqualTo(lng);
    }

    @ParameterizedTest
    @NullAndEmptySource
    public void setFromPlace_nullOrEmpty_throwIllegalArgumentException(String fromPlaceName) {
        // given
        Schedule schedule = new Schedule();

        // when & then
        assertThatThrownBy(() -> schedule.setFromPlace(fromPlaceName))
                .isInstanceOf(IllegalArgumentException.class);
        assertThatThrownBy(() -> schedule.setFromPlace(fromPlaceName, 1.0f, 1.0f))
                .isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void setFromPlace_lengthGreaterThan100_throwIllegalArgumentException() {
        // given
        String fromPlaceName = StringUtils.repeat("a", 101);
        Schedule schedule = new Schedule();

        // when & then
        assertThatThrownBy(() -> schedule.setFromPlace(fromPlaceName))
                .isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void removeFromPlace__success() {
        // given
        Schedule schedule = new Schedule();
        schedule.setFromPlace("Seoul", 1.0f, 2.0f);

        // when
        schedule.removeFromPlace();

        // then
        assertThat(schedule.getFromPlaceName()).isNull();
        assertThat(schedule.getFromPlaceLat()).isNull();
        assertThat(schedule.getFromPlaceLng()).isNull();
    }
}
