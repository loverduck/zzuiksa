package com.zzuiksa.server.domain.member.repository;

import com.querydsl.jpa.impl.JPAQueryFactory;
import com.zzuiksa.server.domain.member.entity.QMember;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class MemberRepositoryQImpl implements MemberRepositoryQ {

    private static JPAQueryFactory queryFactory;
    QMember qMember = QMember.member;


}
