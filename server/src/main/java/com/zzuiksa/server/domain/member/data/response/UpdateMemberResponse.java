package com.zzuiksa.server.domain.member.data.response;

import java.time.LocalDate;

import com.zzuiksa.server.domain.member.entity.Member;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@EqualsAndHashCode
public class UpdateMemberResponse {

    @Schema(description = "사용자 ID")
    @NotNull
    private Long id;

    @Schema(description = "이름")
    @NotNull
    private String name;

    @Schema(description = "프로필 이미지 주소")
    private String profileImage;

    @Schema(description = "생년월일")
    private LocalDate birthday;

    public static UpdateMemberResponse from(Member member) {
        return UpdateMemberResponse.builder()
                .id(member.getId())
                .name(member.getName())
                .profileImage(member.getProfileImage())
                .birthday(member.getBirthday())
                .build();
    }
}
