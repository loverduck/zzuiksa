package com.zzuiksa.server.domain.schedule;

import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.schedule.constant.RoutineCycle;
import com.zzuiksa.server.domain.schedule.data.PlaceDto;
import com.zzuiksa.server.domain.schedule.data.RepeatDto;
import com.zzuiksa.server.domain.schedule.data.request.AddScheduleRequest;
import com.zzuiksa.server.domain.schedule.data.response.AddScheduleResponse;
import com.zzuiksa.server.domain.schedule.entity.Category;
import com.zzuiksa.server.domain.schedule.entity.Routine;
import com.zzuiksa.server.domain.schedule.entity.Schedule;
import com.zzuiksa.server.domain.schedule.repository.CategoryRepository;
import com.zzuiksa.server.domain.schedule.repository.RoutineRepository;
import com.zzuiksa.server.domain.schedule.repository.ScheduleRepository;
import com.zzuiksa.server.domain.schedule.service.ScheduleService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.DayOfWeek;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;

@ExtendWith(MockitoExtension.class)
public class ScheduleServiceTests {

    @Mock
    private CategoryRepository categoryRepositoryMock;
    @Mock
    private ScheduleRepository scheduleRepositoryMock;
    @Mock
    private RoutineRepository routineRepositoryMock;

    @InjectMocks
    private ScheduleService scheduleService;

    @Mock
    private Category categoryMock;
    @Mock
    private Schedule scheduleMock;
    @Mock
    private Routine routineMock;
    @Mock
    private Member memberMock;

    private AddScheduleRequest.AddScheduleRequestBuilder requestBuilder;
    private RepeatDto.RepeatDtoBuilder repeatDtoBuilder;

    @BeforeEach
    public void setUp() {
        requestBuilder = AddScheduleRequest.builder()
            .categoryId(1L)
            .title("Title")
            .startDate(LocalDate.of(2024, 4, 15))
            .endDate(LocalDate.of(2024, 4, 19))
            .startTime(LocalTime.of(17, 30, 50))
            .endTime(LocalTime.of(17, 50, 20))
            .alertBefore(Duration.ofMinutes(20))
            .memo("")
            .toPlace(new PlaceDto("To place", 123.4f, 34.5f))
            .fromPlace(new PlaceDto("From place", 132.4f, 43.5f));
        repeatDtoBuilder = RepeatDto.builder()
            .cycle(RoutineCycle.WEEKLY)
            .startDate(LocalDate.of(2024, 4, 15))
            .endDate(LocalDate.of(2024, 4, 29))
            .repeatTerm(1)
            .repeatAt(Routine.getWeeklyRepeatAtOf(DayOfWeek.MONDAY, DayOfWeek.FRIDAY));
    }

    @Test
    public void add_schedule_success() {
        // given
        Long scheduleId = 3L;
        given(categoryRepositoryMock.findById(any())).willReturn(Optional.of(categoryMock));
        given(scheduleRepositoryMock.save(any())).willReturn(scheduleMock);
        given(scheduleMock.getId()).willReturn(scheduleId);
        AddScheduleRequest request = requestBuilder.build();

        // when
        AddScheduleResponse response = scheduleService.add(request, memberMock);

        // then
        assertThat(response.getScheduleId()).isEqualTo(scheduleId);
    }

    @Test
    public void add_scheduleTitleIsBlank_throwIllegalArgumentException() {
        // given
        given(categoryRepositoryMock.findById(any())).willReturn(Optional.of(categoryMock));
        AddScheduleRequest request = requestBuilder.title("  ").build();

        // when & then
        assertThatThrownBy(() -> scheduleService.add(request, memberMock))
            .isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void add_routine_success() {
        // given
        Long routineId = 3L;
        given(categoryRepositoryMock.findById(any())).willReturn(Optional.of(categoryMock));
        given(routineRepositoryMock.save(any())).willReturn(routineMock);
        given(routineMock.getId()).willReturn(routineId);
        AddScheduleRequest request = requestBuilder.repeat(repeatDtoBuilder.build()).build();

        // when
        AddScheduleResponse response = scheduleService.add(request, memberMock);

        // then
        assertThat(response.getScheduleId()).isEqualTo(routineId);
    }

    @Test
    public void add_routineTitleIsBlank_throwIllegalArgumentException() {
        // given
        given(categoryRepositoryMock.findById(any())).willReturn(Optional.of(categoryMock));
        AddScheduleRequest request = requestBuilder.title("  ").repeat(repeatDtoBuilder.build()).build();

        // when & then
        assertThatThrownBy(() -> scheduleService.add(request, memberMock))
            .isInstanceOf(IllegalArgumentException.class);
    }
}
