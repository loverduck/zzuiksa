package com.zzuiksa.server.domain.schedule.data;

import com.zzuiksa.server.domain.schedule.constant.RoutineCycle;
import lombok.*;

import java.time.LocalDate;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@EqualsAndHashCode
public class RepeatDto {

    private RoutineCycle cycle;
    private LocalDate startDate;
    private LocalDate endDate;
    private Integer repeatTerm;
    private Integer repeatAt;
}
