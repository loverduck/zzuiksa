package com.zzuiksa.server.domain.schedule.data;

import java.time.LocalDate;

import com.zzuiksa.server.domain.schedule.constant.RoutineCycle;

import jakarta.validation.constraints.Min;
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
public class RepeatDto {

    @NotNull
    private RoutineCycle cycle;

    private LocalDate endDate;

    @NotNull
    @Min(1)
    private Integer repeatAt;

    public static RepeatDto of(RoutineCycle cycle, LocalDate endDate, Integer repeatAt) {
        return new RepeatDto(cycle, endDate, repeatAt);
    }
}
