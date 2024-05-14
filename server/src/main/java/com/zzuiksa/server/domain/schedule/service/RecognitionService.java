package com.zzuiksa.server.domain.schedule.service;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.azure.ai.openai.OpenAIClient;
import com.azure.ai.openai.models.ChatChoice;
import com.azure.ai.openai.models.ChatCompletions;
import com.azure.ai.openai.models.ChatCompletionsJsonResponseFormat;
import com.azure.ai.openai.models.ChatCompletionsOptions;
import com.azure.ai.openai.models.ChatRequestMessage;
import com.azure.ai.openai.models.ChatRequestSystemMessage;
import com.azure.ai.openai.models.ChatRequestUserMessage;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.zzuiksa.server.domain.schedule.data.OpenAIScheduleRecognitionResponse;
import com.zzuiksa.server.domain.schedule.data.ScheduleRecognitionResponse;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RecognitionService {

    private static final String FULL_DAY_NAME = "FULLDAY";

    @Value("${api.openai.model}")
    private String model;

    private final OpenAIClient client;
    private final ObjectMapper objectMapper;

    public ScheduleRecognitionResponse recognize(String scheduleDescription, LocalDate baseDate) {
        ChatCompletions recognitions = getRecognitions(scheduleDescription, baseDate);
        OpenAIScheduleRecognitionResponse openaiResponse = getFirstResponseOrEmpty(recognitions);
        return convert(scheduleDescription, openaiResponse, baseDate);
    }

    private ChatCompletions getRecognitions(String scheduleDescription, LocalDate baseDate) {
        List<ChatRequestMessage> chatMessages = new ArrayList<>();
        chatMessages.add(getSystemMessage(baseDate));
        chatMessages.addAll(getExampleMessages());
        chatMessages.add(new ChatRequestUserMessage(scheduleDescription));

        ChatCompletionsOptions options = new ChatCompletionsOptions(chatMessages)
                .setResponseFormat(new ChatCompletionsJsonResponseFormat());

        return client.getChatCompletions(model, options);
    }

    private OpenAIScheduleRecognitionResponse getFirstResponseOrEmpty(ChatCompletions recognitions) {
        List<ChatChoice> choices = recognitions.getChoices();
        ChatChoice firstChoice = choices.get(0);
        String responseJson = firstChoice.getMessage().getContent();
        try {
            return objectMapper.readValue(responseJson, OpenAIScheduleRecognitionResponse.class);
        } catch (JsonProcessingException e) {
            return OpenAIScheduleRecognitionResponse.EMPTY;
        }
    }

    private ScheduleRecognitionResponse convert(String scheduleDescription,
            OpenAIScheduleRecognitionResponse recognition, LocalDate defaultDate) {
        /*
         * time이 없거나 duration이 FULLDAY인 경우: 하루 종일
         * time은 있지만 duration이 없는 경우 duration 1시간으로 처리
         */
        LocalDate recognizedDate = parseLocalDateOrDefault(recognition.getDate(), defaultDate);
        LocalTime recognizedTime = parseLocalTimeOrNull(recognition.getTime());
        boolean isFullDay = FULL_DAY_NAME.equals(recognition.getDuration());
        Duration recognizedDuration = parseDurationOrDefault(recognition.getDuration(), Duration.ofHours(1));

        ScheduleRecognitionResponse.ScheduleRecognitionResponseBuilder builder = ScheduleRecognitionResponse.builder()
                .title(scheduleDescription);

        if (recognition.getPlace() != null) {
            builder.placeName(recognition.getPlace());
        }

        if (recognizedTime == null || isFullDay) {
            builder.startDate(recognizedDate)
                    .endDate(recognizedDate);
        } else {
            LocalDateTime startDateTime = LocalDateTime.of(recognizedDate, recognizedTime);
            LocalDateTime endDateTime = startDateTime.plus(recognizedDuration);
            builder.startDate(startDateTime.toLocalDate())
                    .startTime(startDateTime.toLocalTime())
                    .endDate(endDateTime.toLocalDate())
                    .endTime(endDateTime.toLocalTime());
        }

        return builder.build();
    }

    private LocalDate parseLocalDateOrDefault(String localDate, LocalDate defaultDate) {
        if (localDate == null) {
            return defaultDate;
        }
        try {
            return LocalDate.parse(localDate);
        } catch (DateTimeParseException e) {
            return defaultDate;
        }
    }

    private LocalTime parseLocalTimeOrNull(String localTime) {
        if (localTime == null) {
            return null;
        }
        try {
            return LocalTime.parse(localTime);
        } catch (DateTimeParseException e) {
            return null;
        }
    }

    private Duration parseDurationOrDefault(String duration, Duration defaultDuration) {
        if (duration == null) {
            return defaultDuration;
        }
        Duration parsed = parseDuration(duration);
        if (parsed.isZero()) {
            return defaultDuration;
        } else {
            return parsed;
        }
    }

    private Duration parseDuration(String durationString) {
        Pattern durationPattern = Pattern.compile(
                "((?<D>\\d+?)[dD])? ?((?<H>\\d+?)[hH])? ?((?<M>\\d+?)[mM])? ?((?<S>\\d+?)[sS])?");
        Matcher matcher = durationPattern.matcher(durationString);

        if (!matcher.matches()) {
            return Duration.ZERO;
        }

        String[] suffixes = {"D", "H", "M", "S"};
        long[] secondsPerUnits = {24 * 60 * 60, 60 * 60, 60, 1};

        long seconds = 0L;
        for (int i = 0; i < suffixes.length; i++) {
            String suffix = suffixes[i];
            long secondsPerUnit = secondsPerUnits[i];

            String matched = matcher.group(suffix);
            int value = safeParseInt(matched);
            seconds += value * secondsPerUnit;
        }

        Duration duration = Duration.ofSeconds(seconds);
        return duration.truncatedTo(ChronoUnit.MINUTES);
    }

    private int safeParseInt(String s) {
        if (s == null) {
            return 0;
        }
        try {
            return (int)Float.parseFloat(s);
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private ChatRequestSystemMessage getSystemMessage(LocalDate baseDate) {
        LocalDateTime now = LocalDateTime.of(baseDate, getTime());
        String message = """
                당신은 일정 관리 비서입니다.
                사용자의 일정에서 일시, 장소를 찾아서 JSON 형식으로 응답합니다.
                정보가 존재하지 않는 항목은 null로 처리합니다.
                오늘은 %s, %s입니다.""".formatted(now, now.getDayOfWeek());
        return new ChatRequestSystemMessage(message);
    }

    private List<ChatRequestMessage> getExampleMessages() {
        final String[][] examples = new String[][] {
                {"이번주 목요일 저녁 8시에 친구랑 강남역 쿠우쿠우에서 1시간 40분간 저녁 먹기", """
                        {
                            "message": "이번주 목요일 저녁 8시에 친구랑 강남역 쿠우쿠우에서 1시간 40분간 저녁 먹기",
                            "date": "2024-05-11",
                            "time": "20:00:00",
                            "duration": "1H40M",
                            "place": "강남역 쿠우쿠우"
                        }"""},
                {"올해 8월 17일 하루 종일 우리 집에서 생일파티", """
                        {
                            "message": "올해 8월 17일 하루 종일 우리 집에서 생일파티",
                            "date": "2024-08-17",
                            "time": null,
                            "duration": "%s",
                            "place": 우리 집"
                        }""".formatted(FULL_DAY_NAME)}
        };
        List<ChatRequestMessage> messages = new ArrayList<>();
        for (String[] example : examples) {
            String userExample = example[0];
            String responseExample = example[1];
            messages.add(new ChatRequestUserMessage(userExample));
            messages.add(new ChatRequestSystemMessage(responseExample));
        }
        return messages;
    }

    private LocalTime getTime() {
        return LocalTime.now();
    }

}
