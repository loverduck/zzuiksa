package com.zzuiksa.server.domain.schedule.data;

import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@EqualsAndHashCode
public class PlaceDto {

    private String name;
    private Float lat;
    private Float lng;
}
