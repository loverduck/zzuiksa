package com.zzuiksa.server.domain.schedule.entity;

import java.time.DayOfWeek;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.Period;
import java.util.ArrayList;
import java.util.List;

import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.schedule.constant.RoutineCycle;
import com.zzuiksa.server.global.entity.BaseEntity;
import com.zzuiksa.server.global.util.Utils;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Getter
@NoArgsConstructor
@ToString
@EqualsAndHashCode(callSuper = true)
public class Routine extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "member_id", nullable = false)
    private Member member;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;

    @NotBlank
    @Size(max = 100)
    @Column(length = 100, nullable = false)
    private String title;

    @NotNull
    @Column(nullable = false)
    private LocalDate startDate;

    @NotNull
    @Column(nullable = false)
    private LocalDate endDate;

    private LocalTime startTime;

    private LocalTime endTime;

    private Duration alertBefore;

    @NotNull
    @Size(max = 1000)
    @Column(length = 1000, nullable = false)
    private String memo;

    @Size(max = 100)
    @Column(name = "to_place", length = 100)
    private String toPlaceName;

    @Column(name = "to_lat")
    private Float toPlaceLat;

    @Column(name = "to_lng")
    private Float toPlaceLng;

    @Size(max = 100)
    @Column(name = "from_place", length = 100)
    private String fromPlaceName;

    @Column(name = "from_lat")
    private Float fromPlaceLat;

    @Column(name = "from_lng")
    private Float fromPlaceLng;

    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private RoutineCycle repeatCycle;

    @NotNull
    @Column(nullable = false)
    private LocalDate repeatStartDate;

    private LocalDate repeatEndDate;

    @NotNull
    @Min(value = 1)
    @Column(nullable = false)
    private Integer repeatAt;

    @Builder
    Routine(Long id, Member member, Category category, String title, LocalDate startDate, LocalDate endDate,
            LocalTime startTime, LocalTime endTime, Duration alertBefore, String memo, String toPlaceName,
            Float toPlaceLat, Float toPlaceLng, String fromPlaceName, Float fromPlaceLat, Float fromPlaceLng,
            RoutineCycle repeatCycle, LocalDate repeatStartDate, LocalDate repeatEndDate, Integer repeatAt) {
        this.id = id;
        if (member == null) {
            throw new IllegalArgumentException("Member is null");
        }
        this.member = member;
        this.category = category;
        setTitle(title);
        setStartDate(startDate);
        setEndDate(endDate);
        if (startTime != null && endTime != null) {
            setTime(startTime, endTime);
        } else {
            setAllDay();
        }
        setAlertBefore(alertBefore);
        setMemo(memo);
        if (toPlaceName != null) {
            if (toPlaceLat != null && toPlaceLng != null) {
                setToPlace(toPlaceName, toPlaceLat, toPlaceLng);
            } else {
                setToPlace(toPlaceName);
            }
        }
        if (fromPlaceName != null) {
            if (fromPlaceLat != null && fromPlaceLng != null) {
                setFromPlace(fromPlaceName, fromPlaceLat, fromPlaceLng);
            } else {
                setFromPlace(fromPlaceName);
            }
        }
        if (repeatCycle == null) {
            throw new IllegalArgumentException("Repeat Cycle is null");
        }
        this.repeatCycle = repeatCycle;
        if (repeatStartDate == null) {
            throw new IllegalArgumentException("Repeat Start Date is null");
        }
        this.repeatStartDate = repeatStartDate;
        this.repeatEndDate = repeatEndDate;
        if (repeatAt == null) {
            throw new IllegalArgumentException("Repeat at is null");
        }
        if (repeatAt <= 0) {
            throw new IllegalArgumentException("Repeat at must be greater than 0");
        }
        this.repeatAt = repeatAt;
    }

    public void setTitle(String title) {
        if (!Utils.hasTextAndLengthBetween(title, 1, 100)) {
            throw new IllegalArgumentException("title은 비어있지 않고 길이가 1 이상 100 이하여야 합니다.");
        }
        this.title = title;
    }

    public void setStartDate(LocalDate startDate) {
        if (startDate == null) {
            throw new IllegalArgumentException("startDate is null");
        }
        this.startDate = startDate;
    }

    public void setEndDate(LocalDate endDate) {
        if (endDate == null) {
            throw new IllegalArgumentException("endDate is null");
        }
        this.endDate = endDate;
    }

    public void removeEndDate() {
        this.endDate = null;
    }

    public void setTime(LocalTime startTime, LocalTime endTime) {
        if (startTime == null || endTime == null) {
            throw new IllegalArgumentException("startTime or endTime is null");
        }
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public void setAllDay() {
        this.startTime = null;
        this.endTime = null;
    }

    public void setAlertBefore(Duration alertBefore) {
        if (alertBefore != null && alertBefore.compareTo(Duration.ofMinutes(1)) < 0) {
            throw new IllegalArgumentException("alertBefore is negative");
        }
        if (alertBefore != null && alertBefore.compareTo(Duration.ofDays(7)) > 0) {
            throw new IllegalArgumentException("alertBefore is greater than 7 days");
        }
        this.alertBefore = alertBefore;
    }

    public void removeAlert() {
        this.alertBefore = null;
    }

    public void setMemo(String memo) {
        if (memo == null) {
            throw new IllegalArgumentException("memo is null");
        }
        if (memo.length() > 1000) {
            throw new IllegalArgumentException("memo langth > 1000");
        }
        this.memo = memo;
    }

    public void setToPlace(String toPlaceName) {
        if (!Utils.hasTextAndLengthBetween(toPlaceName, 1, 100)) {
            throw new IllegalArgumentException("toPlaceName should have text and length between 1 and 100");
        }
        this.toPlaceName = toPlaceName;
        this.toPlaceLat = null;
        this.toPlaceLng = null;
    }

    public void setToPlace(String toPlaceName, float toPlaceLat, float toPlaceLng) {
        if (!Utils.hasTextAndLengthBetween(toPlaceName, 1, 100)) {
            throw new IllegalArgumentException("toPlaceName should have text and length between 1 and 100");
        }
        this.toPlaceName = toPlaceName;
        this.toPlaceLat = toPlaceLat;
        this.toPlaceLng = toPlaceLng;
    }

    public void removeToPlace() {
        this.toPlaceName = null;
        this.toPlaceLat = null;
        this.toPlaceLng = null;
    }

    public void setFromPlace(String fromPlaceName) {
        if (!Utils.hasTextAndLengthBetween(fromPlaceName, 1, 100)) {
            throw new IllegalArgumentException("fromPlaceName should have text and length between 1 and 100");
        }
        this.fromPlaceName = fromPlaceName;
        this.fromPlaceLat = null;
        this.fromPlaceLng = null;
    }

    public void setFromPlace(String fromPlaceName, float fromPlaceLat, float fromPlaceLng) {
        if (!Utils.hasTextAndLengthBetween(fromPlaceName, 1, 100)) {
            throw new IllegalArgumentException("fromPlaceName should have text and length between 1 and 100");
        }
        this.fromPlaceName = fromPlaceName;
        this.fromPlaceLat = fromPlaceLat;
        this.fromPlaceLng = fromPlaceLng;
    }

    public void removeFromPlace() {
        this.fromPlaceName = null;
        this.fromPlaceLat = null;
        this.fromPlaceLng = null;
    }

    public List<Schedule> createSchedules(@NotNull LocalDate from, @NotNull LocalDate to) {
        if (repeatStartDate.isAfter(from)) {
            from = repeatStartDate;
        }
        if (repeatEndDate != null && repeatEndDate.isBefore(to)) {
            to = repeatEndDate;
        }
        if (from.isAfter(to)) {
            return List.of();
        }

        Period scheduleDuration = Period.between(startDate, endDate);

        List<LocalDate> scheduleDates = getScheduleStartDates(from, to);
        return scheduleDates.stream()
                .map(scheduleDate -> createScheduleWith(scheduleDate, scheduleDuration))
                .toList();
    }

    private List<LocalDate> getScheduleStartDates(LocalDate from, LocalDate to) {
        return switch (repeatCycle) {
            case DAILY -> getDailyRepeatDates(from, to);
            case WEEKLY -> getWeeklyRepeatDates(from, to);
            case MONTHLY -> getMonthlyRepeatDates(from, to);
            case YEARLY -> getYearlyRepeatDates(from, to);
        };
    }

    private List<LocalDate> getDailyRepeatDates(LocalDate from, LocalDate to) {
        List<LocalDate> dates = new ArrayList<>();
        LocalDate curDate = repeatStartDate;
        while (curDate.isBefore(to) || curDate.isEqual(to)) {
            if (curDate.isAfter(from) || curDate.isEqual(from)) {
                dates.add(curDate);
            }
            curDate = curDate.plusDays(repeatAt);
        }
        return dates;
    }

    private List<LocalDate> getWeeklyRepeatDates(LocalDate from, LocalDate to) {
        return from.datesUntil(to.plusDays(1))
                .filter(this::isWeeklyRepeatDate)
                .toList();
    }

    private boolean isWeeklyRepeatDate(LocalDate date) {
        DayOfWeek dayOfWeek = date.getDayOfWeek();
        int value = dayOfWeek.getValue();
        return (repeatAt & (1 << value)) != 0;
    }

    private List<LocalDate> getMonthlyRepeatDates(LocalDate from, LocalDate to) {
        int dayOfMonth = repeatAt;
        return from.datesUntil(to.plusDays(1))
                .filter(date -> date.getDayOfMonth() == dayOfMonth)
                .toList();
    }

    private List<LocalDate> getYearlyRepeatDates(LocalDate from, LocalDate to) {
        int monthValue = repeatAt / 100;
        int dayOfMonth = repeatAt % 100;
        return from.datesUntil(to.plusDays(1))
                .filter(date -> date.getMonthValue() == monthValue && date.getDayOfMonth() == dayOfMonth)
                .toList();
    }

    private Schedule createScheduleWith(LocalDate startDate, Period duration) {
        LocalDate endDate = startDate.plus(duration);
        return createScheduleWith(startDate, endDate);
    }

    private Schedule createScheduleWith(LocalDate startDate, LocalDate endDate) {
        return Schedule.builder()
                .member(member)
                .category(category)
                .routine(this)
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
                .isDone(false)
                .build();
    }

    public static int weeklyRepeatAtOf(DayOfWeek... dayOfWeeks) {
        if (dayOfWeeks.length == 0) {
            throw new IllegalArgumentException("dayOfWeek is empty");
        }
        int repeatAt = 0;
        for (DayOfWeek dayOfWeek : dayOfWeeks) {
            repeatAt |= 1 << dayOfWeek.getValue();
        }
        return repeatAt;
    }
}
