package com.zzuiksa.server.domain.member.repository;

import com.zzuiksa.server.domain.member.entity.Member;

import java.util.Optional;

public interface MemberRepositoryQ {
    Optional<Member> findActiveMemberById(Long id);
}
