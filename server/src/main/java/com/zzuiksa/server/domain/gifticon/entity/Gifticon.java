package com.zzuiksa.server.domain.gifticon.entity;

import java.time.LocalDate;

import com.zzuiksa.server.domain.gifticon.constant.IsUsed;
import com.zzuiksa.server.domain.member.entity.Member;
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
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@EqualsAndHashCode(callSuper = false)
public class Gifticon extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "member_id", nullable = false)
    private Member member;

    @NotBlank
    @Column(nullable = false)
    private String url;

    @Column(length = 100)
    private String name;

    @Column(length = 100)
    private String store;

    @NotBlank
    @Column(length = 48, nullable = false)
    private String couponNum;

    @Column
    private LocalDate endDate;

    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private IsUsed isUsed;

    @Column
    private Integer remainMoney; //remainMoney가 null이 아니면 금액권으로 판단

    @Size(max = 1000)
    @Column(length = 1000)
    private String memo;

    public void setName(String name) {
        if (name != null && name.length() > 100) {
            throw new IllegalArgumentException("기프티콘 명은 100 이하여야 합니다.");
        }
        this.name = name;
    }

    public void setStore(String store) {
        if (name != null && store.length() > 100) {
            throw new IllegalArgumentException("브랜드명은 100자를 넘길 수 없습니다.");
        }
        this.store = store;
    }

    public void setCouponNum(String couponNum) {
        if (!Utils.hasTextAndLengthBetween(couponNum, 1, 48)) {
            throw new IllegalArgumentException("바코드 번호를 다시 확인하세요.");
        }
        this.couponNum = couponNum;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public void setIsUsed(IsUsed isUsed) {
        this.isUsed = isUsed;
    }

    public void setRemainMoney(Integer remainMoney) {
        if (remainMoney != null && remainMoney < 0) {
            throw new IllegalArgumentException("금액권의 남은 모든 금액을 사용하였습니다.");
        }
        this.remainMoney = remainMoney;
    }

    public void setMemo(String memo) {
        if (name != null && store.length() > 1000) {
            throw new IllegalArgumentException("메모는 1,000자를 넘길 수 없습니다.");
        }
        this.memo = memo;
    }
}
