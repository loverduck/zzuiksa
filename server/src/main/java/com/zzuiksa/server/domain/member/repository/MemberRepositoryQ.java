package com.zzuiksa.server.domain.member.repository;

import com.zzuiksa.server.domain.member.entity.Member;

public interface MemberRepositoryQ {
    Member findActiveMemberById(Long id);
}
