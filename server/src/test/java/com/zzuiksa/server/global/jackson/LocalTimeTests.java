package com.zzuiksa.server.global.jackson;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.json.JsonTest;
import org.springframework.boot.test.json.JacksonTester;
import org.springframework.boot.test.json.JsonContent;

import java.time.LocalTime;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

@JsonTest
public class LocalTimeTests {

    @Autowired
    private JacksonTester<LocalTime> json;

    @Test
    public void serialize__success() throws Exception {
        // given
        LocalTime time = LocalTime.of(17, 30, 50);
        String timeString = "\"17:30:50\"";

        // when
        JsonContent<LocalTime> content = json.write(time);

        // then
        assertThat(content).asString().isEqualTo(timeString);
    }

    @Test
    public void deserialize_localTimeString_success() throws Exception {
        // given
        String timeString = "\"17:30:50\"";
        LocalTime time = LocalTime.of(17, 30, 50);

        // when
        LocalTime parsed = json.parseObject(timeString);

        // then
        assertThat(parsed).isEqualTo(time);
    }

    @ParameterizedTest
    @ValueSource(strings = {"\"17:30:50Z\"", "\"17:30:50+01:00\""})
    public void deserialize_zonedTimeString_throwRuntimeException(String timeString) throws Exception {
        // when & then
        assertThatThrownBy(() -> json.parseObject(timeString))
            .isInstanceOf(RuntimeException.class);
    }
}
