package com.zzuiksa.server.domain.schedule.service;

import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.schedule.data.request.AddScheduleRequest;
import com.zzuiksa.server.domain.schedule.data.response.AddScheduleResponse;
import com.zzuiksa.server.domain.schedule.entity.Category;
import com.zzuiksa.server.domain.schedule.entity.Routine;
import com.zzuiksa.server.domain.schedule.entity.Schedule;
import com.zzuiksa.server.domain.schedule.repository.CategoryRepository;
import com.zzuiksa.server.domain.schedule.repository.RoutineRepository;
import com.zzuiksa.server.domain.schedule.repository.ScheduleRepository;
import jakarta.transaction.Transactional;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ScheduleService {

    private final CategoryRepository categoryRepository;
    private final ScheduleRepository scheduleRepository;
    private final RoutineRepository routineRepository;

    @Transactional
    public AddScheduleResponse add(@NotNull AddScheduleRequest request, @NotNull Member member) {
        if (request.isRepeat()) {
            return addRoutine(request, member);
        } else {
            return addSchedule(request, member);
        }
    }

    private AddScheduleResponse addSchedule(AddScheduleRequest request, Member member) {
        Schedule schedule = convertToSchedule(request, member);
        schedule = scheduleRepository.save(schedule);
        return AddScheduleResponse.of(schedule.getId());
    }

    private AddScheduleResponse addRoutine(AddScheduleRequest request, Member member) {
        Routine routine = convertToRoutine(request, member);
        routine = routineRepository.save(routine);
        return AddScheduleResponse.of(routine.getId());
    }

    protected Routine convertToRoutine(AddScheduleRequest request, Member member) {
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
            .repeatStartDate(request.getRepeat().getStartDate())
            .repeatEndDate(request.getRepeat().getEndDate())
            .repeatTerm(request.getRepeat().getRepeatTerm())
            .repeatAt(request.getRepeat().getRepeatAt())
            .build();
    }

    protected Schedule convertToSchedule(AddScheduleRequest request, Member member) {
        if (request.isRepeat()) {
            throw new IllegalArgumentException("AddScheduleRequest with repeat cannot be converted to Schedule");
        }
        Category category = categoryRepository.findById(request.getCategoryId())
            .orElseThrow(() -> new IllegalArgumentException("Invalid CategoryId"));

        return Schedule.builder()
            .member(member)
            .category(category)
            .routine(null)
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
}
