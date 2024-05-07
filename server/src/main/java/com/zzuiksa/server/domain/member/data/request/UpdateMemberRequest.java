package com.zzuiksa.server.domain.member.data.request;

import java.time.LocalDate;

import org.springframework.util.StringUtils;

import com.zzuiksa.server.domain.member.entity.Member;

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
public class UpdateMemberRequest {

    private String name;

    private LocalDate birthday;

    public Member update(Member member) {
        if (StringUtils.hasText(name)) {
            member.setName(name);
        }
        if (birthday != null) {
            member.setBirthday(birthday);
        }
        return member;
    }
}
