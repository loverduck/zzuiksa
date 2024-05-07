package com.zzuiksa.server.domain.schedule.data;

import com.zzuiksa.server.domain.schedule.entity.Category;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@EqualsAndHashCode
public class CategoryDto {

    @NotNull
    private Long id;

    @NotNull
    private String title;

    public static CategoryDto from(Category category) {
        return CategoryDto.builder()
            .id(category.getId())
            .title(category.getTitle())
            .build();
    }
}
