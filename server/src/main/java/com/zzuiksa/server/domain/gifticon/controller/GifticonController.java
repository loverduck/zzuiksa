package com.zzuiksa.server.domain.gifticon.controller;

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

import com.zzuiksa.server.domain.place.data.response.UpdatePlaceResponse;

import jakarta.validation.Valid;

import lombok.RequiredArgsConstructor;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/gifticons")
@RequiredArgsConstructor
public class GifticonController {

    private final GifticonService gifticonService;

    @PostMapping
    public AddGifticonResponse add(@Valid @RequestBody AddGifticonRequest request,
            @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return gifticonService.add(request, member);
    }

    @GetMapping("/{gifticonId}")
    public GetGifticonResponse get(@PathVariable Long gifticonId, @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return gifticonService.get(gifticonId, member);
    }

    @GetMapping
    public List<GifticonPreviewDto> getList(@AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return gifticonService.getList(member);
    }

    @PatchMapping("/{gifticonId}")
    public UpdateGifticonResponse update(@PathVariable Long gifticonId, @Valid @RequestBody UpdateGifticonRequest request,
            @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return gifticonService.update(gifticonId, request, member);
    }

    @DeleteMapping("/{gifticonId}")
    public DeleteGifticonResponse delete(@PathVariable Long gifticonId, @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return gifticonService.delete(gifticonId, member);
    }
    
    //@GetMapping("/nearby") 사용처 목록 불러오기
}
