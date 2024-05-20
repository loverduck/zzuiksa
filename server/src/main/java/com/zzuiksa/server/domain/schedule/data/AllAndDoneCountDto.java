package com.zzuiksa.server.domain.schedule.data;

import com.querydsl.core.annotations.QueryProjection;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class AllAndDoneCountDto {

    private long count;

    private long done;

    @QueryProjection
    public AllAndDoneCountDto(long count, long done) {
        this.count = count;
        this.done = done;
    }
}
