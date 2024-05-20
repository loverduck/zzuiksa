package com.zzuiksa.server.domain.schedule.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.zzuiksa.server.domain.auth.data.MemberDetail;
import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.route.data.request.RouteTimeRequest;
import com.zzuiksa.server.domain.route.data.response.RouteTimeResponse;
import com.zzuiksa.server.domain.route.service.RouteService;
import com.zzuiksa.server.domain.schedule.data.CategoryDto;
import com.zzuiksa.server.domain.schedule.data.request.AddScheduleRecognitionRequest;
import com.zzuiksa.server.domain.schedule.data.request.AddScheduleRequest;
import com.zzuiksa.server.domain.schedule.data.request.UpdateScheduleRequest;
import com.zzuiksa.server.domain.schedule.data.response.AddScheduleRecognitionResponse;
import com.zzuiksa.server.domain.schedule.data.response.AddScheduleResponse;
import com.zzuiksa.server.domain.schedule.data.response.DeleteScheduleResponse;
import com.zzuiksa.server.domain.schedule.data.response.GetScheduleResponse;
import com.zzuiksa.server.domain.schedule.data.response.ScheduleStatisticsResponse;
import com.zzuiksa.server.domain.schedule.data.response.ScheduleSummaryDto;
import com.zzuiksa.server.domain.schedule.data.response.TodaySummaryResponse;
import com.zzuiksa.server.domain.schedule.data.response.UpdateScheduleResponse;
import com.zzuiksa.server.domain.schedule.service.DashboardService;
import com.zzuiksa.server.domain.schedule.service.ScheduleService;
import com.zzuiksa.server.domain.schedule.service.StatisticsService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@Tag(name = "Schedule", description = "일정 API")
@RestController
@RequestMapping("/api/schedules")
@RequiredArgsConstructor
public class ScheduleController {

    private final ScheduleService scheduleService;
    private final RouteService routeService;
    private final DashboardService dashboardService;
    private final StatisticsService statisticsService;

    @Operation(
            summary = "일정 추가",
            description = "일정을 추가합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @PostMapping
    public AddScheduleResponse add(@Valid @RequestBody AddScheduleRequest request,
            @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return scheduleService.add(request, member);
    }

    @Operation(
            summary = "자연어 일정 추가",
            description = "자연어를 인식하여 일정을 추가합니다.",
            security = @SecurityRequirement(name = "bearer-key")
    )
    @PostMapping("/recognize")
    public AddScheduleRecognitionResponse addRecognized(@Valid @RequestBody AddScheduleRecognitionRequest request,
            @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return scheduleService.addRecognized(request, member);
    }

    @Operation(
            summary = "일정 조회",
            description = "일정 Id로 일정을 조회합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @GetMapping("/{scheduleId}")
    public GetScheduleResponse get(@PathVariable Long scheduleId, @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return scheduleService.get(scheduleId, member);
    }

    @Operation(
            summary = "일정 목록 조회",
            description = "내 일정 목록을 조회합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @GetMapping
    public List<ScheduleSummaryDto> getList(@RequestParam LocalDate from, @RequestParam LocalDate to,
            @RequestParam(required = false) Long categoryId, @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return scheduleService.getList(from, to, categoryId, member);
    }

    @Operation(
            summary = "일정 수정",
            description = "일정을 수정합니다.",
            security = @SecurityRequirement(name = "bearer-key")
    )
    @PatchMapping("/{scheduleId}")
    public UpdateScheduleResponse update(@PathVariable Long scheduleId,
            @Valid @RequestBody UpdateScheduleRequest request, @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return scheduleService.update(scheduleId, request, member);
    }

    @Operation(
            summary = "일정 삭제",
            description = "일정을 삭제합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @DeleteMapping("/{scheduleId}")
    public DeleteScheduleResponse delete(@PathVariable Long scheduleId,
            @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return scheduleService.delete(scheduleId, member);
    }

    @Operation(
            summary = "카테고리 목록 조회",
            description = "카테고리 목록을 조회합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @GetMapping("/categories")
    public List<CategoryDto> getCategoryList() {
        return scheduleService.getCategoryList();
    }

    @Operation(
            summary = "소요 시간 계산",
            description = "출발지부터 도착지까지의 소요 시간을 계산합니다.",
            security = @SecurityRequirement(name = "bearer-key")
    )
    @PostMapping("/route")
    public RouteTimeResponse getRouteTime(@Valid @RequestBody RouteTimeRequest request) {
        Integer time = routeService.calcRouteTime(request);
        return RouteTimeResponse.of(time);
    }

    @Operation(
            summary = "오늘의 일정 요약 조회",
            description = "오늘 일정 정보를 요약하여 제공합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @GetMapping("/summary")
    public TodaySummaryResponse getTodaySummary(
            @RequestParam(required = false) Double lat,
            @RequestParam(required = false) Double lng,
            @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return dashboardService.getTodaySummary(lat, lng, member);
    }

    @Operation(
            summary = "일정 통계 조회",
            description = "일정 통계를 조회합니다.",
            security = {@SecurityRequirement(name = "bearer-key")}
    )
    @GetMapping("/statistics")
    public ScheduleStatisticsResponse getStatistics(@AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return statisticsService.getScheduleStatistics(LocalDate.now(), member);
    }
}
