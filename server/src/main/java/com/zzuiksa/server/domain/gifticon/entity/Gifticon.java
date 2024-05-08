package com.zzuiksa.server.domain.gifticon.entity;

import com.zzuiksa.server.domain.gifticon.constant.IsUsed;
import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.global.entity.BaseEntity;
import com.zzuiksa.server.global.util.Utils;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.LocalDate;

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

    @NotBlank
    @Column(length = 100, nullable = false)
    private String name;

    @Column(length = 100)
    private String store;

    @NotBlank
    @Column(length = 20, nullable = false)
    private String couponNum;

    @NotNull
    @Column(nullable = false)
    private LocalDate endDate;

    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private IsUsed isUsed;

    @Column
    private Integer remainMoney;

    @Size(max = 1000)
    @Column(length = 1000)
    private String memo;

    public void setName(String name) {
        if (!Utils.hasTextAndLengthBetween(name, 1, 100)) {
            throw new IllegalArgumentException("기프티콘 명은 비어있지 않고 길이가 1 이상 100 이하여야 합니다.");
        }
        this.name = name;
    }
}
