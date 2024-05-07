package com.zzuiksa.server.domain.place.service;

import org.springframework.stereotype.Service;

import com.zzuiksa.server.domain.place.repository.PlaceRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PlaceService {

    private final PlaceRepository placeRepository;

}
