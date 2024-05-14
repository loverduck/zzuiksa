package com.zzuiksa.server.domain.schedule.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzuiksa.server.domain.member.entity.Member;
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
    private final ScheduleRepository scheduleRepository;

    @Transactional(readOnly = true)
    public TodaySummaryResponse getTodaySummary(Member member) {
        LocalDate today = LocalDate.now();
        // TODO: 진행도 추가
        int progress = 100;
        // TODO: 쮝사 한마디 추가
        String comment = "테스트";
        List<TodaySummaryResponse.TodayScheduleSummaryDto> schedules = getScheduleSummaries(today, member);
        return TodaySummaryResponse.of(today, progress, comment, schedules);
    }

    public List<TodaySummaryResponse.TodayScheduleSummaryDto> getScheduleSummaries(LocalDate date, Member member) {
        List<ScheduleSummaryDto> todayScheduleSummaries = getTodaySchedules(member);
        return todayScheduleSummaries.stream().map(schedule -> {
            WeatherInfoDto weatherInfo = getWeatherOfSchedule(date, schedule);
            return TodaySummaryResponse.TodayScheduleSummaryDto.of(schedule, weatherInfo);
        }).toList();
    }

    private List<ScheduleSummaryDto> getTodaySchedules(Member member) {
        LocalDate today = LocalDate.now();
        return scheduleRepository.findAllSummaryByMemberAndDateAndIsNotDone(member, today);
    }

    private WeatherInfoDto getWeatherOfSchedule(LocalDate date, ScheduleSummaryDto schedule) {
        if (isToPlaceExist(schedule)) {
            return null;
        }
        double lat = schedule.getToPlace().getLat();
        double lng = schedule.getToPlace().getLng();

        LocalTime startTime = getTodayScheduleStartTime(schedule);
        LocalTime endTime = getTodayScheduleEndTime(schedule);

        return weatherService.getWeatherOfTime(date, lat, lng, startTime, endTime);
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
