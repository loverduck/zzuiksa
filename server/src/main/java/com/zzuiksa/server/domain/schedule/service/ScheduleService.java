package com.zzuiksa.server.domain.schedule.service;

import java.time.Clock;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.schedule.data.CategoryDto;
import com.zzuiksa.server.domain.schedule.data.ScheduleRecognitionResponse;
import com.zzuiksa.server.domain.schedule.data.request.AddScheduleRecognitionRequest;
import com.zzuiksa.server.domain.schedule.data.request.AddScheduleRequest;
import com.zzuiksa.server.domain.schedule.data.request.UpdateScheduleRequest;
import com.zzuiksa.server.domain.schedule.data.response.AddScheduleRecognitionResponse;
import com.zzuiksa.server.domain.schedule.data.response.AddScheduleResponse;
import com.zzuiksa.server.domain.schedule.data.response.DeleteScheduleResponse;
import com.zzuiksa.server.domain.schedule.data.response.GetScheduleResponse;
import com.zzuiksa.server.domain.schedule.data.response.ScheduleSummaryDto;
import com.zzuiksa.server.domain.schedule.data.response.UpdateScheduleResponse;
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

@Service
@RequiredArgsConstructor
public class ScheduleService {

    private final CategoryRepository categoryRepository;
    private final ScheduleRepository scheduleRepository;
    private final RoutineRepository routineRepository;
    private final RecognitionService recognitionService;
    private final Clock clock;

    @Transactional
    public AddScheduleResponse add(@NotNull AddScheduleRequest request, @NotNull Member member) {
        // 최대 2년 이내의 일정만 생성 가능
        if (request.getStartDate().isAfter(getLastScheduleCreateDate())) {
            throw new CustomException(ErrorCodes.SCHEDULE_TOO_FAR);
        }
        if (request.isRepeat()) {
            List<Schedule> schedules = addRoutineAndFutureSchedules(request, member);
            Schedule schedule = schedules.get(0);
            return AddScheduleResponse.from(schedule.getId());
        } else {
            Schedule schedule = addSchedule(request, member);
            return AddScheduleResponse.from(schedule.getId());
        }
    }

    @Transactional
    public AddScheduleRecognitionResponse addRecognized(@NotNull AddScheduleRecognitionRequest request, Member member) {
        Category category = categoryRepository.findById(request.getCategoryId())
                .orElseThrow(() -> new CustomException(ErrorCodes.CATEGORY_NOT_FOUND));
        String content = request.getContent();
        LocalDate baseDate = request.getBaseDate();
        ScheduleRecognitionResponse recognized = recognitionService.recognize(content, baseDate);
        Schedule schedule = convertScheduleRecognitionResponseToSchedule(recognized, member, category);
        schedule = scheduleRepository.save(schedule);
        return AddScheduleRecognitionResponse.from(schedule);
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

    @Transactional(readOnly = true)
    public List<ScheduleSummaryDto> getList(@NotNull LocalDate from, @NotNull LocalDate to, Long categoryId,
            @NotNull Member member) {
        if (categoryId == null) {
            return scheduleRepository.findAllSummaryByMemberAndDateBetween(member, from, to);
        }

        Category category = categoryRepository.findById(categoryId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid CategoryId"));

        return scheduleRepository.findAllSummaryByMemberAndDateBetweenAndCategory(member, from, to, category);
    }

    @Transactional
    public UpdateScheduleResponse update(@NotNull Long id, @NotNull UpdateScheduleRequest request,
            @NotNull Member member) {
        Schedule schedule = scheduleRepository.findById(id)
                .orElseThrow(() -> new CustomException(ErrorCodes.SCHEDULE_NOT_FOUND));
        if (!member.getId().equals(schedule.getMember().getId())) {
            throw new CustomException(ErrorCodes.SCHEDULE_NOT_FOUND);
        }
        schedule = request.update(schedule);
        return UpdateScheduleResponse.from(schedule);
    }

    @Transactional
    public DeleteScheduleResponse delete(@NotNull Long id, @NotNull Member member) {
        Schedule schedule = scheduleRepository.findById(id)
                .orElseThrow(() -> new CustomException(ErrorCodes.SCHEDULE_NOT_FOUND));
        if (!member.getId().equals(schedule.getMember().getId())) {
            throw new CustomException(ErrorCodes.SCHEDULE_NOT_FOUND);
        }
        Routine routine = schedule.getRoutine();
        if (routine != null) {
            scheduleRepository.deleteAllByRoutine(routine);
        } else {
            scheduleRepository.deleteById(id);
        }
        return new DeleteScheduleResponse("Success");
    }

    @Transactional(readOnly = true)
    public List<CategoryDto> getCategoryList() {
        return categoryRepository.findAll().stream().map(CategoryDto::from).toList();
    }

    private Schedule addSchedule(AddScheduleRequest request, Member member) {
        Schedule schedule = convertAddScheduleRequestToSchedule(request, member);
        schedule = scheduleRepository.save(schedule);
        return schedule;
    }

    private List<Schedule> addRoutineAndFutureSchedules(AddScheduleRequest request, Member member) {
        Routine routine = convertAddScheduleRequestToRoutine(request, member);
        routine = routineRepository.save(routine);
        List<Schedule> schedules = getFutureSchedules(routine);
        if (schedules.isEmpty()) {
            throw new CustomException(ErrorCodes.BAD_SCHEDULE_REPEAT);
        }
        schedules = scheduleRepository.saveAll(schedules);
        return schedules;
    }

    protected List<Schedule> getFutureSchedules(Routine routine) {
        // 현재 년도 + SCHEDULE_YEAR년 뒤까지 일정 생성
        return routine.createSchedules(getToday(), getLastScheduleCreateDate());
    }

    protected Schedule convertAddScheduleRequestToSchedule(AddScheduleRequest request, Member member) {
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
                .repeatAt(request.getRepeat().getRepeatAt())
                .build();
    }

    protected Schedule convertScheduleRecognitionResponseToSchedule(ScheduleRecognitionResponse response, Member member,
            Category category) {
        return Schedule.builder()
                .member(member)
                .category(category)
                .routine(null)
                .title(response.getTitle())
                .startDate(response.getStartDate())
                .endDate(response.getEndDate())
                .startTime(response.getStartTime())
                .endTime(response.getEndTime())
                .memo("")
                .toPlaceName(response.getPlaceName())
                .isDone(false)
                .build();
    }

    private LocalDate getToday() {
        return LocalDate.now(clock);
    }

    private LocalDate getLastScheduleCreateDate() {
        final int SCHEDULE_YEARS = 2;
        return getToday().plusYears(SCHEDULE_YEARS).with(TemporalAdjusters.lastDayOfYear());
    }
}
