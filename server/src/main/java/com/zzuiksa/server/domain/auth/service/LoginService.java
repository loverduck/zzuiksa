package com.zzuiksa.server.domain.auth.service;

import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.zzuiksa.server.domain.auth.data.response.LoginResponse;
import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.member.repository.MemberRepository;
import com.zzuiksa.server.global.exception.custom.CustomException;
import com.zzuiksa.server.global.exception.custom.ErrorCodes;
import com.zzuiksa.server.global.oauth.data.OauthUserDto;
import com.zzuiksa.server.global.oauth.service.KakaoLoginApiService;
import com.zzuiksa.server.global.token.TokenProvider;
import com.zzuiksa.server.global.token.data.Jwt;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LoginService {

    private final KakaoLoginApiService kakaoLoginApiService;
    private final MemberRepository memberRepository;
    private final TokenProvider tokenProvider;

    @Transactional
    public LoginResponse kakaoLogin(String accessToken) {
        OauthUserDto oauthUserDto = kakaoLoginApiService.getUserInfo(accessToken);
        Member member = findKakaoMember(oauthUserDto).orElseGet(() -> memberRepository.save(oauthUserDto.toEntity()));
        return generateAccessToken(member.getId());
    }

    @Transactional
    public LoginResponse guestLogin() {
        // TODO: 닉네임 랜덤 생성
        String randomName = "랜덤";
        Member guestMember = Member.builder()
                .name(randomName)
                .build();
        Member newMember = memberRepository.save(guestMember);
        return generateAccessToken(newMember.getId());
    }

    @Transactional
    public LoginResponse connectKakaoAccount(String accessToken, Member member) {
        OauthUserDto oauthUserDto = kakaoLoginApiService.getUserInfo(accessToken);
        if (StringUtils.hasText(member.getKakaoId())) {
            throw new CustomException(ErrorCodes.KAKAO_MEMBER_ALREADY_CONNECTED);
        }
        if (findKakaoMember(oauthUserDto).isPresent()) {
            throw new CustomException(ErrorCodes.KAKAO_MEMBER_ALREADY_EXIST);
        }
        member.setKakaoAccount(oauthUserDto);
        Member newMember = memberRepository.save(member);
        return generateAccessToken(newMember.getId());
    }

    public LoginResponse generateAccessToken(long id) {
        Jwt token = tokenProvider.generateToken(id);
        return LoginResponse.builder()
                .accessToken(token.getToken())
                .expiresIn(token.getExpiresIn())
                .build();
    }

    private Optional<Member> findKakaoMember(OauthUserDto oauthUserDto) {
        String kakaoId = String.valueOf(oauthUserDto.getId());
        return memberRepository.findByKakaoId(kakaoId);
    }
}
