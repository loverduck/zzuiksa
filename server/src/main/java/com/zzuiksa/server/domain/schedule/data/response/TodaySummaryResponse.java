package com.zzuiksa.server.domain.schedule.data.response;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import com.zzuiksa.server.domain.weather.constant.WeatherType;
import com.zzuiksa.server.domain.weather.data.WeatherInfoDto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Builder
public class TodaySummaryResponse {

    @Schema(description = "날짜")
    private LocalDate date;

    @Schema(description = "완료한 일정 개수")
    private Long doneScheduleCount;

    @Schema(description = "전체 일정 개수")
    private Long totalScheduleCount;

    @Schema(description = "쮝사 한마디")
    private String comment;

    @Schema(description = "일정 목록")
    private List<TodayScheduleSummaryDto> schedules;

    @Getter
    @Builder
    public static class TodayScheduleSummaryDto {

        @Schema(description = "일정 정보")
        private ScheduleSummaryDto scheduleSummary;

        @Schema(description = "날씨 정보")
        @Setter
        private WeatherInfoDto weatherInfo;

        @Schema(description = "예상 소요 시간")
        @Setter
        private Integer estimatedTime;

        @Schema(description = "알림 메세지")
        private String message;

        public static TodayScheduleSummaryDto of(ScheduleSummaryDto scheduleSummary) {
            return TodayScheduleSummaryDto.builder()
                    .scheduleSummary(scheduleSummary)
                    .build();
        }

        public String getMessage() {
            if (estimatedTime == null) {
                return null;
            }

            Duration duration = Duration.ofSeconds((long)estimatedTime);
            LocalDateTime arrivedAt = LocalDateTime.now().plus(duration);
            LocalDateTime startDateTime = LocalDateTime.of(scheduleSummary.getStartDate(),
                    scheduleSummary.getStartTime());

            Duration diff = Duration.between(arrivedAt, startDateTime);
            if (diff.isNegative()) {
                return null;
            } else if (diff.compareTo(Duration.ofMinutes(20)) <= 0) {
                return "슬슬 출발해야 할 시간이에요!";
            } else if (diff.compareTo(Duration.ofMinutes(60)) <= 0) {
                return "천천히 준비하는 게 좋겠어요!";
            } else {
                return "아직 여유로워요!";
            }
        }
    }

    public static TodaySummaryResponse of(LocalDate date, long doneScheduleCount, long totalScheduleCount,
            List<TodayScheduleSummaryDto> schedules) {
        return TodaySummaryResponse.builder()
                .date(date)
                .doneScheduleCount(doneScheduleCount)
                .totalScheduleCount(totalScheduleCount)
                .schedules(schedules)
                .build();
    }

    public String getComment() {
        boolean isTodayRain = false;
        boolean isLargeDailyTempDiff = false;
        Integer maxTodayTemp = null;
        Integer minTodayTemp = null;

        for (TodayScheduleSummaryDto schedule : schedules) {
            WeatherInfoDto weatherInfo = schedule.getWeatherInfo();
            if (weatherInfo != null) {
                isTodayRain = isTodayRain || isRain(weatherInfo);
                minTodayTemp = getMinTodayTemp(weatherInfo, minTodayTemp);
                maxTodayTemp = getMaxTodayTemp(weatherInfo, maxTodayTemp);
            }
        }

        if (maxTodayTemp != null && minTodayTemp != null) {
            isLargeDailyTempDiff = dailyTempDiff(minTodayTemp, minTodayTemp);
        }

        if (isTodayRain) {
            return "비 소식이 있어요. 우산 챙기세요!";
        }
        if (isLargeDailyTempDiff) {
            return "일교차가 크니 겉옷을 챙기세요!";
        }
        return "오늘도 즐거운 하루 되세요 쮝!";
    }

    private boolean isRain(WeatherInfoDto weatherInfo) {
        WeatherType weatherType = weatherInfo.getWeatherType();
        if (weatherType.equals(WeatherType.RAIN) || weatherType.equals(WeatherType.RAIN_AND_SNOW)) {
            return true;
        }
        return false;
    }

    private Integer getMaxTodayTemp(WeatherInfoDto weatherInfo, Integer maxTodayTemp) {
        Integer maxTemp = weatherInfo.getMaxTmp();
        if (maxTodayTemp == null) {
            return maxTemp;
        }
        if (maxTemp != null && maxTemp > maxTodayTemp) {
            return maxTemp;
        }
        return maxTodayTemp;
    }

    private Integer getMinTodayTemp(WeatherInfoDto weatherInfo, Integer minTodayTemp) {
        Integer minTemp = weatherInfo.getMinTmp();
        if (minTodayTemp == null) {
            return minTemp;
        }
        if (minTemp != null && minTemp > minTodayTemp) {
            return minTemp;
        }
        return minTodayTemp;
    }

    private boolean dailyTempDiff(int minTemp, int maxTemp) {
        return maxTemp - minTemp >= 10;
    }

}
