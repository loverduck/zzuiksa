package com.zzuiksa.server.domain.gifticon.repository;

import java.util.List;

import com.zzuiksa.server.domain.gifticon.data.response.GifticonPreviewDto;
import com.zzuiksa.server.domain.member.entity.Member;

public interface GifticonRepositoryQ {

    List<GifticonPreviewDto> findAllGifticonByMember(Member member);

}
