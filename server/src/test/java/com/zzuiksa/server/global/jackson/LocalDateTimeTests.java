package com.zzuiksa.server.global.jackson;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.json.JsonTest;
import org.springframework.boot.test.json.JacksonTester;
import org.springframework.boot.test.json.JsonContent;

import java.time.LocalDateTime;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

@JsonTest
public class LocalDateTimeTests {

    @Autowired
    private JacksonTester<LocalDateTime> json;

    @Test
    public void serialize__success() throws Exception {
        // given
        LocalDateTime dateTime = LocalDateTime.of(2024, 4, 29, 9, 30, 50);
        String dateTimeString = "\"2024-04-29T09:30:50\"";

        // when
        JsonContent<LocalDateTime> content = json.write(dateTime);

        // then
        assertThat(content).asString().isEqualTo(dateTimeString);
    }

    @Test
    public void deserialize_localDateTimeString_success() throws Exception {
        // given
        String dateTimeString = "\"2024-04-29T09:30:50\"";
        LocalDateTime dateTime = LocalDateTime.of(2024, 4, 29, 9, 30, 50);

        // when
        LocalDateTime parsed = json.parseObject(dateTimeString);

        // then
        assertThat(parsed).isEqualTo(dateTime);
    }

    @ParameterizedTest
    @ValueSource(strings = {"\"2024-04-29T09:30:50Z\"", "\"2024-04-29T09:30:50+01:00\""})
    public void deserialize_zonedDateTimeString_throwRuntimeException(String dateTimeString) throws Exception {
        // when & then
        assertThatThrownBy(() -> json.parseObject(dateTimeString))
            .isInstanceOf(RuntimeException.class);
    }
}
