package com.zzuiksa.server.domain.auth.data;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.util.StringUtils;

import com.zzuiksa.server.domain.member.entity.Member;

import lombok.Getter;

@Getter
public class MemberDetail extends User {

    private final Member member;

    public MemberDetail(Member member) {
        super(String.valueOf(member.getId()), String.valueOf(member.getId()),
                AuthorityUtils.createAuthorityList(getAuthority(member)));
        this.member = member;
    }

    private static String getAuthority(Member member) {
        String authority = "GUEST";
        if (StringUtils.hasText(member.getKakaoId()))
            authority = "USER";
        return authority;
    }
}
