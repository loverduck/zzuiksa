package com.zzuiksa.server.domain.schedule.data;

import java.time.LocalDate;

import com.querydsl.core.annotations.QueryProjection;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@NoArgsConstructor
public class LocalDateAllAndDoneCountDto {

    private LocalDate date;

    private long all;

    @Setter
    private long done;

    @QueryProjection
    public LocalDateAllAndDoneCountDto(LocalDate date, long all, long done) {
        this.date = date;
        this.all = all;
        this.done = done;
    }
}
