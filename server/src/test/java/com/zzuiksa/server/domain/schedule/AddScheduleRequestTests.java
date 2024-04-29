package com.zzuiksa.server.domain.schedule;

import com.zzuiksa.server.domain.schedule.constant.RoutineCycle;
import com.zzuiksa.server.domain.schedule.data.PlaceDto;
import com.zzuiksa.server.domain.schedule.data.RepeatDto;
import com.zzuiksa.server.domain.schedule.data.request.AddScheduleRequest;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.json.JsonTest;
import org.springframework.boot.test.json.JacksonTester;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;

import static org.assertj.core.api.Assertions.assertThat;

@JsonTest
public class AddScheduleRequestTests {

    @Autowired
    private JacksonTester<AddScheduleRequest> json;

    @Test
    public void deserialize_allPropertiesSet_success() throws Exception {
        // given
        String raw = """
            {
                "categoryId": 1,
                "title": "Title",
                "startDate": "2024-04-15",
                "endDate": "2024-04-19",
                "startTime": "15:00:00",
                "endTime": "18:00:00",
                "alertBefore": 3600,
                "memo": "",
                "toPlace": {
                    "name": "To place",
                    "lat": 123.4567,
                    "lng": 34.567
                },
                "fromPlace": {
                    "name": "From place",
                    "lat": 132.4567,
                    "lng": 43.567
                },
                "repeat": {
                    "cycle": "WEEKLY",
                    "startDate": "2024-04-15",
                    "endDate": "2024-04-22",
                    "repeatTerm": 1,
                    "repeatAt": 7
                }
            }""";
        // @formatter:off
        AddScheduleRequest addScheduleRequest = new AddScheduleRequest(
            1,
            "Title",
            LocalDate.of(2024, 4, 15),
            LocalDate.of(2024, 4, 19),
            LocalTime.of(15, 0, 0),
            LocalTime.of(18, 0, 0),
            Duration.ofSeconds(3600), "",
            new PlaceDto("To place", 123.4567f, 34.567f),
            new PlaceDto("From place", 132.4567f, 43.567f),
            new RepeatDto(
                RoutineCycle.WEEKLY,
                LocalDate.of(2024, 4, 15),
                LocalDate.of(2024, 4, 22),
                1,
                7
            )
        );
        // @formatter:on

        // when
        AddScheduleRequest parsed = json.parseObject(raw);

        // then
        assertThat(parsed).isEqualTo(addScheduleRequest);
    }
}
