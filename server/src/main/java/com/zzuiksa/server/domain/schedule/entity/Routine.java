package com.zzuiksa.server.domain.schedule.entity;

import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.schedule.constant.RoutineCycle;
import com.zzuiksa.server.global.entity.BaseEntity;
import com.zzuiksa.server.global.util.Utils;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.time.DayOfWeek;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Getter
@NoArgsConstructor
@ToString
@EqualsAndHashCode(callSuper = true)
public class Routine extends BaseEntity {

    @NotNull
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
    @Column(nullable = false)
    private Integer repeatAt;

    @Builder
    Routine(Long id, Member member, Category category, String title, LocalDate startDate, LocalDate endDate, LocalTime startTime, LocalTime endTime, Duration alertBefore, String memo, String toPlaceName, Float toPlaceLat, Float toPlaceLng, String fromPlaceName, Float fromPlaceLat, Float fromPlaceLng, RoutineCycle repeatCycle, LocalDate repeatStartDate, LocalDate repeatEndDate, Integer repeatAt) {
        this.id = id;
        if (member == null) {
            throw new IllegalArgumentException("Member is null");
        }
        this.member = member;
        this.category = category;
        setTitle(title);
        setStartDate(startDate);
        setEndDate(endDate);
        setTime(startTime, endTime);
        setAlertBefore(alertBefore);
        setMemo(memo);
        if (toPlaceLat != null && toPlaceLng != null) {
            setToPlace(toPlaceName, toPlaceLat, toPlaceLng);
        } else {
            setToPlace(toPlaceName);
        }
        if (fromPlaceLat != null && fromPlaceLng != null) {
            setFromPlace(fromPlaceName, fromPlaceLat, fromPlaceLng);
        } else {
            setFromPlace(fromPlaceName);
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
        if (alertBefore == null) {
            throw new IllegalArgumentException("alertBefore is null");
        }
        if (alertBefore.compareTo(Duration.ofMinutes(1)) < 0) {
            throw new IllegalArgumentException("alertBefore is negative");
        }
        ;
        if (alertBefore.compareTo(Duration.ofDays(7)) > 0) {
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

    public void setRepeat(RoutineCycle cycle, LocalDate startDate, LocalDate endDate, int repeatTerm, int repeatAt) {
        // TODO: Routine 관련 필드 setter 추가
        throw new UnsupportedOperationException();
    }

    public static int getWeeklyRepeatAtOf(DayOfWeek ...days) {
        int repeatAt = 0;
        for (DayOfWeek day : days) {
            repeatAt |= 1 << day.getValue();
        }
        return repeatAt;
    }
}
