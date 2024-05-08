package com.zzuiksa.server.domain.route.data.response;

import java.util.List;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;

@Getter
public class TMapTransitRoutesSubResponse {

    @NotNull
    private MetaData metaData;

    @Getter
    public static class MetaData {

        @NotNull
        private Plan plan;

        @Getter
        public static class Plan {

            @NotNull
            @Size(min = 1)
            private List<Itinerary> itineraries;

            @Getter
            public static class Itinerary {

                @NotNull
                private Integer totalTime;

                @NotNull
                private Integer totalWalkTime;
            }
        }
    }

    public Integer findMinTotalTime() {
        return metaData.plan.itineraries.stream()
                .mapToInt(itinerary -> itinerary.totalTime)
                .min().orElseThrow();
    }
}
