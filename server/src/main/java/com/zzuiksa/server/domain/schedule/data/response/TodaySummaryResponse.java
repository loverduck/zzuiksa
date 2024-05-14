package com.zzuiksa.server.domain.schedule.data.response;

import java.time.LocalDate;
import java.util.List;

import com.zzuiksa.server.domain.weather.data.WeatherInfoDto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class TodaySummaryResponse {

    @Schema(description = "날짜")
    private LocalDate date;

    @Schema(description = "진행도")
    private Integer progress;

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
        private WeatherInfoDto weatherInfo;

        public static TodayScheduleSummaryDto of(ScheduleSummaryDto scheduleSummary, WeatherInfoDto weatherInfo) {
            return TodayScheduleSummaryDto.builder()
                    .scheduleSummary(scheduleSummary)
                    .weatherInfo(weatherInfo)
                    .build();
        }
    }

    public static TodaySummaryResponse of(LocalDate date, int progress, String comment,
            List<TodayScheduleSummaryDto> schedules) {
        return TodaySummaryResponse.builder()
                .date(date)
                .progress(progress)
                .comment(comment)
                .schedules(schedules)
                .build();
    }
}
