package com.zzuiksa.server.domain.schedule.data.response;

import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.schedule.ScheduleSource;
import com.zzuiksa.server.domain.schedule.data.RepeatDto;
import com.zzuiksa.server.domain.schedule.entity.Category;
import com.zzuiksa.server.domain.schedule.entity.Routine;
import com.zzuiksa.server.domain.schedule.entity.Schedule;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.json.JsonTest;
import org.springframework.boot.test.json.JacksonTester;
import org.springframework.boot.test.json.JsonContent;

import static org.assertj.core.api.Assertions.assertThat;

@JsonTest
public class GetScheduleResponseTests {

    @Autowired
    private JacksonTester<GetScheduleResponse> json;

    private Schedule.ScheduleBuilder scheduleBuilder;
    private Routine.RoutineBuilder routineBuilder;
    private GetScheduleResponse.GetScheduleResponseBuilder responseBuilder;
    private RepeatDto repeatDto;
    private Category.CategoryBuilder categoryBuilder;
    private Member member;

    @BeforeEach
    public void setUp() throws Exception {
        scheduleBuilder = ScheduleSource.getTestScheduleBuilder();
        routineBuilder = ScheduleSource.getTestRoutineBuilder();
        responseBuilder = ScheduleSource.getTestGetScheduleResponseBuilder();
        repeatDto = ScheduleSource.getTestRepeatDto();
        categoryBuilder = Category.builder();
        member = new Member();
    }

    @Test
    public void serialize_withAllProperties_success() throws Exception {
        // given
        GetScheduleResponse getScheduleResponse = responseBuilder.repeat(repeatDto).isDone(true).build();
        String raw = """
            {
                "title": "Title",
                "startDate": "2024-04-15",
                "endDate": "2024-04-19",
                "startTime": "08:50:30",
                "endTime": "15:59:40",
                "alertBefore": "PT10M",
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
                },
                "isDone": true
            }""";

        // when
        JsonContent<GetScheduleResponse> content = json.write(getScheduleResponse);

        // then
        assertThat(content).isEqualToJson(raw);
    }

    @Test
    public void serialize_propertyIsNull_excludeInJson() throws Exception {
        // given
        GetScheduleResponse getScheduleResponse = responseBuilder.startTime(null).endTime(null).fromPlace(null).build();
        String raw = """
            {
                "title": "Title",
                "startDate": "2024-04-15",
                "endDate": "2024-04-19",
                "alertBefore": "PT10M",
                "memo": "memo",
                "toPlace": {
                    "name": "To place",
                    "lat": 123.4,
                    "lng": 34.5
                }
            }""";

        // when
        JsonContent<GetScheduleResponse> content = json.write(getScheduleResponse);

        // then
        assertThat(content).isEqualToJson(raw);
    }

    @Test
    public void of_repeatIsNull_equals() {
        // given
        Long categoryId = 4L;
        GetScheduleResponse getScheduleResponse = responseBuilder.categoryId(categoryId).build();
        Schedule schedule = scheduleBuilder.category(categoryBuilder.id(categoryId).build()).member(member).build();

        // when
        GetScheduleResponse of = GetScheduleResponse.of(schedule);

        // then
        assertThat(of).isEqualTo(getScheduleResponse);
    }

    @Test
    public void of_repeatIsNotNull_equals() {
        // given
        Long categoryId = 4L;
        GetScheduleResponse getScheduleResponse = responseBuilder.categoryId(categoryId).repeat(repeatDto).build();
        Routine routine = routineBuilder.category(categoryBuilder.id(categoryId).build()).member(member).build();
        Schedule schedule = scheduleBuilder.category(categoryBuilder.id(categoryId).build()).member(member).routine(routine).build();

        // when
        GetScheduleResponse of = GetScheduleResponse.of(schedule);

        // then
        assertThat(of).isEqualTo(getScheduleResponse);
    }
}
