package com.zzuiksa.server.domain.member.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.util.StringUtils;

import com.zzuiksa.server.global.entity.BaseEntity;
import com.zzuiksa.server.global.exception.InvalidMemberNameException;
import com.zzuiksa.server.global.oauth.data.OauthUserDto;
import com.zzuiksa.server.global.util.Utils;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Member extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 20, nullable = false)
    private String name;

    @Column(length = 100)
    private String kakaoId;

    private LocalDate birthday;

    private String profileImage;

    public void setName(String name) {
        if (!StringUtils.hasText(name)) {
            throw new InvalidMemberNameException("닉네임은 비어있을 수 없습니다.");
        }
        if (!Utils.isBetween(name.length(), 1, 10)) {
            throw new InvalidMemberNameException("닉네임은 1 ~ 10글자 사이여야 합니다.");
        }
        if (name.startsWith(" ") || name.endsWith(" ")) {
            throw new InvalidMemberNameException("닉네임의 시작과 끝은 공백일 수 없습니다.");
        }
        if (name.contains("  ")) {
            throw new InvalidMemberNameException("닉네임에는 연속된 공백이 포함될 수 없습니다");
        }
        if (!name.matches("^[a-zA-Z0-9ㄱ-ㅣ가-힣 ]+$")) {
            throw new InvalidMemberNameException("닉네임에는 영문 대소문자, 숫자, 한글, 공백만 포함할 수 있습니다.");
        }
        this.name = name;
    }

    public void setBirthday(LocalDate birthday) {
        if (birthday.isAfter(LocalDate.now())) {
            throw new IllegalArgumentException("유효하지 않은 날짜입니다.");
        }
        this.birthday = birthday;
    }

    public Member(String name, String kakaoId, LocalDate birthday, String profileImage) {
        this.name = name;
        this.kakaoId = kakaoId;
        this.birthday = birthday;
        this.profileImage = profileImage;
    }

    public void setKakaoAccount(OauthUserDto oauthUserDto) {
        this.kakaoId = String.valueOf(oauthUserDto.getId());

        if (!StringUtils.hasText(this.profileImage)) {
            this.profileImage = oauthUserDto.getProfileImageUrl();
        }

        // TODO: 생일 정보 받아올건지?
    }

    public void delete() {
        this.deletedAt = LocalDateTime.now();
    }
}
