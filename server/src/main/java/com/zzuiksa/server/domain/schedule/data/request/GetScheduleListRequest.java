package com.zzuiksa.server.domain.schedule.data.request;

import java.time.LocalDate;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@EqualsAndHashCode
public class GetScheduleListRequest {

    @NotNull
    private LocalDate from;

    @NotNull
    private LocalDate to;

    private Long categoryId;
}
