package com.zzuiksa.server.domain.route.data.response;

import java.util.List;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;

@Getter
public class TMapRoutesResponse {

    @NotNull
    private List<Features> features;

    @Getter
    static class Features {

        @NotNull
        private Properties properties;

        @Getter
        static class Properties {

            @NotNull
            private Integer totalTime;
        }
    }

    public Integer findMinTotalTime() {
        return features.stream()
                .mapToInt(feature -> feature.properties.totalTime)
                .min().orElseThrow();
    }
}
