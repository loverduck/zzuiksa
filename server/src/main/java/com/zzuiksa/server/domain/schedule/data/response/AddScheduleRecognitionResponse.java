package com.zzuiksa.server.domain.schedule.data.response;

import com.zzuiksa.server.domain.schedule.entity.Schedule;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AddScheduleRecognitionResponse {

    private Long scheduleId;

    public static AddScheduleRecognitionResponse from(Schedule schedule) {
        return new AddScheduleRecognitionResponse(schedule.getId());
    }
}
