package com.zzuiksa.server.domain.schedule.service;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.BDDMockito.*;
import static org.mockito.Mockito.*;

import java.time.Clock;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;

import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.schedule.ScheduleSource;
import com.zzuiksa.server.domain.schedule.constant.RoutineCycle;
import com.zzuiksa.server.domain.schedule.data.RepeatDto;
import com.zzuiksa.server.domain.schedule.data.request.AddScheduleRequest;
import com.zzuiksa.server.domain.schedule.data.response.AddScheduleResponse;
import com.zzuiksa.server.domain.schedule.data.response.GetScheduleResponse;
import com.zzuiksa.server.domain.schedule.entity.Category;
import com.zzuiksa.server.domain.schedule.entity.Routine;
import com.zzuiksa.server.domain.schedule.entity.Schedule;
import com.zzuiksa.server.domain.schedule.repository.CategoryRepository;
import com.zzuiksa.server.domain.schedule.repository.RoutineRepository;
import com.zzuiksa.server.domain.schedule.repository.ScheduleRepository;
import com.zzuiksa.server.global.exception.custom.CustomException;

@ExtendWith(MockitoExtension.class)
public class ScheduleServiceTests {

    private static final LocalDate LOCAL_DATE = LocalDate.of(2024, 4, 1);

    @Mock
    private CategoryRepository categoryRepositoryMock;
    @Mock
    private ScheduleRepository scheduleRepositoryMock;
    @Mock
    private RoutineRepository routineRepositoryMock;
    @Mock
    private Clock clockMock;

    @InjectMocks
    private ScheduleService scheduleService;

    @Mock
    private Category categoryMock;
    @Mock
    private Schedule scheduleMock;
    @Mock
    private Routine routineMock;
    @Mock
    private Member memberMock, otherMemberMock;

    private Long categoryId;
    private Schedule.ScheduleBuilder scheduleBuilder;
    private Routine.RoutineBuilder routineBuilder;
    private AddScheduleRequest.AddScheduleRequestBuilder addScheduleRequestBuilder;
    private GetScheduleResponse.GetScheduleResponseBuilder getScheduleResponseBuilder;
    private RepeatDto repeatDto;
    private Clock fixedClock;

    @BeforeEach
    public void setUp() {
        categoryId = 4L;
        addScheduleRequestBuilder = ScheduleSource.getTestAddScheduleRequestBuilder()
                .categoryId(categoryId);
        getScheduleResponseBuilder = ScheduleSource.getTestGetScheduleResponseBuilder()
                .categoryId(categoryId);
        repeatDto = ScheduleSource.getTestRepeatDto();
        scheduleBuilder = ScheduleSource.getTestScheduleBuilder()
                .category(categoryMock)
                .member(memberMock);
        routineBuilder = ScheduleSource.getTestRoutineBuilder()
                .category(categoryMock)
                .member(memberMock);
        fixedClock = Clock.fixed(LOCAL_DATE.atStartOfDay(ZoneId.systemDefault()).toInstant(), ZoneId.systemDefault());
    }

    @Test
    public void add_schedule_success() {
        // given
        Long scheduleId = 7L;
        given(categoryRepositoryMock.findById(any())).willReturn(Optional.of(categoryMock));
        given(scheduleRepositoryMock.save(any())).willReturn(scheduleMock);
        given(scheduleMock.getId()).willReturn(scheduleId);
        given(clockMock.instant()).willReturn(fixedClock.instant());
        given(clockMock.getZone()).willReturn(fixedClock.getZone());
        AddScheduleRequest request = addScheduleRequestBuilder.build();

        // when
        AddScheduleResponse response = scheduleService.add(request, memberMock);

        // then
        assertThat(response.getScheduleId()).isEqualTo(scheduleId);
        verify(scheduleRepositoryMock, times(1)).save(any());
    }

    @Test
    public void add_scheduleTitleIsBlank_throwIllegalArgumentException() {
        // given
        given(categoryRepositoryMock.findById(any())).willReturn(Optional.of(categoryMock));
        given(clockMock.instant()).willReturn(fixedClock.instant());
        given(clockMock.getZone()).willReturn(fixedClock.getZone());
        AddScheduleRequest request = addScheduleRequestBuilder.title("  ").build();

        // when & then
        assertThatThrownBy(() -> scheduleService.add(request, memberMock))
                .isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void add_routine_success() {
        // given
        Long scheduleId = 3L;
        LocalDate startDate = LocalDate.of(2024, 4, 1);
        LocalDate endDate = LocalDate.of(2024, 4, 1);
        RoutineCycle cycle = RoutineCycle.DAILY;
        LocalDate repeatEndDate = LocalDate.of(2024, 4, 20);
        int repeatAt = 1;
        Routine routine = routineBuilder.id(1L)
                .startDate(startDate)
                .endDate(endDate)
                .repeatCycle(RoutineCycle.DAILY)
                .repeatStartDate(startDate)
                .repeatEndDate(repeatEndDate)
                .repeatAt(repeatAt)
                .build();
        ArgumentCaptor<List<Schedule>> scheduleCaptor = ArgumentCaptor.forClass(List.class);
        given(categoryRepositoryMock.findById(any())).willReturn(Optional.of(categoryMock));
        given(scheduleMock.getId()).willReturn(scheduleId);
        given(routineRepositoryMock.save(any())).willReturn(routine);
        given(scheduleRepositoryMock.saveAll(scheduleCaptor.capture())).willReturn(List.of(scheduleMock));
        given(clockMock.instant()).willReturn(fixedClock.instant());
        given(clockMock.getZone()).willReturn(fixedClock.getZone());
        RepeatDto repeatDto = RepeatDto.builder()
                .cycle(cycle)
                .endDate(repeatEndDate)
                .repeatAt(repeatAt)
                .build();
        AddScheduleRequest request = addScheduleRequestBuilder.startDate(startDate)
                .endDate(endDate)
                .repeat(repeatDto)
                .build();

        // when
        AddScheduleResponse response = scheduleService.add(request, memberMock);

        // then
        assertThat(response.getScheduleId()).isEqualTo(scheduleId);
        assertThat(scheduleCaptor.getValue()).hasSize(20);
        verify(scheduleRepositoryMock, times(1)).saveAll(any());
        verify(routineRepositoryMock, times(1)).save(any());
    }

    @Test
    public void add_routineTitleIsBlank_throwIllegalArgumentException() {
        // given
        given(categoryRepositoryMock.findById(any())).willReturn(Optional.of(categoryMock));
        given(clockMock.instant()).willReturn(fixedClock.instant());
        given(clockMock.getZone()).willReturn(fixedClock.getZone());
        AddScheduleRequest request = addScheduleRequestBuilder.title("  ").repeat(repeatDto).build();

        // when & then
        assertThatThrownBy(() -> scheduleService.add(request, memberMock))
                .isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void add_scheduleNotAfter2Years_notThrow() {
        // given
        LocalDate startDate = LocalDate.of(2026, 12, 31);
        given(categoryRepositoryMock.findById(any())).willReturn(Optional.of(categoryMock));
        given(scheduleRepositoryMock.save(any())).willReturn(scheduleMock);
        given(scheduleMock.getId()).willReturn(1L);
        given(clockMock.instant()).willReturn(fixedClock.instant());
        given(clockMock.getZone()).willReturn(fixedClock.getZone());
        AddScheduleRequest request = addScheduleRequestBuilder.startDate(startDate).build();

        // when
        AddScheduleResponse response = scheduleService.add(request, memberMock);

        // then
        assertThat(response).isNotNull();
    }

    @Test
    public void add_scheduleAfter2Years_throwCustomException() {
        // given
        LocalDate startDate = LocalDate.of(2027, 1, 1);
        given(clockMock.instant()).willReturn(fixedClock.instant());
        given(clockMock.getZone()).willReturn(fixedClock.getZone());
        AddScheduleRequest request = addScheduleRequestBuilder.startDate(startDate).build();

        // when & then
        assertThatThrownBy(() -> scheduleService.add(request, memberMock))
                .isInstanceOf(CustomException.class);
    }

    @Test
    public void get_byScheduleOwner_success() {
        // given
        Long memberId = 12L;
        Long scheduleId = 3L;
        GetScheduleResponse getScheduleResponse = getScheduleResponseBuilder.build();
        given(memberMock.getId()).willReturn(memberId);
        given(categoryMock.getId()).willReturn(categoryId);
        Schedule schedule = scheduleBuilder.id(scheduleId).build();
        given(scheduleRepositoryMock.findById(anyLong())).willReturn(Optional.of(schedule));

        // when
        GetScheduleResponse got = scheduleService.get(scheduleId, memberMock);

        // then
        assertThat(got).isEqualTo(getScheduleResponse);
    }

    @Test
    public void get_routineIsNotNull_repeatIsNotNull() {
        // given
        Long memberId = 12L;
        Long scheduleId = 3L;
        GetScheduleResponse getScheduleResponse = getScheduleResponseBuilder.repeat(repeatDto).build();
        given(memberMock.getId()).willReturn(memberId);
        given(categoryMock.getId()).willReturn(categoryId);
        Routine routine = routineBuilder.build();
        Schedule schedule = scheduleBuilder.id(scheduleId).routine(routine).build();
        given(scheduleRepositoryMock.findById(anyLong())).willReturn(Optional.of(schedule));

        // when
        GetScheduleResponse got = scheduleService.get(scheduleId, memberMock);

        // then
        assertThat(got).isEqualTo(getScheduleResponse);
    }

    @Test
    public void get_byNotScheduleOwner_throwCustomExceptionWithStatus404() {
        // given
        Long memberId = 12L;
        Long otherMemberId = 13L;
        Long scheduleId = 3L;
        given(memberMock.getId()).willReturn(memberId);
        given(otherMemberMock.getId()).willReturn(otherMemberId);
        Schedule schedule = scheduleBuilder.id(scheduleId).build();
        given(scheduleRepositoryMock.findById(anyLong())).willReturn(Optional.of(schedule));

        // when & then
        assertThatThrownBy(() -> scheduleService.get(scheduleId, otherMemberMock))
                .isInstanceOfSatisfying(CustomException.class, ex -> ex.getStatus().isSameCodeAs(HttpStatus.NOT_FOUND));
    }

    @Test
    public void convertAddScheduleRequestToSchedule_repeatIsNull_success() {
        // given
        Schedule schedule = scheduleBuilder.id(null).build();
        given(categoryRepositoryMock.findById(anyLong())).willReturn(Optional.of(categoryMock));
        AddScheduleRequest request = addScheduleRequestBuilder.build();

        // when
        Schedule converted = scheduleService.convertAddScheduleRequestToSchedule(request, memberMock);

        // then
        assertThat(converted).isEqualTo(schedule);
    }

    @Test
    public void convertAddScheduleRequestToSchedule_repeatIsNotNull_success() {
        // given
        Schedule schedule = scheduleBuilder.id(null).build();
        given(categoryRepositoryMock.findById(anyLong())).willReturn(Optional.of(categoryMock));
        AddScheduleRequest request = addScheduleRequestBuilder.repeat(repeatDto).build();

        // when
        Schedule converted = scheduleService.convertAddScheduleRequestToSchedule(request, memberMock);

        // then
        assertThat(converted).isEqualTo(schedule);
    }

    @Test
    public void convertAddScheduleRequestToRoutine_repeatIsNotNull_success() {
        // given
        Routine routine = routineBuilder.id(null).build();
        given(categoryRepositoryMock.findById(any())).willReturn(Optional.of(categoryMock));
        AddScheduleRequest request = addScheduleRequestBuilder.repeat(repeatDto).build();

        // when
        Routine converted = scheduleService.convertAddScheduleRequestToRoutine(request, memberMock);

        // then
        assertThat(converted).isEqualTo(routine);
    }

    @Test
    public void convertAddScheduleRequestToRoutine_repeatIsNull_throwIllegalArgumentException() {
        // given
        AddScheduleRequest request = addScheduleRequestBuilder.build();

        // when & then
        assertThatThrownBy(() -> scheduleService.convertAddScheduleRequestToRoutine(request, memberMock))
                .isInstanceOf(IllegalArgumentException.class);
    }
}
