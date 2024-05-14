package com.zzuiksa.server.domain.schedule.data;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class OpenAIScheduleRecognitionResponse {

    public static final OpenAIScheduleRecognitionResponse EMPTY = new OpenAIScheduleRecognitionResponse();

    private String message;

    private String date;

    private String time;

    private String duration;

    private String place;

}
