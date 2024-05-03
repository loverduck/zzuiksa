package com.zzuiksa.server.domain.schedule.repository;

import java.time.LocalDate;
import java.util.List;

import com.querydsl.jpa.impl.JPAQueryFactory;
import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.schedule.data.response.QScheduleSummaryDto;
import com.zzuiksa.server.domain.schedule.data.response.ScheduleSummaryDto;
import com.zzuiksa.server.domain.schedule.entity.Category;
import com.zzuiksa.server.domain.schedule.entity.QSchedule;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class ScheduleRepositoryQImpl implements ScheduleRepositoryQ {

    private final JPAQueryFactory queryFactory;

    QSchedule schedule = QSchedule.schedule;

    @Override
    public List<ScheduleSummaryDto> findAllSummaryByMemberAndDateBetween(Member member, LocalDate from, LocalDate to) {
        return queryFactory.select(getQScheduleSummaryDto())
                .from(schedule)
                .where(schedule.member.eq(member))
                .where(schedule.startDate.before(to).and(schedule.endDate.after(from)))
                .fetch();
    }

    @Override
    public List<ScheduleSummaryDto> findAllSummaryByMemberAndDateBetweenAndCategory(Member member, LocalDate from,
            LocalDate to, Category category) {
        return queryFactory.select(getQScheduleSummaryDto())
                .from(schedule)
                .where(schedule.member.eq(member))
                .where(schedule.startDate.before(to).and(schedule.endDate.after(from)))
                .where(schedule.category.id.eq(category.getId()))
                .fetch();
    }

    private QScheduleSummaryDto getQScheduleSummaryDto() {
        return new QScheduleSummaryDto(
                schedule.id,
                schedule.category.id,
                schedule.title,
                schedule.startDate,
                schedule.endDate,
                schedule.startTime,
                schedule.endTime,
                schedule.toPlaceName,
                schedule.toPlaceLat,
                schedule.toPlaceLng,
                schedule.isDone
        );
    }
}
