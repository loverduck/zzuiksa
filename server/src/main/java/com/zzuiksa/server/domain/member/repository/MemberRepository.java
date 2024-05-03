package com.zzuiksa.server.domain.member.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.zzuiksa.server.domain.member.entity.Member;

public interface MemberRepository extends JpaRepository<Member, Long>, MemberRepositoryQ {
    Optional<Member> findByKakaoId(String kakaoId);
}
