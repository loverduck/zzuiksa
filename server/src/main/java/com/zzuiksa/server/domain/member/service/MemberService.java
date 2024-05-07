package com.zzuiksa.server.domain.member.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzuiksa.server.domain.member.data.request.UpdateMemberRequest;
import com.zzuiksa.server.domain.member.data.response.GetMemberResponse;
import com.zzuiksa.server.domain.member.data.response.UpdateMemberResponse;
import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.member.repository.MemberRepository;
import com.zzuiksa.server.global.exception.custom.CustomException;
import com.zzuiksa.server.global.exception.custom.ErrorCodes;

import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;

    @Transactional(readOnly = true)
    public GetMemberResponse get(@NotNull Long id) {
        Member member = memberRepository.findById(id)
                .orElseThrow(() -> new CustomException(ErrorCodes.MEMBER_NOT_FOUND));
        return GetMemberResponse.from(member);
    }

    @Transactional
    public UpdateMemberResponse update(UpdateMemberRequest updateMemberRequest, @NotNull Long id) {
        Member member = memberRepository.findById(id)
                .orElseThrow(() -> new CustomException(ErrorCodes.MEMBER_NOT_FOUND));
        Member updateMember = updateMemberRequest.update(member);
        return UpdateMemberResponse.from(updateMember);
    }

}
