package com.zzuiksa.server.domain.schedule.repository;

import com.zzuiksa.server.domain.schedule.entity.Routine;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoutineRepository extends JpaRepository<Routine, Long> {
}
