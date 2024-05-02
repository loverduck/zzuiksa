package com.zzuiksa.server.domain.auth.data;

import com.zzuiksa.server.domain.member.entity.Member;
import lombok.Getter;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.util.StringUtils;

@Getter
public class MemberDetail extends User {
    public MemberDetail(Member member) {
        super(String.valueOf(member.getId()), String.valueOf(member.getId()),
                AuthorityUtils.createAuthorityList(getAuthority(member)));
    }

    private static String getAuthority(Member member) {
        String authority = "GUEST";
        if (StringUtils.hasText(member.getKakaoId())) authority = "USER";
        return authority;
    }
}
