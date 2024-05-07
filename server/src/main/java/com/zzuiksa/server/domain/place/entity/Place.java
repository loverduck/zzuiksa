package com.zzuiksa.server.domain.place.entity;

import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.global.entity.BaseEntity;
import com.zzuiksa.server.global.util.Utils;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
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
public class Place extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "member_id", nullable = false)
    private Member member;

    @NotBlank
    @Column(length = 100, nullable = false)
    private String name;

    @NotNull
    @Column(nullable = false)
    private Float lat;

    @NotNull
    @Column(nullable = false)
    private Float lng;

    public void setName(String name) {
        if (!Utils.hasTextAndLengthBetween(name, 1, 100)) {
            throw new IllegalArgumentException("name은 비어있지 않고 길이가 1 이상 100 이하여야 합니다.");
        }
        this.name = name;
    }

    public void setLatLng(@NotNull Float lat, @NotNull Float lng) {
        this.lat = lat;
        this.lng = lng;
    }
}
