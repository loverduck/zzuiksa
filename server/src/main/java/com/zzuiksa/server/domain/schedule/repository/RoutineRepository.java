package com.zzuiksa.server.domain.schedule.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.zzuiksa.server.domain.schedule.entity.Routine;

public interface RoutineRepository extends JpaRepository<Routine, Long> {
}
