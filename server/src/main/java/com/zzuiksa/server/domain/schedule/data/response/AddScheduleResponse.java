package com.zzuiksa.server.domain.schedule.data.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AddScheduleResponse {

    @Schema(description = "일정 ID")
    private Long scheduleId;

    public static AddScheduleResponse from(Long scheduleId) {
        return new AddScheduleResponse(scheduleId);
    }
}
