package com.zzuiksa.server.domain.schedule.data.response;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.Comparator;
import java.util.List;

import com.zzuiksa.server.domain.schedule.data.AllAndDoneCountDto;
import com.zzuiksa.server.domain.schedule.data.CategoryAllAndDoneCountDto;
import com.zzuiksa.server.domain.schedule.data.LocalDateAllAndDoneCountDto;
import com.zzuiksa.server.domain.schedule.entity.Category;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class ScheduleStatisticsResponse {

    private Statistics total;

    private List<CategoryStatistics> category;

    private List<DailyStatistics> daily;

    public static ScheduleStatisticsResponse from(AllAndDoneCountDto total, List<CategoryAllAndDoneCountDto> category,
            List<LocalDateAllAndDoneCountDto> daily) {
        Statistics totalStatistics = Statistics.from(total.getCount(), total.getDone());
        List<CategoryStatistics> categoryStatistics = category.stream()
                .sorted(Comparator.comparingLong(item -> item.getCategory().getId()))
                .map(item -> CategoryStatistics.from(item.getCategory(), item.getAll(), item.getDone()))
                .toList();
        List<DailyStatistics> dailyStatistics = daily.stream()
                .sorted(Comparator.comparing(LocalDateAllAndDoneCountDto::getDate))
                .map(item -> DailyStatistics.from(item.getDate(), item.getAll(), item.getDone()))
                .toList();
        return new ScheduleStatisticsResponse(totalStatistics, categoryStatistics, dailyStatistics);
    }

    @Getter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Statistics {

        private Long count;

        private Long done;

        public static Statistics from(long count, long done) {
            return new Statistics(count, done);
        }

    }

    @Getter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class CategoryStatistics {

        private Long categoryId;

        private String name;

        private Long count;

        private Long done;

        public static CategoryStatistics from(Category category, long count, long done) {
            return new CategoryStatistics(category.getId(), category.getTitle(), count, done);
        }
    }

    @Getter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class DailyStatistics {

        private LocalDate date;

        private String weekday;

        private Long count;

        private Long done;

        public static DailyStatistics from(LocalDate date, long count, long done) {
            DayOfWeek dayOfWeek = date.getDayOfWeek();
            String weekday = dayOfWeek.name();
            return new DailyStatistics(date, weekday, count, done);
        }
    }
}
