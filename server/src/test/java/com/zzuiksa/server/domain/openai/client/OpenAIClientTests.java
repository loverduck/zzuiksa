package com.zzuiksa.server.domain.openai.client;

import static org.assertj.core.api.Assertions.*;

import java.time.LocalDateTime;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

import com.azure.ai.openai.OpenAIClient;
import com.azure.ai.openai.models.ChatCompletions;
import com.azure.ai.openai.models.ChatCompletionsJsonResponseFormat;
import com.azure.ai.openai.models.ChatCompletionsOptions;
import com.azure.ai.openai.models.ChatRequestAssistantMessage;
import com.azure.ai.openai.models.ChatRequestMessage;
import com.azure.ai.openai.models.ChatRequestSystemMessage;
import com.azure.ai.openai.models.ChatRequestUserMessage;
import com.zzuiksa.server.global.config.OpenAIConfig;

@SpringBootTest
@ContextConfiguration(classes = OpenAIConfig.class)
public class OpenAIClientTests {

    @Value("${api.openai.model}")
    private String openaiModel;

    @Autowired
    private OpenAIClient openAIClient;

    @Test
    public void getChatCompletions_request_anySingleResponse() {
        // given
        List<ChatRequestMessage> chatMessages = List.of(
                new ChatRequestSystemMessage("당신은 무조건 한 글자로 대답합니다."),
                new ChatRequestUserMessage("안녕.")
        );
        ChatCompletionsOptions options = new ChatCompletionsOptions(chatMessages);

        // when
        ChatCompletions chatCompletions = openAIClient.getChatCompletions(openaiModel, options);

        // then
        assertThat(chatCompletions.getChoices()).hasSize(1);
        assertThat(chatCompletions.getChoices())
                .map(choice -> choice.getMessage().getContent())
                .allSatisfy(content -> assertThat(content).isNotBlank());

        chatCompletions.getChoices()
                .stream().map(choice -> choice.getMessage().getContent())
                .forEach(System.out::println);
    }

    @Test
    public void getChatCompletions_requestSummary_responseTimeAndPlace() {
        // given
        LocalDateTime now = LocalDateTime.of(2024, 5, 13, 11, 0, 0);
        String systemMessage = """
                당신은 일정 관리 비서입니다.
                사용자의 일정에서 일시, 장소를 찾아서 JSON 형식으로 응답합니다.
                정보가 존재하지 않는 항목은 null로 처리합니다.
                오늘은 %s, %s입니다.""".formatted(now, now.getDayOfWeek());
        String userMessageExample = "이번주 목요일 저녁 8시에 친구랑 강남역 쿠우쿠우에서 저녁 먹기";
        String chatResponseExample = """
                {
                    "message": "%s",
                    "time": "2024-05-11 20:00:00",
                    "place": "강남역 쿠우쿠우"
                }
                """.formatted(userMessageExample);
        String userMessage = "내일 아침에 인천 앞바다 조깅";
        List<ChatRequestMessage> chatMessages = List.of(
                new ChatRequestSystemMessage(systemMessage),
                new ChatRequestUserMessage(userMessageExample),
                new ChatRequestAssistantMessage(chatResponseExample),
                new ChatRequestUserMessage(userMessage)
        );
        ChatCompletionsOptions options = new ChatCompletionsOptions(chatMessages);
        options.setResponseFormat(new ChatCompletionsJsonResponseFormat());

        // when
        ChatCompletions chatCompletions = openAIClient.getChatCompletions(openaiModel, options);

        // then
        assertThat(chatCompletions.getChoices()).hasSize(1);
        assertThat(chatCompletions.getChoices())
                .map(choice -> choice.getMessage().getContent())
                .allSatisfy(content -> assertThat(content).isNotBlank());

        chatCompletions.getChoices()
                .stream().map(choice -> choice.getMessage().getContent())
                .forEach(System.out::println);
    }
}
