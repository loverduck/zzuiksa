package com.zzuiksa.server.domain.schedule.repository;

import com.zzuiksa.server.domain.schedule.data.response.ScheduleSummaryDto;
import com.zzuiksa.server.domain.schedule.entity.Category;

import java.time.LocalDate;
import java.util.List;

public interface ScheduleRepositoryQ {

    List<ScheduleSummaryDto> findAllSummaryByDateBetween(LocalDate from, LocalDate to);

    List<ScheduleSummaryDto> findAllSummaryByDateBetweenAndCategory(LocalDate from, LocalDate to, Category category);
}
