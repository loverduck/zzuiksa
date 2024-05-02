package com.zzuiksa.server.domain.auth.service;

import com.zzuiksa.server.domain.auth.data.response.LoginResponse;
import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.member.repository.MemberRepository;
import com.zzuiksa.server.global.oauth.data.OauthUserDto;
import com.zzuiksa.server.global.oauth.service.KakaoLoginApiService;
import com.zzuiksa.server.global.token.TokenProvider;
import com.zzuiksa.server.global.token.data.Jwt;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class LoginService {

    private final KakaoLoginApiService kakaoLoginApiService;
    private final MemberRepository memberRepository;
    private final TokenProvider tokenProvider;

    public LoginResponse oauthLogin(String accessToken) {
        OauthUserDto oauthUserDto = kakaoLoginApiService.getUserInfo(accessToken);
        String kakaoId = String.valueOf(oauthUserDto.getId());
        Optional<Member> member = memberRepository.findByKakaoId(kakaoId);
        Member oauthMember = member.orElseGet(() -> memberRepository.save(oauthUserDto.toEntity()));

        return getAccessToken(oauthMember.getId());
    }

    public LoginResponse guestLogin() {
        // TODO: 닉네임 랜덤 생성
        String randomName = "랜덤";
        Member guestMember = Member.builder()
                .name(randomName)
                .build();
        Member newMember = memberRepository.save(guestMember);
        return getAccessToken(newMember.getId());
    }

    private LoginResponse getAccessToken(long id) {
        Jwt token = tokenProvider.generateToken(id);
        return LoginResponse.builder()
                .accessToken(token.getToken())
                .expiresIn(token.getExpiresIn())
                .build();
    }
}
