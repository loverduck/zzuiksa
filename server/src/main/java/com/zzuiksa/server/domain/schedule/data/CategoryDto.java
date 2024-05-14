package com.zzuiksa.server.domain.schedule.data;

import com.zzuiksa.server.domain.schedule.entity.Category;

import io.swagger.v3.oas.annotations.media.Schema;
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
public class CategoryDto {

    @Schema(description = "카테고리 ID")
    @NotNull
    private Long id;

    @Schema(description = "카테고리명")
    @NotNull
    private String title;

    public static CategoryDto from(Category category) {
        return CategoryDto.builder()
                .id(category.getId())
                .title(category.getTitle())
                .build();
    }
}
