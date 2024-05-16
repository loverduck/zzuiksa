package com.zzuiksa.server.domain.schedule.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.route.constant.TransportType;
import com.zzuiksa.server.domain.route.data.LatLngDto;
import com.zzuiksa.server.domain.route.data.request.RouteTimeRequest;
import com.zzuiksa.server.domain.route.service.RouteService;
import com.zzuiksa.server.domain.schedule.data.PlaceDto;
import com.zzuiksa.server.domain.schedule.data.response.ScheduleSummaryDto;
import com.zzuiksa.server.domain.schedule.data.response.TodaySummaryResponse;
import com.zzuiksa.server.domain.schedule.repository.ScheduleRepository;
import com.zzuiksa.server.domain.weather.data.WeatherInfoDto;
import com.zzuiksa.server.domain.weather.service.WeatherService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DashboardService {

    private final WeatherService weatherService;
    private final StatisticsService statisticsService;
    private final ScheduleRepository scheduleRepository;
    private final RouteService routeService;

    @Transactional(readOnly = true)
    public TodaySummaryResponse getTodaySummary(Double lat, Double lng, Member member) {
        LocalDate today = LocalDate.now();
        long doneScheduleCount = statisticsService.getDoneScheduleCount(today, member);
        long totalScheduleCount = statisticsService.getTotalScheduleCount(today, member);

        LatLngDto from = LatLngDto.of(lat, lng);
        List<TodaySummaryResponse.TodayScheduleSummaryDto> schedules = getScheduleSummaries(today, from, member);
        // TODO: 쮝사 한마디 추가
        String comment = "쮝";
        return TodaySummaryResponse.of(today, doneScheduleCount, totalScheduleCount, comment, schedules);
    }

    public List<TodaySummaryResponse.TodayScheduleSummaryDto> getScheduleSummaries(LocalDate date, LatLngDto from,
            Member member) {
        List<TodaySummaryResponse.TodayScheduleSummaryDto> todayScheduleSummaries = getTodaySchedules(member);

        ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor();

        List<CompletableFuture<Void>> voidCompletableFuture = new ArrayList<>();
        todayScheduleSummaries.stream().forEach(schedule -> {
            voidCompletableFuture.add(CompletableFuture.runAsync(() -> {
                WeatherInfoDto weatherInfo = getWeatherOfSchedule(schedule.getScheduleSummary(), date);
                schedule.setWeatherInfo(weatherInfo);
            }, executor));
            voidCompletableFuture.add(CompletableFuture.runAsync(() -> {
                Integer estimatedTime = getEstimatedTime(schedule.getScheduleSummary(), from);
                schedule.setEstimatedTime(estimatedTime);
            }, executor));
        });

        voidCompletableFuture.stream().forEach(CompletableFuture::join);
        return todayScheduleSummaries;
    }

    private Comparator<TodaySummaryResponse.TodayScheduleSummaryDto> getComparator() {
        return Comparator.<TodaySummaryResponse.TodayScheduleSummaryDto, LocalDate>comparing(
                        dto -> dto.getScheduleSummary().getStartDate())
                .thenComparing(dto -> dto.getScheduleSummary().getStartTime(),
                        Comparator.nullsFirst(Comparator.naturalOrder()))
                .thenComparing(dto -> dto.getScheduleSummary().getEndDate())
                .thenComparing(dto -> dto.getScheduleSummary().getEndTime(),
                        Comparator.nullsFirst(Comparator.naturalOrder()))
                .thenComparingLong(dto -> dto.getScheduleSummary().getScheduleId());
    }

    private List<TodaySummaryResponse.TodayScheduleSummaryDto> getTodaySchedules(Member member) {
        LocalDate today = LocalDate.now();
        List<ScheduleSummaryDto> scheduleSummaries = scheduleRepository.findAllSummaryByMemberAndDateAndIsNotDone(
                member, today);
        return scheduleSummaries.stream().map(TodaySummaryResponse.TodayScheduleSummaryDto::of).toList();
    }

    private WeatherInfoDto getWeatherOfSchedule(ScheduleSummaryDto schedule, LocalDate date) {
        if (isToPlaceExist(schedule)) {
            return null;
        }
        double lat = schedule.getToPlace().getLat();
        double lng = schedule.getToPlace().getLng();

        LocalTime startTime = getTodayScheduleStartTime(schedule);
        LocalTime endTime = getTodayScheduleEndTime(schedule);

        return weatherService.getWeatherOfTime(date, lat, lng, startTime, endTime);
    }

    private Integer getEstimatedTime(ScheduleSummaryDto schedule, LatLngDto from) {
        if (from == null) {
            return null;
        }

        PlaceDto toPlace = schedule.getToPlace();
        if (toPlace == null || toPlace.getLat() == null) {
            return null;
        }

        if (!Objects.equals(schedule.getStartDate(), LocalDate.now()) || schedule.getStartTime() == null) {
            return null;
        }

        LatLngDto to = LatLngDto.of(toPlace.getLat(), toPlace.getLng());
        LocalDateTime arrivalTime = LocalDateTime.of(schedule.getStartDate(), schedule.getStartTime());
        RouteTimeRequest routeTimeRequest = RouteTimeRequest.builder()
                .type(TransportType.TRANSIT)
                .from(from)
                .to(to)
                .arrivalTime(arrivalTime)
                .build();
        return routeService.calcRouteTime(routeTimeRequest);
    }

    private boolean isToPlaceExist(ScheduleSummaryDto schedule) {
        return schedule.getToPlace().getLat() == null || schedule.getToPlace().getLng() == null;
    }

    private LocalTime getTodayScheduleStartTime(ScheduleSummaryDto schedule) {
        if (schedule.getStartDate().isBefore(LocalDate.now()) || schedule.getStartTime() == null) {
            return LocalTime.of(0, 0);
        }
        return schedule.getStartTime();
    }

    private LocalTime getTodayScheduleEndTime(ScheduleSummaryDto schedule) {
        if (schedule.getEndDate().isAfter(LocalDate.now()) || schedule.getEndTime() == null) {
            return LocalTime.of(23, 59);
        }
        return schedule.getEndTime();
    }
}
