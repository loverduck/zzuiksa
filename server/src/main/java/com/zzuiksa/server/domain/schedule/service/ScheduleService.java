package com.zzuiksa.server.domain.schedule.service;

import com.zzuiksa.server.domain.member.entity.Member;
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
import com.zzuiksa.server.global.exception.custom.ErrorCodes;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ScheduleService {

    private final CategoryRepository categoryRepository;
    private final ScheduleRepository scheduleRepository;
    private final RoutineRepository routineRepository;

    @Transactional
    public AddScheduleResponse add(@NotNull AddScheduleRequest request, @NotNull Member member) {
        Schedule schedule = request.isRepeat() ? addScheduleAndRoutine(request, member) : addSchedule(request, member);
        return AddScheduleResponse.from(schedule.getId());
    }

    @Transactional(readOnly = true)
    public GetScheduleResponse get(@NotNull Long id, @NotNull Member member) {
        Schedule schedule = scheduleRepository.findById(id)
            .orElseThrow(() -> new CustomException(ErrorCodes.SCHEDULE_NOT_FOUND));
        // 다른 사용자의 일정을 요청한 경우 404 리턴
        if (!member.getId().equals(schedule.getMember().getId())) {
            throw new CustomException(ErrorCodes.SCHEDULE_NOT_FOUND);
        }
        return GetScheduleResponse.from(schedule);
    }

    private Schedule addSchedule(AddScheduleRequest request, Member member) {
        Schedule schedule = convertAddScheduleRequestToSchedule(request, member, null);
        schedule = scheduleRepository.save(schedule);
        return schedule;
    }

    private Schedule addScheduleAndRoutine(AddScheduleRequest request, Member member) {
        Routine routine = convertAddScheduleRequestToRoutine(request, member);
        routine = routineRepository.save(routine);
        Schedule schedule = convertAddScheduleRequestToSchedule(request, member, routine);
        schedule = scheduleRepository.save(schedule);
        return schedule;
    }

    protected Schedule convertAddScheduleRequestToSchedule(AddScheduleRequest request, Member member, Routine routine) {
        Category category = categoryRepository.findById(request.getCategoryId())
            .orElseThrow(() -> new IllegalArgumentException("Invalid CategoryId"));

        return Schedule.builder()
            .member(member)
            .category(category)
            .routine(routine)
            .title(request.getTitle())
            .startDate(request.getStartDate())
            .endDate(request.getEndDate())
            .startTime(request.getStartTime())
            .endTime(request.getEndTime())
            .alertBefore(request.getAlertBefore())
            .memo(request.getMemo())
            .toPlaceName(request.getToPlace().getName())
            .toPlaceLat(request.getToPlace().getLat())
            .toPlaceLng(request.getToPlace().getLng())
            .fromPlaceName(request.getFromPlace().getName())
            .fromPlaceLat(request.getFromPlace().getLat())
            .fromPlaceLng(request.getFromPlace().getLng())
            .isDone(false)
            .build();
    }

    protected Routine convertAddScheduleRequestToRoutine(AddScheduleRequest request, Member member) {
        if (!request.isRepeat()) {
            throw new IllegalArgumentException("AddScheduleRequest without repeat cannot be converted to Routine");
        }
        Category category = categoryRepository.findById(request.getCategoryId())
            .orElseThrow(() -> new IllegalArgumentException("Invalid CategoryId"));

        return Routine.builder()
            .member(member)
            .category(category)
            .title(request.getTitle())
            .startDate(request.getStartDate())
            .endDate(request.getEndDate())
            .startTime(request.getStartTime())
            .endTime(request.getEndTime())
            .alertBefore(request.getAlertBefore())
            .memo(request.getMemo())
            .toPlaceName(request.getToPlace().getName())
            .toPlaceLat(request.getToPlace().getLat())
            .toPlaceLng(request.getToPlace().getLng())
            .fromPlaceName(request.getFromPlace().getName())
            .fromPlaceLat(request.getFromPlace().getLat())
            .fromPlaceLng(request.getFromPlace().getLng())
            .repeatCycle(request.getRepeat().getCycle())
            .repeatStartDate(request.getStartDate())
            .repeatEndDate(request.getRepeat().getEndDate())
            .repeatTerm(request.getRepeat().getRepeatTerm())
            .repeatAt(request.getRepeat().getRepeatAt())
            .build();
    }
}
