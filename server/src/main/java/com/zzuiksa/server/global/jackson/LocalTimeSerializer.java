package com.zzuiksa.server.global.jackson;

import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import org.springframework.boot.jackson.JsonComponent;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

@JsonComponent
public class LocalTimeSerializer extends JsonSerializer<LocalTime> {

    @Override
    public void serialize(LocalTime localTime, JsonGenerator jsonGenerator,
            SerializerProvider serializerProvider) throws IOException {
        String formatted = localTime.format(DateTimeFormatter.ISO_LOCAL_TIME);
        jsonGenerator.writeString(formatted);
    }
}
