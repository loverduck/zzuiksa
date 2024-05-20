package com.zzuiksa.server.domain.schedule.data;

import com.querydsl.core.annotations.QueryProjection;
import com.zzuiksa.server.domain.schedule.entity.Category;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@NoArgsConstructor
public class CategoryAllAndDoneCountDto {

    private Category category;

    private long all;

    @Setter
    private long done;

    @QueryProjection
    public CategoryAllAndDoneCountDto(Category category, long all, long done) {
        this.category = category;
        this.all = all;
        this.done = done;
    }
}
