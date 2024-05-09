package com.zzuiksa.server.domain.gifticon.repository;

import com.zzuiksa.server.domain.gifticon.entity.Gifticon;
import com.zzuiksa.server.domain.member.entity.Member;

import org.springframework.data.jpa.repository.JpaRepository;

public interface GifticonRepository extends JpaRepository<Gifticon, Long>, GifticonRepositoryQ {

    boolean existsByCouponNumAndMember(String couponNum, Member member);
}
