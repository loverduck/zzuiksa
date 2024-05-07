package com.zzuiksa.server.domain.place.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.place.data.MemberPlaceDto;
import com.zzuiksa.server.domain.place.data.request.AddPlaceRequest;
import com.zzuiksa.server.domain.place.data.request.UpdatePlaceRequest;
import com.zzuiksa.server.domain.place.data.response.AddPlaceResponse;
import com.zzuiksa.server.domain.place.data.response.DeletePlaceResponse;
import com.zzuiksa.server.domain.place.data.response.GetPlaceResponse;
import com.zzuiksa.server.domain.place.data.response.UpdatePlaceResponse;
import com.zzuiksa.server.domain.place.entity.Place;
import com.zzuiksa.server.domain.place.repository.PlaceRepository;
import com.zzuiksa.server.global.exception.custom.CustomException;
import com.zzuiksa.server.global.exception.custom.ErrorCodes;

import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PlaceService {

    private final PlaceRepository placeRepository;

    @Transactional
    public AddPlaceResponse add(@NotNull AddPlaceRequest request, @NotNull Member member) {
        Place place = convertAddPlaceRequestToPlace(request, member);
        place = placeRepository.save(place);
        return AddPlaceResponse.from(place);
    }

    @Transactional(readOnly = true)
    public GetPlaceResponse get(@NotNull Long id, @NotNull Member member) {
        Place place = placeRepository.findById(id)
                .orElseThrow(() -> new CustomException(ErrorCodes.PLACE_NOT_FOUND));
        if (!place.getMember().getId().equals(member.getId())) {
            throw new CustomException(ErrorCodes.MEMBER_NOT_FOUND);
        }
        return GetPlaceResponse.from(place);
    }

    @Transactional(readOnly = true)
    public List<MemberPlaceDto> getList(@NotNull Member member) {
        return placeRepository.findAllByMember(member).stream().map(MemberPlaceDto::from).toList();
    }

    @Transactional
    public UpdatePlaceResponse update(@NotNull Long id, @NotNull UpdatePlaceRequest request, @NotNull Member member) {
        Place place = placeRepository.findById(id)
                .orElseThrow(() -> new CustomException(ErrorCodes.PLACE_NOT_FOUND));
        if (!place.getMember().getId().equals(member.getId())) {
            throw new CustomException(ErrorCodes.MEMBER_NOT_FOUND);
        }
        place = request.update(place);
        place = placeRepository.save(place);
        return UpdatePlaceResponse.from(place);
    }

    @Transactional
    public DeletePlaceResponse delete(@NotNull Long id, @NotNull Member member) {
        Place place = placeRepository.findById(id)
                .orElseThrow(() -> new CustomException(ErrorCodes.PLACE_NOT_FOUND));
        if (!place.getMember().getId().equals(member.getId())) {
            throw new CustomException(ErrorCodes.MEMBER_NOT_FOUND);
        }
        placeRepository.delete(place);
        return new DeletePlaceResponse();
    }

    protected Place convertAddPlaceRequestToPlace(AddPlaceRequest request, Member member) {
        return Place.builder()
                .name(request.getName())
                .member(member)
                .lat(request.getLat())
                .lng(request.getLng())
                .build();
    }
}
