package com.zzuiksa.server.domain.member.repository;

import java.util.Optional;

import com.zzuiksa.server.domain.member.entity.Member;

public interface MemberRepositoryQ {
    Optional<Member> findActiveMemberById(Long id);
}
