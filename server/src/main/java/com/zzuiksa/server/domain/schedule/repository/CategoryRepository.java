package com.zzuiksa.server.domain.schedule.repository;

import com.zzuiksa.server.domain.schedule.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category, Long> {
}
