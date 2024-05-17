package com.zzuiksa.server.domain.gifticon.repository;

import java.util.List;

import com.querydsl.jpa.impl.JPAQueryFactory;
import com.zzuiksa.server.domain.gifticon.data.response.GifticonPreviewDto;
import com.zzuiksa.server.domain.gifticon.data.response.QGifticonPreviewDto;
import com.zzuiksa.server.domain.gifticon.entity.QGifticon;
import com.zzuiksa.server.domain.member.entity.Member;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class GifticonRepositoryQImpl implements GifticonRepositoryQ {

    private final JPAQueryFactory queryFactory;

    QGifticon gifticon = QGifticon.gifticon;

    @Override
    public List<GifticonPreviewDto> findAllGifticonByMember(Member member) {
        return queryFactory.select(getQGifticonPreviewDto())
                .from(gifticon)
                .where(gifticon.member.eq(member))
                .fetch();
    }

    private QGifticonPreviewDto getQGifticonPreviewDto() {
        return new QGifticonPreviewDto(
                gifticon.id,
                gifticon.url,
                gifticon.name,
                gifticon.store,
                gifticon.endDate,
                gifticon.isUsed,
                gifticon.remainMoney
        );
    }
}
