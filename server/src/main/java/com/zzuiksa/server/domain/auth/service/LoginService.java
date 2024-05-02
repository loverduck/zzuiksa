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
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class LoginService {

    private final KakaoLoginApiService kakaoLoginApiService;
    private final MemberRepository memberRepository;
    private final TokenProvider tokenProvider;

    @Transactional
    public LoginResponse kakaoLogin(String accessToken) {
        OauthUserDto oauthUserDto = kakaoLoginApiService.getUserInfo(accessToken);
        Member member = getKakaoMember(oauthUserDto).orElseGet(() -> memberRepository.save(oauthUserDto.toEntity()));
        return getAccessToken(member.getId());
    }

    @Transactional
    public LoginResponse guestLogin() {
        // TODO: 닉네임 랜덤 생성
        String randomName = "랜덤";
        Member guestMember = Member.builder()
                .name(randomName)
                .build();
        Member newMember = memberRepository.save(guestMember);
        return getAccessToken(newMember.getId());
    }

    @Transactional
    public LoginResponse connectKakaoAccount(String accessToken, Member member) {
        OauthUserDto oauthUserDto = kakaoLoginApiService.getUserInfo(accessToken);
        member.setKakaoAccount(oauthUserDto);
        Member newMember = memberRepository.save(member);
        return getAccessToken(newMember.getId());
    }

    public LoginResponse getAccessToken(long id) {
        Jwt token = tokenProvider.generateToken(id);
        return LoginResponse.builder()
                .accessToken(token.getToken())
                .expiresIn(token.getExpiresIn())
                .build();
    }

    private Optional<Member> getKakaoMember(OauthUserDto oauthUserDto) {
        String kakaoId = String.valueOf(oauthUserDto.getId());
        return memberRepository.findByKakaoId(kakaoId);
    }
}
