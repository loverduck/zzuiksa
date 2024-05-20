package com.zzuiksa.server.global.jackson;

import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;

import org.springframework.boot.jackson.JsonComponent;

import com.fasterxml.jackson.core.JacksonException;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;

@JsonComponent
public class LocalTimeDeserializer extends JsonDeserializer<LocalTime> {

    @Override
    public LocalTime deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws
            IOException,
            JacksonException {
        String timeString = jsonParser.getValueAsString();
        try {
            return LocalTime.parse(timeString);
        } catch (DateTimeParseException ex) {
            throw new RuntimeException(ex);
        }
    }
}
