package com.zzuiksa.server.domain.weather.data.response;

import java.util.List;

import com.zzuiksa.server.domain.weather.data.ItemInfoDto;

import lombok.Getter;

@Getter
public class WeatherResponse {

    private Response response;

    @Getter
    public static class Response {

        private Header header;

        private Body body;

        @Getter
        public static class Header {

            private String resultCode;
            private String resultMsg;
        }

        @Getter
        public static class Body {

            private Item items;

            @Getter
            public static class Item {

                private List<ItemInfoDto> item;
            }
        }
    }

    public String getResultCode() {
        return response.header.resultCode;
    }

    public String getResultMessage() {
        return response.header.resultMsg;
    }

    public List<ItemInfoDto> getItems() {
        return response.body.items.item;
    }
}
