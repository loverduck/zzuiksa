package com.zzuiksa.server.domain.place.controller;

import org.springframework.stereotype.Controller;

import com.zzuiksa.server.domain.place.service.PlaceService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class PlaceController {

    private final PlaceService placeService;
}
