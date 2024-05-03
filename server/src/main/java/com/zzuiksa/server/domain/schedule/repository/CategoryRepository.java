package com.zzuiksa.server.domain.schedule.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.zzuiksa.server.domain.schedule.entity.Category;

public interface CategoryRepository extends JpaRepository<Category, Long> {
}
