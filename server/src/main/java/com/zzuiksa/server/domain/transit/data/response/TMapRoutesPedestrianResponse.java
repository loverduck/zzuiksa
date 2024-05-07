package com.zzuiksa.server.domain.transit.data.response;

import java.util.List;
import java.util.Objects;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;

@Getter
public class TMapRoutesPedestrianResponse {

    @NotNull
    private List<Features> features;

    @Getter
    static class Features {

        @NotNull
        private Features.Properties properties;

        @Getter
        static class Properties {

            private Integer totalTime;
        }
    }

    public Integer findMinTotalTime() {
        return features.stream()
                .map(feature -> feature.properties.totalTime)
                .filter(Objects::nonNull)
                .min(Integer::compare).orElseThrow();
    }
}
