package com.zzuiksa.server.domain.weather.client;

import static org.assertj.core.api.Assertions.*;

import java.time.LocalDate;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.zzuiksa.server.domain.weather.data.request.WeatherRequest;
import com.zzuiksa.server.domain.weather.data.response.WeatherResponse;

@SpringBootTest
@ExtendWith(SpringExtension.class)
public class WeatherClientTests {

    @Value("${api.weather.key}")
    private String serviceKey;

    @Autowired
    private WeatherClient client;

    @Test
    public void getWeather__success() throws Exception {
        // given
        LocalDate date = LocalDate.now();
        int nx = 130;
        int ny = 50;
        WeatherRequest request = WeatherRequest.of(serviceKey, date, nx, ny);

        // when
        WeatherResponse response = client.getWeather(request);

        // then
        assertThat(response.getResultCode()).isEqualTo("00");
        assertThat(response.getItems()).isNotEmpty();
    }

}
