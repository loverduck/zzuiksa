package com.zzuiksa.server.domain.schedule.data.request;

import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDate;

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
