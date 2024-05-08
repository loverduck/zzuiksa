package com.zzuiksa.server.domain.gifticon.repository;

import com.zzuiksa.server.domain.gifticon.data.response.GifticonPreviewDto;
import com.zzuiksa.server.domain.member.entity.Member;

import java.util.List;

public interface GifticonRepositoryQ {

    List<GifticonPreviewDto> findAllGifticonByMember(Member member);

}
