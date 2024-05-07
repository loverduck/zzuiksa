package com.zzuiksa.server.domain.place.controller;

import java.util.List;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zzuiksa.server.domain.auth.data.MemberDetail;
import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.place.data.MemberPlaceDto;
import com.zzuiksa.server.domain.place.data.request.AddPlaceRequest;
import com.zzuiksa.server.domain.place.data.request.UpdatePlaceRequest;
import com.zzuiksa.server.domain.place.data.response.AddPlaceResponse;
import com.zzuiksa.server.domain.place.data.response.DeletePlaceResponse;
import com.zzuiksa.server.domain.place.data.response.GetPlaceResponse;
import com.zzuiksa.server.domain.place.data.response.UpdatePlaceResponse;
import com.zzuiksa.server.domain.place.service.PlaceService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/api/places")
@RequiredArgsConstructor
public class PlaceController {

    private final PlaceService placeService;

    @PostMapping
    public AddPlaceResponse add(@Valid @RequestBody AddPlaceRequest request,
            @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return placeService.add(request, member);
    }

    @GetMapping("/{placeId}")
    public GetPlaceResponse get(@PathVariable Long placeId, @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return placeService.get(placeId, member);
    }

    @GetMapping
    public List<MemberPlaceDto> getList(@AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return placeService.getList(member);
    }

    @PatchMapping("/{placeId}")
    public UpdatePlaceResponse update(@PathVariable Long placeId, @Valid @RequestBody UpdatePlaceRequest request,
            @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return placeService.update(placeId, request, member);
    }

    @DeleteMapping("/{placeId}")
    public DeletePlaceResponse delete(@PathVariable Long placeId, @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return placeService.delete(placeId, member);
    }
}
