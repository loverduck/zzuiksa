package com.zzuiksa.server.global.jackson;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;

import org.springframework.boot.jackson.JsonComponent;

import com.fasterxml.jackson.core.JacksonException;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;

@JsonComponent
public class LocalDateTimeDeserializer extends JsonDeserializer<LocalDateTime> {

    @Override
    public LocalDateTime deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws
            IOException,
            JacksonException {
        String dateTimeString = jsonParser.getValueAsString();
        try {
            return LocalDateTime.parse(dateTimeString);
        } catch (DateTimeParseException ex) {
            throw new RuntimeException(ex);
        }
    }
}
