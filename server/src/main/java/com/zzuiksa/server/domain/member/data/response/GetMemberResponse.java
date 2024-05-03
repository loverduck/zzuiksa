package com.zzuiksa.server.domain.member.data.response;

import com.zzuiksa.server.domain.member.entity.Member;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDate;

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
