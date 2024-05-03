package com.zzuiksa.server.domain.member;

import com.zzuiksa.server.domain.member.data.response.GetMemberResponse;
import com.zzuiksa.server.domain.member.entity.Member;

import java.time.LocalDate;

public class MemberSource {

    private static final Long id = 1L;

    private static final String name = "달리는 햄스터";

    private static final String kakaoId = "123456789";

    private static final LocalDate birthday = LocalDate.of(2000, 1, 1);

    private static final String profileImage = null;

    public static Member.MemberBuilder getTestMemberBuilder() {
        return Member.builder()
                .id(id)
                .name(name)
                .kakaoId(kakaoId)
                .birthday(birthday)
                .profileImage(profileImage);
    }

    public static GetMemberResponse.GetMemberResponseBuilder getTestGetMemberResponseBuilder() {
        return GetMemberResponse.builder()
                .id(id)
                .name(name)
                .birthday(birthday)
                .profileImage(profileImage);
    }
}
