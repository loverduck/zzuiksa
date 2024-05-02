package com.zzuiksa.server.domain.schedule.controller;

import com.zzuiksa.server.domain.auth.data.MemberDetail;
import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.schedule.data.request.AddScheduleRequest;
import com.zzuiksa.server.domain.schedule.data.request.GetScheduleListRequest;
import com.zzuiksa.server.domain.schedule.data.response.AddScheduleResponse;
import com.zzuiksa.server.domain.schedule.data.response.GetScheduleResponse;
import com.zzuiksa.server.domain.schedule.data.response.ScheduleSummaryDto;
import com.zzuiksa.server.domain.schedule.service.ScheduleService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/schedules")
@RequiredArgsConstructor
public class ScheduleController {

    private final ScheduleService scheduleService;

    @PostMapping
    public AddScheduleResponse add(@Valid @RequestBody AddScheduleRequest request, @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return scheduleService.add(request, member);
    }

    @GetMapping("/{scheduleId}")
    public GetScheduleResponse get(@PathVariable Long scheduleId, @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return scheduleService.get(scheduleId, member);
    }

    @GetMapping
    public List<ScheduleSummaryDto> getList(@Valid @RequestBody GetScheduleListRequest request, @AuthenticationPrincipal MemberDetail memberDetail) {
        Member member = memberDetail.getMember();
        return scheduleService.getList(request.getFrom(), request.getTo(), request.getCategoryId(), member);
    }
}
