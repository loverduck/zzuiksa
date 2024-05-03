package com.zzuiksa.server.domain.schedule.data.request;

import static org.assertj.core.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.json.JsonTest;
import org.springframework.boot.test.json.JacksonTester;

import com.zzuiksa.server.domain.schedule.ScheduleSource;
import com.zzuiksa.server.domain.schedule.data.RepeatDto;

@JsonTest
public class AddScheduleRequestTests {

    @Autowired
    private JacksonTester<AddScheduleRequest> json;

    AddScheduleRequest.AddScheduleRequestBuilder requestBuilder;
    RepeatDto repeatDto;

    @BeforeEach
    public void setUp() {
        requestBuilder = ScheduleSource.getTestAddScheduleRequestBuilder();
        repeatDto = ScheduleSource.getTestRepeatDto();
    }

    @Test
    public void deserialize_withAllProperties_success() throws Exception {
        // given
        AddScheduleRequest addScheduleRequest = requestBuilder.categoryId(4L).repeat(repeatDto).build();
        String raw = """
                {
                    "categoryId": 4,
                    "title": "Title",
                    "startDate": "2024-04-15",
                    "endDate": "2024-04-19",
                    "startTime": "08:50:30",
                    "endTime": "15:59:40",
                    "alertBefore": 600,
                    "memo": "memo",
                    "toPlace": {
                        "name": "To place",
                        "lat": 123.4,
                        "lng": 34.5
                    },
                    "fromPlace": {
                        "name": "From place",
                        "lat": 132.4,
                        "lng": 43.5
                    },
                    "repeat": {
                        "cycle": "WEEKLY",
                        "endDate": "2024-04-25",
                        "repeatTerm": 1,
                        "repeatAt": 14
                    }
                }""";

        // when
        AddScheduleRequest parsed = json.parseObject(raw);

        // then
        assertThat(parsed).isEqualTo(addScheduleRequest);
    }
}
