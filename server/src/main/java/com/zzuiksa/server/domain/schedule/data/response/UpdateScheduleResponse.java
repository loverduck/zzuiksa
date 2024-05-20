package com.zzuiksa.server.domain.schedule.data.response;

import com.zzuiksa.server.domain.schedule.entity.Schedule;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class UpdateScheduleResponse {

    private Long scheduleId;

    public static UpdateScheduleResponse from(Schedule schedule) {
        return new UpdateScheduleResponse(schedule.getId());
    }
}
