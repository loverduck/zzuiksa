package com.zzuiksa.server.domain.schedule.repository;

import java.time.LocalDate;
import java.util.List;

import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.schedule.data.response.ScheduleSummaryDto;
import com.zzuiksa.server.domain.schedule.entity.Category;

public interface ScheduleRepositoryQ {

    List<ScheduleSummaryDto> findAllSummaryByMemberAndDateBetween(Member member, LocalDate from, LocalDate to);

    List<ScheduleSummaryDto> findAllSummaryByMemberAndDateBetweenAndCategory(Member member, LocalDate from,
            LocalDate to, Category category);
}
