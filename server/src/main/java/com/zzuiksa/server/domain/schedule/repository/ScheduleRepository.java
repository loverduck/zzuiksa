package com.zzuiksa.server.domain.schedule.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.zzuiksa.server.domain.schedule.entity.Routine;
import com.zzuiksa.server.domain.schedule.entity.Schedule;

public interface ScheduleRepository extends JpaRepository<Schedule, Long>, ScheduleRepositoryQ {

    void deleteAllByRoutine(Routine routine);
}
