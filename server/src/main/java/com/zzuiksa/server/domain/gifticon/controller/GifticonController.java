package com.zzuiksa.server.domain.gifticon.controller;

import java.util.List;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.zzuiksa.server.domain.auth.data.MemberDetail;
import com.zzuiksa.server.domain.gifticon.data.request.AddGifticonRequest;
import com.zzuiksa.server.domain.gifticon.data.request.UpdateGifticonRequest;
import com.zzuiksa.server.domain.gifticon.data.response.AddGifticonResponse;
import com.zzuiksa.server.domain.gifticon.data.response.DeleteGifticonResponse;
import com.zzuiksa.server.domain.gifticon.data.response.GetGifticonResponse;
import com.zzuiksa.server.domain.gifticon.data.response.GifticonPreviewDto;
import com.zzuiksa.server.domain.gifticon.data.response.UpdateGifticonResponse;
import com.zzuiksa.server.domain.gifticon.service.GifticonService;
import com.zzuiksa.server.domain.member.entity.Member;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@Tag(name = "Gifticon", description = "기프티콘 API")
@RestController
@RequestMapping("/api/gifticons")
@RequiredArgsConstructor
public class GifticonController {

    private final GifticonService gifticonService;

    @Operation(
            summary = "기프티콘 추가",
            description = "새로운 기프티콘을 등록합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @PostMapping
    public AddGifticonResponse add(@Valid @RequestBody AddGifticonRequest request,
            @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return gifticonService.add(request, member);
    }

    @Operation(
            summary = "기프티콘 상세 조회",
            description = "기프티콘 상세 정보를 조회합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @GetMapping("/{gifticonId}")
    public GetGifticonResponse get(@PathVariable Long gifticonId, @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return gifticonService.get(gifticonId, member);
    }

    @Operation(
            summary = "기프티콘 목록 조회",
            description = "기프티콘 목록을 조회합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @GetMapping
    public List<GifticonPreviewDto> getList(@AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return gifticonService.getList(member);
    }

    @Operation(
            summary = "기프티콘 정보 수정",
            description = "기프티콘의 상세 정보를 수정합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @PatchMapping("/{gifticonId}")
    public UpdateGifticonResponse update(@PathVariable Long gifticonId,
            @Valid @RequestBody UpdateGifticonRequest request,
            @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return gifticonService.update(gifticonId, request, member);
    }

    @Operation(
            summary = "기프티콘 삭제",
            description = "기프티콘 정보를 삭제합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @DeleteMapping("/{gifticonId}")
    public DeleteGifticonResponse delete(@PathVariable Long gifticonId,
            @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return gifticonService.delete(gifticonId, member);
    }

    //@GetMapping("/nearby") 사용처 목록 불러오기
}
