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
public class GetMemberResponse {

    @NotNull
    private Long id;

    @NotNull
    private String name;

    private String profileImage;

    private LocalDate birthday;

    public static GetMemberResponse from(Member member) {
        return GetMemberResponse.builder()
                .id(member.getId())
                .name(member.getName())
                .birthday(member.getBirthday())
                .profileImage(member.getProfileImage())
                .build();
    }
}
