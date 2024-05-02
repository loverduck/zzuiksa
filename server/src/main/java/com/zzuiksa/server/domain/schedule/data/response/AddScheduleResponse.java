package com.zzuiksa.server.domain.schedule.data.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AddScheduleResponse {

    private Long scheduleId;

    public static AddScheduleResponse from(Long scheduleId) {
        return new AddScheduleResponse(scheduleId);
    }
}
