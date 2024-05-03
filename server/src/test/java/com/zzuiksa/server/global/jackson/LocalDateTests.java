package com.zzuiksa.server.global.jackson;

import static org.assertj.core.api.Assertions.*;

import java.time.LocalDate;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.json.JsonTest;
import org.springframework.boot.test.json.JacksonTester;
import org.springframework.boot.test.json.JsonContent;

@JsonTest
public class LocalDateTests {

    @Autowired
    private JacksonTester<LocalDate> json;

    @Test
    public void serialize__success() throws Exception {
        // given
        LocalDate date = LocalDate.of(2024, 4, 29);
        String dateString = "\"2024-04-29\"";

        // when
        JsonContent<LocalDate> content = json.write(date);

        // then
        assertThat(content).asString().isEqualTo(dateString);
    }

    @Test
    public void deserialize_localDateString_success() throws Exception {
        // given
        String dateString = "\"2024-04-29\"";
        LocalDate date = LocalDate.of(2024, 4, 29);

        // when
        LocalDate parsed = json.parseObject(dateString);

        // then
        assertThat(parsed).isEqualTo(date);
    }

    @ParameterizedTest
    @ValueSource(strings = {"\"2024-04-29Z\"", "\"2024-04-29+09:00\""})
    public void deserialize_zonedDateString_throwRuntimeException(String dateString) throws Exception {
        // when & then
        assertThatThrownBy(() -> json.parseObject(dateString))
                .isInstanceOf(RuntimeException.class);
    }
}
