package com.zzuiksa.server.domain.weather.data;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class GridDto {

    private Integer x;
    private Integer y;
}
