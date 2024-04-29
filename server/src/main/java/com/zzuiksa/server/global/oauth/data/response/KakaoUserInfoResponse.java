package com.zzuiksa.server.global.oauth.data.response;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;

@Getter
public class KakaoUserInfoResponse {

	private long id;

	@JsonProperty("kakao_account")
	private KakaoAccount kakaoAccount;

	@Getter
	public static class KakaoAccount {

		private Profile profile;
		private String name;
		private String email;

		@Getter
		public static class Profile {

			private String nickname;

			@JsonProperty("profile_image_url")
			private String profileImageUrl;
		}
	}

}
