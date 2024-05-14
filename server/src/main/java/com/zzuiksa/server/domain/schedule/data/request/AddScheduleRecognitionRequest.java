package com.zzuiksa.server.domain.schedule.data.request;

import java.time.LocalDate;

import lombok.Getter;

@Getter
public class AddScheduleRecognitionRequest {

    private Long categoryId;

    private String content;

    private LocalDate baseDate;
}
