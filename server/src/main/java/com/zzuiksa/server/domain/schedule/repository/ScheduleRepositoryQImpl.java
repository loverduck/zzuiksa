package com.zzuiksa.server.domain.schedule.repository;

import java.time.LocalDate;
import java.util.List;

import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.schedule.data.AllAndDoneCountDto;
import com.zzuiksa.server.domain.schedule.data.CategoryAllAndDoneCountDto;
import com.zzuiksa.server.domain.schedule.data.LocalDateAllAndDoneCountDto;
import com.zzuiksa.server.domain.schedule.data.QCategoryAllAndDoneCountDto;
import com.zzuiksa.server.domain.schedule.data.QLocalDateAllAndDoneCountDto;
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
                .where(schedule.startDate.loe(to).and(schedule.endDate.goe(from)))
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

    @Override
    public Long countByMemberAndDateEqual(Member member, LocalDate endDate) {
        return queryFactory.select(schedule.count())
                .from(schedule)
                .where(schedule.member.eq(member))
                .where(schedule.endDate.eq(endDate))
                .fetchOne();
    }

    @Override
    public Long countByMemberAndDateEqualAndIsDone(Member member, LocalDate endDate) {
        return queryFactory.select(schedule.count())
                .from(schedule)
                .where(schedule.member.eq(member))
                .where(schedule.endDate.eq(endDate))
                .where(schedule.isDone.isTrue())
                .fetchOne();
    }

    @Override
    public AllAndDoneCountDto countAllAndDoneByMemberAndDateBeforeOrEqual(Member member, LocalDate endDate) {
        return new AllAndDoneCountDto(
                queryFactory.select(schedule.count())
                        .from(schedule)
                        .where(schedule.member.eq(member))
                        .where(schedule.endDate.before(endDate).or(schedule.endDate.eq(endDate)))
                        .fetchOne(),
                queryFactory.select(schedule.count())
                        .from(schedule)
                        .where(schedule.member.eq(member))
                        .where(schedule.endDate.before(endDate).or(schedule.endDate.eq(endDate)))
                        .where(schedule.isDone.isTrue())
                        .fetchOne()
        );
    }

    @Override
    public List<CategoryAllAndDoneCountDto> countAllAndDoneByMemberAndDateBeforeOrEqualGroupByCategory(Member member,
            LocalDate endDate) {
        List<CategoryAllAndDoneCountDto> total = queryFactory.select(new QCategoryAllAndDoneCountDto(
                        schedule.category,
                        schedule.count(),
                        Expressions.constant(0L)))
                .from(schedule)
                .where(schedule.member.eq(member))
                .where(schedule.endDate.before(endDate).or(schedule.endDate.eq(endDate)))
                .groupBy(schedule.category)
                .fetch();
        List<CategoryAllAndDoneCountDto> done = queryFactory.select(new QCategoryAllAndDoneCountDto(
                        schedule.category,
                        Expressions.constant(0L),
                        schedule.count()))
                .from(schedule)
                .where(schedule.member.eq(member))
                .where(schedule.endDate.before(endDate).or(schedule.endDate.eq(endDate)))
                .where(schedule.isDone.isTrue())
                .groupBy(schedule.category)
                .fetch();
        for (CategoryAllAndDoneCountDto doneCount : done) {
            CategoryAllAndDoneCountDto totalCount = total.stream()
                    .filter(item -> item.getCategory().getId().equals(doneCount.getCategory().getId()))
                    .findFirst()
                    .orElseThrow();
            totalCount.setDone(doneCount.getDone());
        }
        return total;
    }

    @Override
    public List<LocalDateAllAndDoneCountDto> countAllAndDoneByMemberAndDateBetweenGroupByDate(Member member,
            LocalDate from, LocalDate to) {
        List<LocalDateAllAndDoneCountDto> total = queryFactory.select(new QLocalDateAllAndDoneCountDto(
                        schedule.endDate,
                        schedule.count(),
                        Expressions.constant(0L)))
                .from(schedule)
                .where(schedule.member.eq(member))
                .where(schedule.endDate.between(from, to))
                .groupBy(schedule.endDate)
                .fetch();
        List<LocalDateAllAndDoneCountDto> done = queryFactory.select(new QLocalDateAllAndDoneCountDto(
                        schedule.endDate,
                        Expressions.constant(0L),
                        schedule.count()))
                .from(schedule)
                .where(schedule.member.eq(member))
                .where(schedule.endDate.between(from, to))
                .where(schedule.isDone.isTrue())
                .groupBy(schedule.endDate)
                .fetch();
        for (LocalDateAllAndDoneCountDto doneCount : done) {
            LocalDateAllAndDoneCountDto totalCount = total.stream()
                    .filter(item -> item.getDate().equals(doneCount.getDate()))
                    .findFirst()
                    .orElseThrow();
            totalCount.setDone(doneCount.getDone());
        }
        return total;
    }

    @Override
    public List<ScheduleSummaryDto> findAllSummaryByMemberAndDateAndIsNotDone(Member member, LocalDate date) {
        return queryFactory.select(getQScheduleSummaryDto())
                .from(schedule)
                .where(schedule.member.eq(member))
                .where(schedule.startDate.loe(date).and(schedule.endDate.goe(date)))
                .where(schedule.isDone.isFalse())
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
