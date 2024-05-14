package com.zzuiksa.server.domain.schedule.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.schedule.data.AllAndDoneCountDto;
import com.zzuiksa.server.domain.schedule.data.CategoryAllAndDoneCountDto;
import com.zzuiksa.server.domain.schedule.data.LocalDateAllAndDoneCountDto;
import com.zzuiksa.server.domain.schedule.data.response.ScheduleStatisticsResponse;
import com.zzuiksa.server.domain.schedule.repository.ScheduleRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StatisticsService {

    private final ScheduleRepository scheduleRepository;

    @Transactional(readOnly = true)
    public ScheduleStatisticsResponse getScheduleStatistics(LocalDate now, Member member) {
        AllAndDoneCountDto total = scheduleRepository.countAllAndDoneByMemberAndDateBeforeOrEqual(member, now);
        List<CategoryAllAndDoneCountDto> category = scheduleRepository.countAllAndDoneByMemberAndDateBeforeOrEqualGroupByCategory(
                member, now);
        LocalDate from = now.minusDays(6);
        List<LocalDateAllAndDoneCountDto> daily = scheduleRepository.countAllAndDoneByMemberAndDateBetweenGroupByDate(
                member, from, now);
        return ScheduleStatisticsResponse.from(total, category, daily);
    }

    public Long getTotalScheduleCount(LocalDate date, Member member) {
        return scheduleRepository.countByMemberAndDateBeforeOrEqual(member, date);
    }

    public Long getDoneScheduleCount(LocalDate date, Member member) {
        return scheduleRepository.countByMemberAndDateBeforeOrEqualAndIsDone(member, date);
    }
}
