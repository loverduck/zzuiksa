package com.zzuiksa.server.domain.member.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzuiksa.server.domain.member.data.request.UpdateMemberRequest;
import com.zzuiksa.server.domain.member.data.response.GetMemberResponse;
import com.zzuiksa.server.domain.member.data.response.UpdateMemberResponse;
import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.member.repository.MemberRepository;

import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;

    @Transactional(readOnly = true)
    public GetMemberResponse get(@NotNull Member member) {
        return GetMemberResponse.from(member);
    }

    @Transactional
    public UpdateMemberResponse update(@NotNull UpdateMemberRequest updateMemberRequest, @NotNull Member member) {
        member = updateMemberRequest.update(member);
        member = memberRepository.save(member);
        return UpdateMemberResponse.from(member);
    }

    @Transactional
    public long delete(@NotNull Member member) {
        member.delete();
        member = memberRepository.save(member);
        return member.getId();
    }
}
