package com.zzuiksa.server.domain.auth.data;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import com.zzuiksa.server.domain.member.entity.Member;

import lombok.Getter;

@Getter
public class MemberDetail extends User {

	public MemberDetail(Member member) {
		super(String.valueOf(member.getId()), String.valueOf(member.getId()),
			AuthorityUtils.createAuthorityList("USER"));
	}
}
