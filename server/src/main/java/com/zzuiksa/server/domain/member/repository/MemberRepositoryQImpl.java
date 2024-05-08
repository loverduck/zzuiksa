package com.zzuiksa.server.domain.member.repository;

import com.querydsl.jpa.impl.JPAQueryFactory;
import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.member.entity.QMember;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class MemberRepositoryQImpl implements MemberRepositoryQ {

    private final JPAQueryFactory queryFactory;
    QMember qMember = QMember.member;

    @Override
    public Member findActiveMemberById(Long id) {
        return queryFactory.selectFrom(qMember)
                .where(qMember.id.eq(id))
                .where(qMember.deletedAt.isNull())
                .fetchOne();
    }
}
