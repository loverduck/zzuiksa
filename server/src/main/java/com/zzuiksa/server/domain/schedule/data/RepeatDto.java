package com.zzuiksa.server.domain.schedule.data;

import com.zzuiksa.server.domain.schedule.constant.RoutineCycle;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDate;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@EqualsAndHashCode
public class RepeatDto {

    @NotNull
    private RoutineCycle cycle;

    @NotNull
    private LocalDate startDate;

    private LocalDate endDate;

    private Integer repeatTerm;

    private Integer repeatAt;
}
