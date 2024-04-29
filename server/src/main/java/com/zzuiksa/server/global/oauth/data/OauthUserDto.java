package com.zzuiksa.server.global.oauth.data;

import com.zzuiksa.server.domain.member.entity.Member;

import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;

@Getter
@Builder
@ToString
@EqualsAndHashCode
public class OauthUserDto {

	private long id;
	private String name;
	private String email;
	private String nickname;
	private String profileImageUrl;

	public Member toEntity() {
		return Member.builder()
			.kakaoId(String.valueOf(id))
			.profileImage(profileImageUrl)
			.name(nickname)
			.build();
	}
}
