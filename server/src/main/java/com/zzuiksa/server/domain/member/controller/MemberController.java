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
import com.zzuiksa.server.domain.member.service.MemberService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Tag(name = "Member", description = "회원 API")
@RestController
@RequestMapping("/api/members")
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    @Operation(
            summary = "내 정보 조회",
            description = "내 정보를 조회합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @GetMapping
    public GetMemberResponse getMember(@AuthenticationPrincipal MemberDetail memberDetail) {
        return memberService.get(memberDetail.getMember().getId());
    }

    @Operation(
            summary = "내 정보 수정",
            description = "내 정보를 수정합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @PatchMapping
    public UpdateMemberResponse updateMember(@RequestBody UpdateMemberRequest updateMemberRequest,
            @AuthenticationPrincipal MemberDetail memberDetail) {
        return memberService.update(updateMemberRequest, memberDetail.getMember().getId());
    }
}
