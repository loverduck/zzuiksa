package com.zzuiksa.server.domain.gifticon.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzuiksa.server.domain.gifticon.data.request.AddGifticonRequest;
import com.zzuiksa.server.domain.gifticon.data.request.UpdateGifticonRequest;
import com.zzuiksa.server.domain.gifticon.data.response.AddGifticonResponse;
import com.zzuiksa.server.domain.gifticon.data.response.DeleteGifticonResponse;
import com.zzuiksa.server.domain.gifticon.data.response.GetGifticonResponse;
import com.zzuiksa.server.domain.gifticon.data.response.GifticonPreviewDto;
import com.zzuiksa.server.domain.gifticon.data.response.UpdateGifticonResponse;
import com.zzuiksa.server.domain.gifticon.entity.Gifticon;
import com.zzuiksa.server.domain.gifticon.repository.GifticonRepository;
import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.global.exception.custom.CustomException;
import com.zzuiksa.server.global.exception.custom.ErrorCodes;

import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class GifticonService {

    private final GifticonRepository gifticonRepository;

    @Transactional
    public AddGifticonResponse add(@NotNull AddGifticonRequest request, @NotNull Member member) {
        boolean existsByCouponNum = gifticonRepository.existsByCouponNumAndMember(request.getCouponNum(), member);
        if (existsByCouponNum) {
            throw new CustomException(ErrorCodes.GIFTICON_ALREADY_EXISTS);
        }
        Gifticon gifticon = addGifticon(request, member);
        return AddGifticonResponse.from(gifticon.getId());
    }

    @Transactional(readOnly = true)
    public GetGifticonResponse get(@NotNull Long id, @NotNull Member member) {
        Gifticon gifticon = gifticonRepository.findById(id)
                .orElseThrow(() -> new CustomException(ErrorCodes.GIFTICON_NOT_FOUND));

        if (!member.getId().equals(gifticon.getMember().getId())) {
            throw new CustomException(ErrorCodes.GIFTICON_NOT_FOUND);
        }
        return GetGifticonResponse.from(gifticon);
    }

    @Transactional(readOnly = true)
    public List<GifticonPreviewDto> getList(@NotNull Member member) {
        return gifticonRepository.findAllGifticonByMember(member);
    }

    @Transactional
    public UpdateGifticonResponse update(@NotNull Long id, @NotNull UpdateGifticonRequest request,
            @NotNull Member member) {
        Gifticon gifticon = gifticonRepository.findById(id)
                .orElseThrow(() -> new CustomException(ErrorCodes.GIFTICON_NOT_FOUND));
        if (!member.getId().equals(gifticon.getMember().getId())) {
            throw new CustomException(ErrorCodes.GIFTICON_NOT_FOUND);
        }
        gifticon = request.update(gifticon);
        gifticon = gifticonRepository.save(gifticon);
        return UpdateGifticonResponse.from(gifticon);
    }

    @Transactional
    public DeleteGifticonResponse delete(@NotNull Long id, @NotNull Member member) {
        Gifticon gifticon = gifticonRepository.findById(id)
                .orElseThrow(() -> new CustomException(ErrorCodes.GIFTICON_NOT_FOUND));
        if (!member.getId().equals(gifticon.getMember().getId())) {
            throw new CustomException(ErrorCodes.GIFTICON_NOT_FOUND);
        }
        gifticonRepository.deleteById(id);
        return new DeleteGifticonResponse("Success");
    }

    private Gifticon addGifticon(AddGifticonRequest request, Member member) {
        Gifticon gifticon = convertAddGifticonRequestToGifticon(request, member);
        gifticon = gifticonRepository.save(gifticon);
        return gifticon;
    }

    private Gifticon convertAddGifticonRequestToGifticon(AddGifticonRequest request, Member member) {
        return Gifticon.builder()
                .member(member)
                .url(request.getUrl())
                .name(request.getName())
                .store(request.getStore())
                .couponNum(request.getCouponNum())
                .endDate(request.getEndDate())
                .isUsed(request.getIsUsed())
                .remainMoney(request.getRemainMoney())
                .memo(request.getMemo())
                .build();
    }

}
