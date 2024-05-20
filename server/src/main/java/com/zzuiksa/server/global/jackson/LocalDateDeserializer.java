package com.zzuiksa.server.global.jackson;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

import org.springframework.boot.jackson.JsonComponent;

import com.fasterxml.jackson.core.JacksonException;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;

@JsonComponent
public class LocalDateDeserializer extends JsonDeserializer<LocalDate> {

    @Override
    public LocalDate deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws
            IOException,
            JacksonException {
        String dateString = jsonParser.getValueAsString();
        try {
            return LocalDate.parse(dateString);
        } catch (DateTimeParseException ex) {
            throw new RuntimeException(ex);
        }
    }
}
