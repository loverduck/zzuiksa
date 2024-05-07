package com.zzuiksa.server.domain.place.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.zzuiksa.server.domain.place.entity.Place;

public interface PlaceRepository extends JpaRepository<Place, Long> {
}
