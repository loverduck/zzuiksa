package com.zzuiksa.server.domain.member.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.zzuiksa.server.domain.auth.data.MemberDetail;
import com.zzuiksa.server.domain.member.data.request.UpdateMemberRequest;
import com.zzuiksa.server.domain.member.data.response.GetMemberResponse;
import com.zzuiksa.server.domain.member.data.response.UpdateMemberResponse;
import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.member.service.MemberService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/members")
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    @GetMapping
    public GetMemberResponse getMember(@AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return memberService.get(member);
    }

    @PatchMapping
    public UpdateMemberResponse updateMember(@RequestBody UpdateMemberRequest updateMemberRequest,
            @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return memberService.update(updateMemberRequest, member);
    }
}
