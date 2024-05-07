package com.zzuiksa.server.domain.member.data.response;

import java.time.LocalDate;

import com.zzuiksa.server.domain.member.entity.Member;

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

    @NotNull
    private Long id;

    @NotNull
    private String name;

    private String profileImage;

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
