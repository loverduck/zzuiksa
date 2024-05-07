package com.zzuiksa.server.domain.place.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.place.entity.Place;

import jakarta.validation.constraints.NotNull;

public interface PlaceRepository extends JpaRepository<Place, Long> {

    List<Place> findAllByMember(@NotNull Member member);
}
