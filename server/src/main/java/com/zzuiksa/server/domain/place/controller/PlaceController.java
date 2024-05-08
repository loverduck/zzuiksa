package com.zzuiksa.server.domain.place.controller;

import java.util.List;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;

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

@Tag(name = "Place", description = "장소 API")
@RestController
@RequestMapping("/api/places")
@RequiredArgsConstructor
public class PlaceController {

    private final PlaceService placeService;

    @Operation(
            summary = "사용자 장소 추가",
            description = "사용자 장소를 추가합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @PostMapping
    public AddPlaceResponse add(@Valid @RequestBody AddPlaceRequest request,
            @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return placeService.add(request, member);
    }

    @Operation(
            summary = "사용자 장소 조회",
            description = "장소 Id를 통해 사용자 장소를 조회합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @GetMapping("/{placeId}")
    public GetPlaceResponse get(@PathVariable Long placeId, @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return placeService.get(placeId, member);
    }

    @Operation(
            summary = "사용자 장소 리스트 조회",
            description = "내가 등록한 사용자 장소 리스트를 조회합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @GetMapping
    public List<MemberPlaceDto> getList(@AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return placeService.getList(member);
    }

    @Operation(
            summary = "사용자 장소 수정",
            description = "사용자 장소를 수정합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @PatchMapping("/{placeId}")
    public UpdatePlaceResponse update(@PathVariable Long placeId, @Valid @RequestBody UpdatePlaceRequest request,
            @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return placeService.update(placeId, request, member);
    }

    @Operation(
            summary = "사용자 장소 삭제",
            description = "사용자 장소를 삭제합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @DeleteMapping("/{placeId}")
    public DeletePlaceResponse delete(@PathVariable Long placeId, @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return placeService.delete(placeId, member);
    }
}
