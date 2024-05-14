package com.zzuiksa.server.domain.gifticon.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.zzuiksa.server.domain.gifticon.entity.Gifticon;
import com.zzuiksa.server.domain.member.entity.Member;

public interface GifticonRepository extends JpaRepository<Gifticon, Long>, GifticonRepositoryQ {

    boolean existsByCouponNumAndMember(String couponNum, Member member);
}
