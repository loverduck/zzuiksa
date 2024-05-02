package com.zzuiksa.server.domain.schedule.service;

import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.schedule.ScheduleSource;
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
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;

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
    private Member memberMock, otherMemberMock;

    private Long categoryId;
    private Schedule.ScheduleBuilder scheduleBuilder;
    private Routine.RoutineBuilder routineBuilder;
    private AddScheduleRequest.AddScheduleRequestBuilder addScheduleRequestBuilder;
    private GetScheduleResponse.GetScheduleResponseBuilder getScheduleResponseBuilder;
    private RepeatDto repeatDto;

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
    }

    @Test
    public void add_schedule_success() {
        // given
        Long scheduleId = 7L;
        given(categoryRepositoryMock.findById(any())).willReturn(Optional.of(categoryMock));
        given(scheduleRepositoryMock.save(any())).willReturn(scheduleMock);
        given(scheduleMock.getId()).willReturn(scheduleId);
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
        AddScheduleRequest request = addScheduleRequestBuilder.title("  ").build();

        // when & then
        assertThatThrownBy(() -> scheduleService.add(request, memberMock))
            .isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    public void add_routine_success() {
        // given
        Long scheduleId = 3L;
        given(categoryRepositoryMock.findById(any())).willReturn(Optional.of(categoryMock));
        given(scheduleMock.getId()).willReturn(scheduleId);
        given(scheduleRepositoryMock.save(any())).willReturn(scheduleMock);
        given(routineRepositoryMock.save(any())).willReturn(routineMock);
        AddScheduleRequest request = addScheduleRequestBuilder.repeat(repeatDto).build();

        // when
        AddScheduleResponse response = scheduleService.add(request, memberMock);

        // then
        assertThat(response.getScheduleId()).isEqualTo(scheduleId);
        verify(scheduleRepositoryMock, times(1)).save(any());
        verify(routineRepositoryMock, times(1)).save(any());
    }

    @Test
    public void add_routineTitleIsBlank_throwIllegalArgumentException() {
        // given
        given(categoryRepositoryMock.findById(any())).willReturn(Optional.of(categoryMock));
        AddScheduleRequest request = addScheduleRequestBuilder.title("  ").repeat(repeatDto).build();

        // when & then
        assertThatThrownBy(() -> scheduleService.add(request, memberMock))
            .isInstanceOf(IllegalArgumentException.class);
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
        Schedule converted = scheduleService.convertAddScheduleRequestToSchedule(request, memberMock, null);

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
        Schedule converted = scheduleService.convertAddScheduleRequestToSchedule(request, memberMock, null);

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
