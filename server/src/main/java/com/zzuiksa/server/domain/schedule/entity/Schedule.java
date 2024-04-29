package com.zzuiksa.server.domain.schedule.entity;

import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.global.entity.BaseEntity;
import com.zzuiksa.server.global.util.Utils;
import jakarta.persistence.*;
import lombok.*;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@EqualsAndHashCode(callSuper = true)
public class Schedule extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "member_id", nullable = false)
    private Member member;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;

    @ManyToOne
    @JoinColumn(name = "routine_id")
    private Routine routine;

    @Column(length = 100, nullable = false)
    private String title;

    @Column(nullable = false)
    private LocalDate startDate;

    private LocalDate endDate;

    private LocalTime startTime;

    private LocalTime endTime;

    private Duration alertBefore;

    @Column(length = 1000, nullable = false)
    private String memo;

    @Column(name = "to_place", length = 100)
    private String toPlaceName;

    @Column(name = "to_lat")
    private Float toPlaceLat;

    @Column(name = "to_lng")
    private Float toPlaceLng;

    @Column(name = "from_place", length = 100)
    private String fromPlaceName;

    @Column(name = "from_lat")
    private Float fromPlaceLat;

    @Column(name = "from_lng")
    private Float fromPlaceLng;

    @Column(nullable = false)
    @Setter
    private boolean isDone;

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
}
