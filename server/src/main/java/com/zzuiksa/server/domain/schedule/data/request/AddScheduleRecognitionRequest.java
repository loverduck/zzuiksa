package com.zzuiksa.server.domain.schedule.data.request;

import java.time.LocalDate;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;

@Getter
public class AddScheduleRecognitionRequest {

    @NotNull
    private Long categoryId;

    @NotBlank
    @Size(max = 100)
    private String content;

    @NotNull
    private LocalDate baseDate;
}
